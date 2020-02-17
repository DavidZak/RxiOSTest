//
//  CardsService.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

//Service for cards data
class CardsService: Service {
    /// Load cards data
    /// - Parameters:
    /// - requestBody: GetCardsBody
    static func synchronizeCards(requestBody: GetCardsBody) -> Observable<Void> {
        return callServerApiWithResponse(resultType: Cards.self, requestBody: requestBody)
            .flatMap { cards -> Observable<Void> in
                saveCards(cards: cards.data)
        }
    }
    
    ///todo для получения списка из core data, доделать
    static func loadCards() -> Observable<[Card]> {
        return loadEntities(resultType: NSManagedObject.self, entityName: "CardEntity").flatMap { (managedObjects) -> Observable<[Card]> in
            return Observable.create { observer in
                    
                var cards = [Card] ()
                cards = managedObjects.map { mapCardEntityToCard(cardEntity: $0) }
                observer.onNext(cards)
                observer.onCompleted()
                
                return Disposables.create()
                
            }
        }
    }
    
    static func saveCards(cards: [Card]?) -> Observable<Void> {
        return saveEntities(entityName: "CardEntity", objects: cards)
    }
    
    static func mapCardEntityToCard(cardEntity: NSManagedObject) -> Card {
        var card = Card()
        card.id = cardEntity.value(forKey: "id") as? String
        card.name = cardEntity.value(forKey: "name") as? String
        card.oracleText = cardEntity.value(forKey: "oracle_text") as? String
        card.artist = cardEntity.value(forKey: "artist") as? String
        return card
    }
}
