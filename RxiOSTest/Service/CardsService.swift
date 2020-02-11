//
//  CardsService.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import Foundation
import RxSwift

//Service for cards data
class CardsService: Service {
    /// Load cards data
    /// - Parameters:
    /// - requestBody: GetCardsBody
    static func loadCards(requestBody: GetCardsBody) -> Observable<Cards> {
        return callServerApiWithResponse(resultType: Cards.self, requestBody: requestBody)
    }
}
