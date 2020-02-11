//
//  GlobalDefinitions.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit

class Constants {
    static let apiHost = "api.scryfall.com"
    static let domainUrl = "https://\(apiHost)"
    static let MaxImageCacheSize: UInt = 50 * 1024 * 1024
    static let MaxImageCachePeriod: TimeInterval = 60 * 60 * 24 * 7
}
