//
//  MainInteractor.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import Foundation
import RxSwift

class MainInteractor: BaseInteractor<Void> {
    func loadCards(requestBody: GetCardsBody) -> Observable<Cards> {
        return CardsService.loadCards(requestBody: requestBody)
    }
}
