//
//  DataRequest.swift
//  DOShop
//
//  Created by MacBook on 12.04.2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    @discardableResult
    func responseCodable<T: Decodable>(
        errorParser: AbstractErrorParser,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self {

            let responseSerializer = DataResponseSerializer<T> { _, response, data, error in
                if let error = errorParser.parse(response: response, data: data, error: error) {
                    return .failure(error)
                }
                let result = Request.serializeResponseData(response: response, data: data, error: nil)
                switch result {
                case .success(let data):
                    do {
                        let value = try JSONDecoder().decode(T.self, from: data)
                        return .success(value)
                    } catch {
                        let customError = errorParser.parse(error)
                        return .failure(customError)
                    }
                case .failure(let error):
                    let customError = errorParser.parse(error)
                    return .failure(customError)
                }
                }
            return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

protocol AbstractRequestFactory {
    var errorParser: AbstractErrorParser { get }
    var sessionManager: SessionManager { get }
    var queue: DispatchQueue? { get }

    @discardableResult
    func request<T: Decodable> (request: URLRequestConvertible, completionHandler: @escaping(DataResponse<T>) -> Void) -> DataRequest

}

extension AbstractRequestFactory {
    @discardableResult
    public func request<T: Decodable> (request: URLRequestConvertible, completionHandler: @escaping(DataResponse<T>) -> Void) -> DataRequest {
        return sessionManager
            .request(request)
        .responseCodable(errorParser: errorParser, queue: queue, completionHandler: completionHandler)
    }
    
}
