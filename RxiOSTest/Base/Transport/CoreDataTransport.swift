//
//  CoreDataTransport.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 13.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

class CoreDataTransport {
    
    fileprivate func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext =
          appDelegate!.persistentContainer.viewContext
        
        return managedContext
    }
    
    func loadItems<T>(resultType: T.Type, entityName: String) -> Observable<[T]> {
        return Observable.create { observer in
            let managedContext = self.getContext()
            
            let fetchRequest =
              NSFetchRequest<NSManagedObject>(entityName: entityName)
            
            do {
                let result = try managedContext.fetch(fetchRequest) as? [T] ?? []
                observer.onNext(result)
                observer.onCompleted()
            } catch let error {
                print("Could not fetch. \(error), \(error.errorMessage)")
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func saveItems<T>(entityName: String, objects: [T?]? = []) -> Observable<Void> where T: Encodable {
        return Observable.create { observer in
            let managedContext = self.getContext()
            
            let dicts = objects?.compactMap({ encodable -> [String: Any]? in
                encodable?.dictionary
            })
            
            let insertRequest =
                NSBatchInsertRequest(entityName: entityName, objects: dicts ?? [])
            
            do {
                try managedContext.execute(insertRequest)
                observer.onNext(())
                observer.onCompleted()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            return Disposables.create()
        }
    }
}
