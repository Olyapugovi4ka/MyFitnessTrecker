//
//  ErrorParser.swift
//  DOShop
//
//  Created by MacBook on 12.04.2020.
//  Copyright © 2020 MacBook. All rights reserved.
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
