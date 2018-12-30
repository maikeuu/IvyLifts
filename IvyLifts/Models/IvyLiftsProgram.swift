//
//  IvyLiftsProgram.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/30/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation

/// Implementation of all the protocols defined for Ivysaur
struct IvysaurWeekA: Program {
    var name = "Ivysaur Week A"
    
    var sessions: [Session]
    
    var startDate: Date
}

struct IvySessionA: Session {
    var exercises: [Goal]
    
    var date: Date
    
    
}

