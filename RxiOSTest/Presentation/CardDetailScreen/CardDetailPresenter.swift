//
//  CardDetailPresenter.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 11.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class CardDetailPresenter: BasePresenter<Void> {
    
    private var cardDetailInteractor: CardDetailInteractor {
        return interactor as! CardDetailInteractor
    }
    
    private var cardDetailRouter: CardDetailRouter {
        return router as! CardDetailRouter
    }
    
    private weak var cardDetailView: CardDetailViewController? {
        return view as? CardDetailViewController
    }
    
    let card = BehaviorRelay<Card?>(value: nil)
    
    var title: Driver<String>!
    var description: Driver<String>!
    var artist: Driver<String>!
    var image: Driver<String?>!
    
    required init(interactor: BaseInteractorType, router: BaseRouterType) {
        super.init(interactor: interactor, router: router)
        
        title = card.asObservable().map { $0?.name ?? "" }.asDriver(onErrorDriveWith: .empty())
        description = card.asObservable().map { $0?.oracleText ?? "" }.asDriver(onErrorDriveWith: .empty())
        artist = card.asObservable().map { $0?.artist ?? "" }.asDriver(onErrorDriveWith: .empty())
        image = card.asObservable().map { $0?.imageUris?.large ?? "" }.asDriver(onErrorDriveWith: .empty())
    }
    
    func pop() {
        cardDetailRouter.dismiss()
    }
}
