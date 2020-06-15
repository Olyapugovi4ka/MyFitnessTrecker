//
//  RequestFactory.swift
//  DOShop
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import Alamofire

protocol RequestFactoryProtocol {
    //func makeAuthRequestFactory() -> AuthRequestFactory
    
}

class RequestFactory: RequestFactoryProtocol {
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }

    lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let manager = SessionManager(configuration: configuration)
        return manager
    }()

    let sessionQueue = DispatchQueue.global(qos: .utility)

    //auth, register, logout
//    func makeAuthRequestFactory() -> AuthRequestFactory {
//        let errorParser = makeErrorParser()
//        return Auth(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
//    }

}
