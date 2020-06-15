//
//  ErrorParser.swift
//  DOShop
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import Foundation

class ErrorParser: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return result
    }

    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }

}
