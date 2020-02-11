//
//  BasePresenter.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit
import RxSwift

enum Progress {
    case Loading
    case LoadCompleted
}

class BasePresenter<T>: Presenter {
    
    typealias BaseViewType = BaseViewController<T>
    weak var view: BaseViewType?
    
    typealias BaseInteractorType = BaseInteractor<T>
    var interactor: BaseInteractorType
    
    typealias BaseRouterType = BaseRouter
    var router: BaseRouterType
    
    lazy var disposeBag = DisposeBag()
    
    var progress: PublishSubject<Progress> = PublishSubject<Progress>()
    var error: PublishSubject<Error> = PublishSubject<Error>()
    
    required init(interactor: BaseInteractorType, router: BaseRouterType) {
        self.interactor = interactor
        self.router = router
    }
    
    func dispose(_ disposable: Disposable) {
        disposeBag.addDisposable(disposable)
    }
}

