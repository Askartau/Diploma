//
//  UIImageView+Extension.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/11/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func set(image:UIImage?) {
        self.layer.masksToBounds = true
        self.contentMode = .scaleAspectFit
        self.image = image
    }
}

extension UIImageView {
    
    private static var taskKey = 0
    private static var urlKey = 0
    
    private var currentTask: URLSessionTask? {
        get { return objc_getAssociatedObject(self, &UIImageView.taskKey) as? URLSessionTask }
        set { objc_setAssociatedObject(self, &UIImageView.taskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var currentURL: URL? {
        get { return objc_getAssociatedObject(self, &UIImageView.urlKey) as? URL }
        set { objc_setAssociatedObject(self, &UIImageView.urlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    
    func loadImageAsync(with urlString: String?, indicator:UIActivityIndicatorView? = nil) {
        // cancel prior task, if any
        
        weak var oldTask = currentTask
        currentTask = nil
        oldTask?.cancel()
        
        // reset imageview's image
        
        self.image = nil
        
        // allow supplying of `nil` to remove old image and then return immediately
        
        guard let urlString = urlString else { return }
        
        // check cache
        
        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            self.image = cachedImage
            return
        }
        
        // download
        
        if let url = URL(string: urlString) {
            currentURL = url
            indicator?.startAnimating()
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                self?.currentTask = nil
                
                //error handling
                
                if let error = error {
                    // don't bother reporting cancelation errors
                    
                    if (error as NSError).domain == NSURLErrorDomain && (error as NSError).code == NSURLErrorCancelled {
                        return
                    }
                    
                    //                    print(error)
                    return
                }
                
                guard let data = data, let downloadedImage = UIImage(data: data) else {
                    //                    print("unable to extract image")
                    self?.image = #imageLiteral(resourceName: "warning")
                    indicator?.stopAnimating()
                    return
                }
                
                ImageCache.shared.save(image: downloadedImage, forKey: urlString)
                
                if url == self?.currentURL {
                    DispatchQueue.main.async {
                        indicator?.stopAnimating()
                        self?.image = downloadedImage
                    }
                }
            }
            
            // save and start new task
            
            currentTask = task
            task.resume()
        }
    }
    
}

fileprivate class ImageCache {
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol!
    
    static let shared = ImageCache()
    
    private init() {
        // make sure to purge cache on memory pressure
        
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] notification in
            self?.cache.removeAllObjects()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(observer)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
