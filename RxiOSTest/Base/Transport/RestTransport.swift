//
//  RestTransport.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

//Class for alamofire api requests
class RestTransport {
    
    
    
    /// Calls api methods depending of some params
    /// - Parameters:
    ///   - type: Response struct type (Codable)
    ///   - url
    ///   - method
    ///   - parameters
    ///   - headers
    ///   - encoding
    ///   - completion: completion handler
    func callServerApi<T>(type: T.Type, url: String, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: [String: String]? = nil, encoding: ParameterEncoding = URLEncoding.default) -> Observable<T> where T: Codable {
        
        return Observable.create { observer in
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 30
                
            let request = manager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON(completionHandler:{ response in//validate(statusCode: [200]).responseJSON(completionHandler:{ response in
                switch response.result {
                case .success(let json):
                    let statusCode = response.response?.statusCode
                    if let json = json as? Dictionary<String, AnyObject>, let errorString = self.parseErrorJson(json: json) {
                        observer.onError(AppError(errorMessage: errorString))
                    } else if let code = statusCode, (200..<300).contains(code) {
                        JsonDecode.decodeJsonData(type: T.self, data: response.data!) { (res, err) in
                            if let err = err {
                                observer.onError(AppError(errorMessage: err.errorMessage))
                            } else if let res = res {
                                observer.onNext(res)
                                observer.onCompleted()
                            } else {
                                observer.onError(AppError(errorMessage: AppError.Unknown))
                            }
                        }
                    } else {
                        observer.onError(AppError(errorMessage: AppError.Unknown))
                    }
                case .failure(let error):
                    let error = (error as? URLError)?.code == .notConnectedToInternet || (error as? URLError)?.code == .timedOut ? AppError(errorMessage: AppError.NetworkProblem) : self.parseError(code:
                        response.response?.statusCode ?? -1)
                    observer.onError(error)
                }
            })
            
            return Disposables.create {
                request.cancel()
            }
        
        }
    }
    
    /// Sets AppError depending on response status code
    /// - Parameter code: reesponse status code
    private func parseError(code: Int) -> AppError {
        switch code {
        case 401:
            return AppError(errorMessage: AppError.Unauthorized)
        case 404:
            return AppError(errorMessage: AppError.NotFound)
        case 422:
            return AppError(errorMessage: AppError.NotFound)
        case 400..<500:
            return AppError(errorMessage: AppError.BadRequest)
        case 500..<600:
            return AppError(errorMessage: AppError.ServerInternal)
        default:
            return AppError(errorMessage: AppError.Unknown)
        }
    }
    
    /// parses json result and caches error response body
    /// - Parameter json: response json
    private func parseErrorJson(json: Dictionary<String, AnyObject>) -> String? {
        if json.keys.contains("details") {
            let index = json.index(forKey: "details")
            let value = json.values[index!] as? String
            return value
        }
        
        return nil
    }
}
