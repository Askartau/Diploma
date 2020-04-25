//
//  PickerButton.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/25/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import IQKeyboardManagerSwift
import RxCocoa
import RxSwift

enum PickerType {
    case standart
    case withImage
}

class PickerButton: UIControl {
    
    open var onUpdateCodePicker:(() -> Void)?
    
    fileprivate let titleColor = UIColor.black.withAlphaComponent(0.4)
    fileprivate let color = UIColor.black.withAlphaComponent(0.4)
    fileprivate let titleFont = UIFont.regular(size: 12)
    fileprivate let font = UIFont.regular(size: 17)
    fileprivate let errorColor = UIColor.red
    fileprivate let errorFont = UIFont.regular(size: 11)
    var disposeBag = DisposeBag()
    var index = BehaviorRelay<Int?>(value: nil)
    var key: String?
    
    open var titleHidden = true
    open var errorMessage = ""
    var onDidSelect: ((Int?)->())?
    var options: [Any] = []
    var onTopController: UIViewController?
    
    var title: String! {
        didSet {
            titleLabel.text = title
            
        }
    }
    var placeholder: String! {
        didSet {
            value = placeholder
            pickerLabel.textColor = color
        }
    }
    var value: String! {
        didSet {
            if oldValue != nil {
                titleLabel.isHidden = false
            }
            pickerLabel.text = value
            pickerLabel.textColor = .black
        }
    }
    
    var image: UIImage? {
        didSet {
            iconImageView.image = image
        }
    }
    
    var hideTitle:Bool = false {
        didSet {
            titleLabel.isHidden = hideTitle
        }
    }
    
    fileprivate lazy var placeholderValue: String = ""
    fileprivate lazy var didLoad = false
    fileprivate var topConstraint: Constraint!
    fileprivate var leftConstraint: Constraint!
    fileprivate var rightConstraint: Constraint!
    fileprivate var bottomConstraint: Constraint!
    
    fileprivate lazy var iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = titleColor
        label.font = titleFont
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    fileprivate lazy var pickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
//        button.addTarget(self, action: #selector(openPicker), for: .touchUpInside)
        return button
    }()
    fileprivate lazy var pickerLabel: UILabel = {
        let label = UILabel()
        label.textColor = color
        label.font = font
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    fileprivate lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = errorColor
        label.font = titleFont
        return label
    }()
    
    fileprivate lazy var underline : UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.fromRgb(rgb: 0xEBEBEB)
        
        return view
    }()
    
    fileprivate var arrowIcon = UIImageView()
    
    private var type:PickerType = .standart
    
    init() {
        super.init(frame: .zero)
    }
    
    convenience init(type: PickerType = .standart) {
        self.init()
        self.type = type
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Methods
extension PickerButton {
    
    func isEmpty() -> Bool {
        if index.value == nil {
            showError("empty_error".localized)
            return true
        } else {
            return false
        }
    }
    
    func showError(_ error: String) {
        errorLabel.text = error
        errorLabel.isHidden = false
        errorLabel.sizeToFit()
        pickerButton.layer.borderColor = errorColor.cgColor
        pickerButton.layer.borderWidth = 5
    }
    
    func hideError() {
        errorLabel.isHidden = true
        pickerButton.layer.borderColor = UIColor.clear.cgColor
        pickerButton.layer.borderWidth = 0
    }
    
    
    func setDisabled(_ disable: Bool = true) {
        if disable{
            hideError()
        }
        arrowIcon.isHidden = disable
        pickerButton.backgroundColor = .clear
        let offset: CGFloat = titleHidden ? 0 : 20
        topConstraint.update(offset: disable ? 5 : offset)
        leftConstraint.update(offset: disable ? 0 : 12)
        rightConstraint.update(offset: disable ? -8 : -40)
        bottomConstraint.update(offset: disable ? 0 : -12)
        self.isUserInteractionEnabled = !disable
    }
    
    func cleanValue(){
        value = placeholder
        titleLabel.text = title
        self.options = [String]()
    }
    
}

//MARK: - ConfigUI
extension PickerButton {
    fileprivate func configUI() {
        arrowIcon.set(image: #imageLiteral(resourceName: "down_arrow"))
        isUserInteractionEnabled = true
  //      addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPicker)))
        
        switch type {
        case .standart:
            makeConstraintsForStandart()
        case .withImage:
            makeConstraintsForImage()
        }
    }
    
    func makeConstraintsForStandart() {
        addSubview(titleLabel)
        addSubview(pickerLabel)
        addSubview(errorLabel)
        addSubview(arrowIcon)
        addSubview(underline)
        
        arrowIcon.snp.makeConstraints { m in
            m.right.equalToSuperview().offset(-2)
            m.centerY.equalTo(pickerLabel)
            m.width.height.lessThanOrEqualTo(14)
        }
        
        titleLabel.snp.makeConstraints { m in
            m.top.left.equalToSuperview()
            m.right.equalToSuperview().offset(-20)
        }
        
        pickerLabel.snp.makeConstraints { m in
            m.top.equalTo(titleLabel.snp.bottom).offset(4)
            m.left.equalToSuperview()
            m.right.equalToSuperview().offset(-20)
        }
        
        underline.snp.makeConstraints { (m) in
            m.left.right.equalToSuperview()
            m.top.equalTo(pickerLabel.snp.bottom).offset(10)
            m.height.equalTo(1.0)
            m.bottom.equalToSuperview().offset(-10)
        }
        
        errorLabel.snp.makeConstraints { m in
            m.top.equalTo(underline.snp.bottom).offset(2)
            m.left.right.equalToSuperview()
            m.bottom.equalToSuperview()
        }
    }
    
    func makeConstraintsForImage() {
        addSubview(iconImageView)
        addSubview(errorLabel)
        addSubview(pickerLabel)
        addSubview(arrowIcon)
        
        arrowIcon.snp.makeConstraints { m in
            m.width.height.equalTo(12)
            m.right.equalToSuperview().offset(-2)
            m.centerY.equalTo(pickerLabel)
        }
        
        iconImageView.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            m.left.equalToSuperview()
            m.width.height.equalTo(20)
        }
        
        pickerLabel.snp.makeConstraints { m in
            m.top.equalToSuperview()
            m.left.equalTo(iconImageView.snp.right).offset(10)
            m.right.lessThanOrEqualTo(arrowIcon.snp.left).offset(-4)
            m.bottom.equalToSuperview()
        }
    }
}
