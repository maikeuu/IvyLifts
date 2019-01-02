//
//  WorkoutGoal.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/30/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation

/// Represents a single day workout, containing the fitness goals to reach for that workout
struct Session {
    /// Exercises to do per day
    var fitnessGoals: [FitnessGoal] //{ get }
    
    /// Date session was created
    var date: Date = Date() //{ get }
    
    let sessionName: String
    
    init(sessionName: String, exercises: [FitnessGoal], date: Date = Date()) {
        self.sessionName = sessionName
        self.fitnessGoals = exercises
        self.date = date
    }
}
