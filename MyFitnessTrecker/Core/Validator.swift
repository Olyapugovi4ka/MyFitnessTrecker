//
//  Validator.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 25.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import Foundation

class Validator {
    
    static func isFilled(login: String?, password: String?) -> Bool {
        guard !(login ?? "").isEmpty, !(password ?? "").isEmpty else {
            return false
        }
        return true
    }
    
    static func isEmail(email: String) -> Bool {
        let emailRedEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRedEx)
    }
    
    public static func check(text: String, regEx: String) -> Bool {
       let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
           return predicate.evaluate(with: text)
       }
    
    static func isPasswordConfirmed (enteredPassword: String, passwordFromServer: String) -> Bool {
        guard enteredPassword == passwordFromServer else {
            return false }
        return true
    }
    
    static func isPasswordLengthIsRight(password: String) -> Bool {
        guard password.count >= 6 else { return false }
        return true
    }
 
}

