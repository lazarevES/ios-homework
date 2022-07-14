//
//  RealmCoordinator.swift
//  Navigation
//
//  Created by Егор Лазарев on 14.07.2022.
//

import Foundation
import RealmSwift 

final class RealmCoordinator {
    
    private let backgroundQueue = DispatchQueue(label: "RealmContext", qos: .background)
    private let mainQueue = DispatchQueue.main
    
    private func safeWrite(in realm: Realm, _ block: (() throws -> Void)) throws {
        realm.isInWriteTransaction
        ? try block()
        : try realm.write(block)
    }
}

extension RealmCoordinator: DatabaseCoordinatable {
  
    
    func create<T>(_ model: T.Type, keyedValues: [[String: Any]]) where T : Storable {
        do {
            let realm = try Realm()
            
            try self.safeWrite(in: realm) {
                guard let model = model as? Object.Type else {
                    return
                }
                
                var objects: [Object] = []
                keyedValues.forEach {
                    let object = realm.create(model, value: $0, update: .all)
                    objects.append(object)
                }
                
            }
        } catch {
            print(error.localizedDescription)
        }
    }
        
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping (Result<[T], DatabaseError>) -> Void) where T : Storable {
        do {
            let realm = try Realm()
            
            if let model = model as? Object.Type {
                var objects = realm.objects(model)
                if let predicate = predicate {
                    objects = objects.filter(predicate)
                }
                
                guard let results = Array(objects) as? [T] else {
                    completion(.failure(.wrongModel))
                    return
                }
                
                completion(.success(results))
            }
        } catch {
            completion(.failure(.error(desription: "Fail to fetch objects")))
        }
    }
        
    func delete<T>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping (Result<[T], DatabaseError>) -> Void) where T : Storable {
        do {
            let realm = try Realm()
            
            guard let model = model as? Object.Type else {
                completion(.failure(.wrongModel))
                return
            }
            
            let deletedObjects: Results<Object>
            if let predicate = predicate {
                deletedObjects = realm.objects(model).filter(predicate)
            } else {
                deletedObjects = realm.objects(model)
            }
                
            try self.safeWrite(in: realm) {
                realm.delete(deletedObjects)
                
                guard let results = Array(deletedObjects) as? [T] else {
                    completion(.success([]))
                    return
                }
                
                completion(.success(results))
            }
        } catch {
            completion(.failure(.error(desription: "Fail to delete object from storage")))
        }
    }
    
}
