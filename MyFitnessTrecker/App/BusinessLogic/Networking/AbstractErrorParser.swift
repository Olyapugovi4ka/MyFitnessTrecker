//
//  AbstractErrorParser.swift
//  DOShop
//
//  Created by MacBook on 12.04.2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
