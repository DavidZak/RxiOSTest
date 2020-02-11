//
//  JsonDecode.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import Foundation

//For decoding Data with JsonDecoder
class JsonDecode {
    
    /// Decodes data to specified Type (Codable)
    /// - Parameters:
    ///   - type: result type
    ///   - data: input data
    ///   - completion: completion handler
    static func decodeJsonData<T>(type: T.Type, data: Data, completion: @escaping (_ result: T?, _ error: Error?) -> Void) where T: Codable {
        let jsonDecoder = JSONDecoder()
        do {
            let resp = try jsonDecoder.decode(T.self, from: data)
            completion(resp, nil)
        } catch let err {
            completion(nil, err)
        }
    }
}
