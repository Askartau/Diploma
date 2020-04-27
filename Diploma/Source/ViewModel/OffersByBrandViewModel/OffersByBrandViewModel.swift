//
//  OffersByBrandViewModel.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/25/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class OffersByBrandViewModel {
    
    //    var brandsText: [BrandContainer] = []
    //    var brandsContainer = BehaviorRelay<BrandContainer?>(value: nil)
    var offers: [Offers] = []
    var offersContainer = BehaviorRelay<OffersContainer?>(value: nil)
    
    
    private let disposeBag = DisposeBag()
    
    
    func getOffers(_ success: @escaping(OffersContainer) -> Void, _ failure: @escaping failure) {
        getOffersApi()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                
                guard let wSelf = self else { return }
                
                wSelf.offersContainer.accept(response)
                
                success(response)
                }, onError: { error in
                    failure(error.handleError())
            }).disposed(by: self.disposeBag)
    }
    
    func getOffersApi() -> Observable<OffersContainer>  {
        return ApiClient.shared.loadAsObservable(ApiRouter.getOffers)
    }
    
}
