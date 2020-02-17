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
import CoreData

//Base services protocol
//protocol ServiceProtocol: RestService {}

class Service: RestService, CoreDataService {}

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

//Protocol for core data
protocol CoreDataService{}
extension CoreDataService {
    static func loadEntities<T>(resultType: T.Type, entityName: String) -> Observable<[T]> {
        return CoreDataTransport().loadItems(resultType: resultType, entityName: entityName)
    }
    
    static func saveEntities<T>(entityName: String, objects: [T?]? = []) -> Observable<Void> where T: Encodable {
        return CoreDataTransport().saveItems(entityName: entityName, objects: objects)
    }
}
