//
//  AppError.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import Foundation

//Application error implementation
class AppError : Error {
    
    var errorMessage: String
    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    static let Unknown = "Unknown error"
    static let NetworkProblem = "Network problem"
    static let ServerInternal = "Server internal error"
    static let Unauthorized = "Authorization required"
    static let NotFound = "Data not found"
    static let BadRequest = "Bad request"
}

extension Error {
    var errorMessage: String {
        guard let appError = self as? AppError else {
            return self.localizedDescription
        }
        return appError.errorMessage
    }
}
