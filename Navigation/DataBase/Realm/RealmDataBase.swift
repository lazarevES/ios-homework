//
//  RealmData.swift
//  Navigation
//
//  Created by Егор Лазарев on 14.07.2022.
//
import Foundation
import RealmSwift

extension Object: Storable {}

protocol RealmDatabaseCoordinatable {
    /// Создание объекта заданного типа.
    func create<T: Storable>(_ model: T.Type, keyedValues: [[String: Any]])
    /// Удаление объектов заданного типа с помощью предиката.
    func delete<T: Storable>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping (Result<[T], DatabaseError>) -> Void)
    /// Получение объектов заданного типа c помощью предиката.
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping (Result<[T], DatabaseError>) -> Void)
    
}
