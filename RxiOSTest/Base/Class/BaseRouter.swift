//
//  BaseRouter.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit
import RxSwift

protocol BaseRouter: Router {
    var transitionHandler: UIViewController? {get}
    init(_ transitionHandler: UIViewController)
}

extension BaseRouter {
    func back() {
        _ = transitionHandler?.navigationController?.popViewController(animated: true)
    }
}
