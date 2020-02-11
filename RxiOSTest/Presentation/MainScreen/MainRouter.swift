//
//  MainRouter.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit

class MainRouter: BaseRouter {
    
    weak var transitionHandler: UIViewController?
    
    required init(_ transitionHandler: UIViewController) {
        self.transitionHandler = transitionHandler
    }
    
    func openCardDetail(card: Card) {
        _ = CardDetailViewController(nibName: "", bundle: nil)
        let cardDetailVC = UIStoryboard(name:"CardDetailScreen", bundle: nil).instantiateViewController(withIdentifier: "CardDetailViewController") as! CardDetailViewController
        let cardDetailPresenter = CardDetailPresenter(interactor: CardDetailInteractor(), router: CardDetailRouter(cardDetailVC))
        
        cardDetailPresenter.card.accept(card)
        
        cardDetailVC <~ cardDetailPresenter
        
        transitionHandler?.present(cardDetailVC, animated: true, completion: nil)
    }
}
