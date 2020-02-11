//
//  CardDetailRouter.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 11.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit

class CardDetailRouter: BaseRouter {
    
    weak var transitionHandler: UIViewController?
    
    required init(_ transitionHandler: UIViewController) {
        self.transitionHandler = transitionHandler
    }
    
    func dismiss() {
        transitionHandler?.dismiss(animated: true, completion: nil)
    }
}
