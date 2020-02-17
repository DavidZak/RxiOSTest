//
//  EncodableExtension.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 17.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
