//
//  RequestBodyList.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import Foundation
import Alamofire

//Specific request bodies
//Request body for cards search
class GetCardsBody : RequestBody {
    var url: String = Constants.domainUrl + "/cards/search"
    var headers: [String : String]? = nil
    var parameters: Parameters? = nil
    var method: HTTPMethod? = .get
    var encoding: ParameterEncoding? = nil
    
    init (query: String) {
        parameters = ["q": "\(query)"]
    }
}
