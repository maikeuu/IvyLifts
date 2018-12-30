//
//  WorkoutGoal.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/30/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation

/// Represents a single day workout, containing the fitness goals to reach for that workout
protocol Session {
    /// Exercises to do per day
    var exercises: [Goal] { get set }
    
    /// Date session was created
    var date: Date { get set }
}
