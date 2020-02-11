//
//  RequestBody.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import Foundation
import Alamofire

//Base protocol for all request bodies
protocol RequestBody {
    var url: String {get set}
    var headers: [String: String]? {get set}
    var method: HTTPMethod? {get set}
    var parameters: Parameters? {get set}
    var encoding: ParameterEncoding? {get set}
}
