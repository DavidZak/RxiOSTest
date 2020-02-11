//
//  SplashViewController.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit
import RxSwift

class SplashScreenViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doAfter(delayInSec: 3, action: {
            self.goTo()
        })
    }
    
    func goTo() {
        goToMainScreen()
    }
    
    private func goToMainScreen() {
        _ = MainViewController(nibName: "", bundle: nil)
        let mainNC = UIStoryboard(name:"MainScreen", bundle: nil).instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        let mainVC = mainNC.topViewController as! MainViewController
        mainVC <~ MainPresenter(interactor: MainInteractor(), router: MainRouter(mainVC))
        
        UIApplication.shared.keyWindow?.rootViewController = mainNC
    }
    
    //private let disposeBag = DisposeBag()
}
