//
//  File.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController<T>: UIViewController {
    typealias BasePresenterType = BasePresenter<T>
    var presenter: BasePresenterType!
    
    func onLoading() { onShowProgress() }
    
    func onLoadCompleted() { onHideProgress() }
    
    func onAfterBinding() {}
    
    func onConfigure() {}
    
    func onError(_ error: AppError) {
        onLoadCompleted()
        showSimpleAlert(message: error.errorMessage)
    }
    
    func onShowProgress() { showPreloaderView() }
    
    func onHideProgress() { hidePreloaderView() }
    
    func dispose(_ disposable: Disposable) {
        disposeBag.addDisposable(disposable)
    }
    
    lazy var disposeBag = DisposeBag()
}

extension BaseViewController: View {
    
    func bind(to presenter: BasePresenterType) {
        self.presenter = presenter
        self.presenter.view = self
        
        subscribeOnError()
        subscribeOnProgress()
        
        onConfigure()
        onAfterBinding()
    }
    
    private func subscribeOnError() {
        dispose(presenter!.error.subscribe(onNext: {
            [weak self] error in
            let `error` = error as? AppError ?? AppError(errorMessage: AppError.Unknown)
            self?.onError(error)
        }))
    }
    
    private func subscribeOnProgress() {
        dispose(presenter!.progress.subscribe(onNext: {
            [weak self] progress in
            self?.onProgress(progress)
        }))
    }
}

extension BaseViewController {
    fileprivate func onProgress(_ progress: Progress) {
        switch progress {
        case .Loading: onLoading()
        case .LoadCompleted: onLoadCompleted()
        }
    }
}
