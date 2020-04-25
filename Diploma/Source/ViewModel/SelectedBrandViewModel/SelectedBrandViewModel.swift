//
//  SelectedBrandViewModel.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/23/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation

import Foundation
import RxSwift
import RxCocoa

class SelectedBrandViewModel {
    
//    var brandsText: [BrandContainer] = []
//    var brandsContainer = BehaviorRelay<BrandContainer?>(value: nil)
    var cars: [Cars] = []
    var carsContainer = BehaviorRelay<CarsContainer?>(value: nil)
    
    
    private let disposeBag = DisposeBag()
    
    
    func getCars(_ success: @escaping(CarsContainer) -> Void, _ failure: @escaping failure) {
        getCarsApi()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                
                guard let wSelf = self else { return }
                
                wSelf.carsContainer.accept(response)
                
                success(response)
                }, onError: { error in
                    failure(error.handleError())
            }).disposed(by: self.disposeBag)
    }
    
    func getCarsApi() -> Observable<CarsContainer>  {
        return ApiClient.shared.loadAsObservable(ApiRouter.getCars)
    }
    
}
