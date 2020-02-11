//
//  MainPresenter.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class MainPresenter: BasePresenter<Void> {
    
    private var mainInteractor: MainInteractor {
        return interactor as! MainInteractor
    }
    
    private var mainRouter: MainRouter {
        return router as! MainRouter
    }
    
    private weak var mainView: MainViewController? {
        return view as? MainViewController
    }
    
    let cards = BehaviorRelay<[Card]>(value: [])
    
    required init(interactor: BaseInteractorType, router: BaseRouterType) {
        super.init(interactor: interactor, router: router)
    }
    
    func loadCards(query: String) {
        
        progress.onNext(.Loading)
        
        dispose(mainInteractor.loadCards(requestBody: GetCardsBody(query: query))
            .subscribe(onNext: { [weak self] cards in
                self?.progress.onNext(.LoadCompleted)
                self?.cards.accept(cards.data!)
            }, onError: { [weak self] error in
                self?.error.onNext(error)
            })
        )
    }
    
    func goToCardDetail(at index: Int) {
        mainRouter.openCardDetail(card: self.cards.value[index])
    }
    
}
