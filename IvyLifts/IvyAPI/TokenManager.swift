//
//  TokenManager.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/23/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation
import JWT
/**
    Simple struct that stores the token as a string and decrypt's the token's payload, which will then be stored.
 
        ```
        The token has a payload with the form:
        {
          "email": "tester3@test.com"
          "userId": "5c1f46109ed6431278326099"
          "iat": 1545560839
          "exp": 1545564439
        }
        ```
*/
struct TokenManager {
    /// JWT Token, represented in the form of a string
    private(set) var token: String
    
    /// Email registered with the current account
    private(set) var email: String = ""
    
    /// Unique ID associated with the email address registered to the database
    private(set) var userId: String = ""
    
    /// Issue date of the token, in Unix Epoch time
    private(set) var issuedDate: UInt = 0
    
    /// Expiration date of the token, in Unix Epoch time
    private(set) var expirationDate: UInt = 0
    
    /// Computed property, determines whether or not token needs to be refreshed
    public var isTokenValid: Bool {
        return expirationDate > issuedDate
    }
    
    private init(token: String, email: String, userId: String, issueDate: UInt, expirationDate: UInt) {
        self.token = token
        self.email = email
        self.userId = userId
        self.issuedDate = issueDate
        self.expirationDate = expirationDate
    }
    
    public init?(token: String) {
        // Check if received a valid token
        if token.isEmpty {
            print("Invalid token passed!")
            return nil
        }
        
        self.token = token
        
        if let claims = decryptToken(token) {
            self.email = claims["email"] as? String ?? ""
            self.userId = claims["userId"] as? String ?? ""
            self.issuedDate = claims["iat"] as? UInt ?? 0
            self.expirationDate = claims["exp"] as? UInt ?? 0
            self = TokenManager(token: token, email: email, userId: userId, issueDate: issuedDate, expirationDate: expirationDate)
        } else {
            print("Init for Token Manager failed at decrypting!")
            return nil
        }
    }
    
    /// Util function that uses the JWT library to decode a token String and return it's payload
    private func decryptToken(_ token: String) -> ClaimSet? {
        do {
            let claims: ClaimSet = try JWT.decode(token, algorithm: .hs256("secret".data(using: .utf8)!))
            return claims
        } catch {
            print("Failed to decode JWT: \(error)")
        }
        return nil
    }
}

