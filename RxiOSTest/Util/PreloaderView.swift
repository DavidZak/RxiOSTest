//
//  PreloaderView.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 11.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit

class PreloaderView: UIView {
    static let shared: PreloaderView = PreloaderView()

    init() {
        super.init(frame: UIScreen.main.bounds)
        
        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.center = center
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
