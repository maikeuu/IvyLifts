//
//  IvyAuth.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/23/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation
import Alamofire

/// This protocol defines a contract between the Authentication service of IvyAPI and this application.
/// It contains the methods that make calls to IvyAPI-Auth, which are the only routes in the API that do not require token-access.
protocol IvyAPIAuthProtocol {
    
    /// Sends a POST request to Login with username and password credentials
    /// - Returns: A string representing the token that was passed back as a server response
    func login(email: String, password: String, completionHandler: @escaping (String?) -> Void)
    
    /// Sends a POST request to Sign up, inputting a username and password.
    /// - Returns: True if sign up was successful, false otherwise
    func signUp(email: String, password: String, completionHandler: @escaping (Bool) -> Void)
    
    /// Sends a DELETE request to delete the current account.
    /// - Returns: True if account is deleted, false otherwise
    func deleteAccount(userID: String, completionHandler: @escaping (Bool) -> Void)
}

class IvyAPIAuthorizer: IvyAPIAuthProtocol {
    
    /// The base url that hosts the IvyAPI services, without a back-slash specified e.g. http://localhost:3000
    let hostName: String
    
    public init(hostName: String = "http://localhost:3000") {
        self.hostName = hostName
    }
    
    /// POST request to /user/login
    internal func login(email: String, password: String, completionHandler: @escaping (String?) -> Void) {
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        let endPoint = self.hostName + "/user/login"
        Alamofire.request(endPoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            #if DEBUG
                debugPrint(response)
            #endif
            
            if let json = response.result.value as? [String: Any], let token = json["token"] as? String {
                completionHandler(token)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    /// POST request to /user/signup
    internal func signUp(email: String, password: String, completionHandler: @escaping (Bool) -> Void) {
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        let endPoint = self.hostName + "/user/signup"
        Alamofire.request(endPoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            #if DEBUG
            debugPrint(response)
            #endif
        }
    }
    
    /// DELETE request to /user/:id
    internal func deleteAccount(userID: String, completionHandler: @escaping (Bool) -> Void) {
//        let parameters: Parameters = ["]
        let endPoint = self.hostName + "/user/delete/" + userID
        Alamofire.request(endPoint, method: .delete).responseJSON { (response) in
            #if DEBUG
            debugPrint(response)
            #endif
        }
    }
}
