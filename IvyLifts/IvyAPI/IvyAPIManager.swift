//
//  APIManager.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/22/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation
import Alamofire

/// This class acts as a facade to simplify the common API calls used throughout the application.
class IvyAPIManager {
    
    private var sessionRepo: TokenManager?
    
    public init(repo: TokenManager) {
        self.sessionRepo = repo
    }
}
