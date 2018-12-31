//
//  WeeklyRoutine.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/30/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation

/// Protocol that declares a program to be a set of workouts to be done in a given week.
struct Program {
    /// Name of the program being started
    var name: String //{ get set }
    
    /// List of Workouts to do on a weekly basis
    var sessions: [Session] //{ get }
    
    /// Starting date of the Program
    var startDate: Date //{ get set}
    
    init(name: String = "Ivysaur", sessions: [Session], startDate: Date = Date()) {
        self.name = name
        self.sessions = sessions
        self.startDate = startDate
    }
}
