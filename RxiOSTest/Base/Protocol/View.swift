//
//  View.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit

protocol View {
    associatedtype PresenterType: Presenter
    func bind(to presenter: PresenterType)
}
