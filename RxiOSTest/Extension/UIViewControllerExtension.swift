//
//  UIViewControllerExtension.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 11.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//
import UIKit

extension UIViewController {
    func showPreloaderView() {
        self.view.addSubview(PreloaderView.shared)
    }
    
    func hidePreloaderView() {
        PreloaderView.shared.removeFromSuperview()
    }
}
