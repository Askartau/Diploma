//
//  BrandsListViewModel.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/6/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BrandsListViewModel {
    
    var brandsText: [BrandsList] = []
    var brandsList = BehaviorRelay<[BrandContainer]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    
    func getBrandsList(_ success: @escaping() -> Void, _ failure: @escaping failure) {
        getBrandsListApi()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in

                guard let wSelf = self else { return }

                wSelf.brandsList.accept(response)

                success()
                }, onError: { error in
                    failure(error.handleError())
            }).disposed(by: self.disposeBag)
    }
    
    func getBrandsListApi() -> Observable<[BrandContainer]>  {
        return ApiClient.shared.loadAsObservable(ApiRouter.getBrandsList)
    }
    
}
