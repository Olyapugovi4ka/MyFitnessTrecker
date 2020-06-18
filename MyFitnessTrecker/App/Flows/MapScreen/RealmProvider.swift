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
    
    static func save<T: Object>(items: [T],
                                configuration: Realm.Configuration = deleteIfMigration,
                                update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
//        print(realm.configuration.fileURL!)
        try realm.write {
            realm.add(items, update: update)
        }
    }
    
    static func get<T: Object>(_ type: T.Type,
                               configuration: Realm.Configuration = deleteIfMigration) throws -> Results<T> {
        let realm = try Realm(configuration: configuration)
        return realm.objects(type)
    }
    
    static func delete<T: Object>(items: T,
                                  configuration: Realm.Configuration = deleteIfMigration,
                                  update: Realm.UpdatePolicy = .modified) throws{
        let realm = try Realm(configuration: configuration)
        try realm.write {
            realm.delete(items)
        }
    }
}
 
