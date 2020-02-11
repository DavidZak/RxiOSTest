//
//  ViewBinding.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit
import RxCocoa

extension View where Self: UIViewController {
    func bindOnViewLoaded(to presenter: PresenterType) {
        _ = (self as UIViewController).rx.sentMessage(#selector(viewDidLoad)).take(1).subscribe{
            self.bind(to: presenter)
        }
    }
}

infix operator <~ : binding

precedencegroup binding {
    associativity: none
}

func <~<V>(view: V, presenter: V.PresenterType) where V: UIViewController, V: View {
    bind(view: view, presenter: presenter)
}

func bind<V>(view: V, presenter: V.PresenterType) where V: UIViewController, V: View {
    view.bindOnViewLoaded(to: presenter)
}
