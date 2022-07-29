//
//  RealmCoordinator.swift
//  Navigation
//
//  Created by Егор Лазарев on 14.07.2022.
//
import Foundation
import RealmSwift
import KeychainAccess

final class RealmCoordinator {
    
    private let backgroundQueue = DispatchQueue(label: "RealmContext", qos: .background)
    private let mainQueue = DispatchQueue.main
    
    private func safeWrite(in realm: Realm, _ block: (() throws -> Void)) throws {
        realm.isInWriteTransaction
        ? try block()
        : try realm.write(block)
    }
    
    func getConfigDataBase() -> Realm.Configuration {
        let key = getRealmKey()
        let config = Realm.Configuration(encryptionKey: key)
        return config
    }
    
    func getRealmKey() -> Data {
        
        let keychain = Keychain(service: "TheBestRealmCrypt")
        do {
            if let key = try keychain.getData("RealmKey") {
               return key
            } else {
                var key = Data(count: 64)
                _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
                    SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)}
                try keychain.set(key, key: "RealmKey")
                return key
            }
            
        } catch let error {
            print(error)
            return Data()
        }
    }
    
}

extension RealmCoordinator: RealmDatabaseCoordinatable {
  
    func create<T>(_ model: T.Type, keyedValues: [[String: Any]]) where T : Storable {
        let config = getConfigDataBase()
        do {
            let realm = try Realm(configuration: config)
            
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
        let config = getConfigDataBase()
        do {
            let realm = try Realm(configuration: config)
            
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
        let config = getConfigDataBase()
        do {
            let realm = try Realm(configuration: config)
            
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
