//
//  Service.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

//Base services protocol
protocol ServiceProtocol: RestService {}

class Service: ServiceProtocol {}

//Protocol for rest api requests
protocol RestService{}
extension RestService {
    /// Calls rest transport method
    /// - Parameters:
    ///   - resultType: resultType (Codable)
    ///   - requestBody: api request body
    ///   - completion: completion handler
    static func callServerApiWithResponse<T: Codable>(resultType: T.Type, requestBody: RequestBody) -> Observable<T> {
        return RestTransport().callServerApi(type: T.self, url: requestBody.url, method: requestBody.method ?? .get, parameters: requestBody.parameters, headers: requestBody.headers, encoding: requestBody.encoding ?? URLEncoding.default)
    }
}
