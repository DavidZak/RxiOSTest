//
//  RxExtension.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import RxSwift

extension DisposeBag {
    func addDisposable(_ disposable: Disposable) {
        disposable.disposed(by: self)
    }
}
