//
//  User.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 22.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var login = ""
    @objc dynamic var password = ""
    
    override static func primaryKey() -> String? {
           return "login"
       }
}
