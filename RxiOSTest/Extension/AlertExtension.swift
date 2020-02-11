//
//  AlertExtension.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 11.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit

extension UIViewController {
    func showSimpleAlert(title: String? = "", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok".localized, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
