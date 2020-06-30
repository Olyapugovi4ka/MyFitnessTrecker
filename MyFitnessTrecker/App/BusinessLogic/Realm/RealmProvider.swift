//
//  RealmProvider.swift
//  VKDakhelOlga
//
//  Created by MacBook on 16/06/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation
import RealmSwift

class RealmProvider {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func save<T: Object>(item: T,
                                configuration: Realm.Configuration = deleteIfMigration,
                                update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
        //for searching file on the device
        //        print(realm.configuration.fileURL!)
        try realm.write {
            realm.add(item, update: update)
        }
    }
    
    static func saveNewValue<T: Object>(item: T,
                                        value: String,
                                        key: String,
                                        configuration: Realm.Configuration = deleteIfMigration,
                                        update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write {
            
            item
        }
    }
    static func get<T: Object>(_ type: T.Type,
                               configuration: Realm.Configuration = deleteIfMigration) throws -> Results<T> {
        let realm = try Realm(configuration: configuration)
        return realm.objects(type)
    }
    
    static func delete<T: Object>(item: T,
                                  configuration: Realm.Configuration = deleteIfMigration,
                                  update: Realm.UpdatePolicy = .modified) throws{
        let realm = try Realm(configuration: configuration)
        try realm.write {
            realm.delete(item)
        }
    }
}

