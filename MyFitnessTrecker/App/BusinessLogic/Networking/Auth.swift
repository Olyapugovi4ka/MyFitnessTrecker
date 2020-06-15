//
//  Auth.swift
//  DOShop
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import Alamofire

class Auth: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: SessionManager
    var queue: DispatchQueue?
    let baseUrl = URL(
        string: "http://localhost:8080")!

    init(errorParser: AbstractErrorParser,
         sessionManager: SessionManager,
         queue: DispatchQueue? = DispatchQueue.global(qos: .utility) ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Auth: AuthRequestFactory {
//    func login(userName: String, password: String, completionHandler: @escaping (DataResponse<LoginResult>) -> Void) {
//        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
//        self.request(request: requestModel, completionHandler: completionHandler)
//    }
//
//    func logout(completionHandler: @escaping (DataResponse<LogoutResult>) -> Void) {
//        let requestModel = LogoutStruct(baseUrl: baseUrl)
//        self.request(request: requestModel, completionHandler: completionHandler)
//    }
//
//    func register(userName: String,
//                  password: String,
//                  email: String,
//                  completionHandler: @escaping (DataResponse<RegisterResult>) -> Void) {
//        let requestModel = Registration(baseUrl: baseUrl, login: userName, password: password, email: email)
//
//        self.request(request: requestModel, completionHandler: completionHandler)
//    }

}

extension Auth {
//    struct Login: RequestRouter {
//        let baseUrl: URL
//        let method: HTTPMethod = .post
//        let path: String = "/auth/login"
//
//        let login: String
//        let password: String
//        var parameters: Parameters? {
//            return ["username" : login,
//                    "password": password]
//        }
//
//    }
//    
//    struct Registration: RequestRouter {
//      
//        let baseUrl: URL
//        let method: HTTPMethod = .post
//        let path: String = "/auth/register"
//        let login: String
//        let password: String
//        let email: String
//       
//        var parameters: Parameters? {
//            return [ "username": login,
//            "password": password,
//            "email": email ]
//        }
//
//    }
//    
//    struct LogoutStruct: RequestRouter {
//       
//        var baseUrl: URL
//        var method: HTTPMethod = .get
//        var path: String = "logout.json"
//
//        let idUser: Int = 123
//        var parameters: Parameters? {
//            return ["id_user": idUser]
//        }
//
//    }
}
