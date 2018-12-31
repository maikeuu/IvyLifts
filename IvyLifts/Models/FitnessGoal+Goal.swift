//
//  ExerciseGoal.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/30/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation

/// Protocol that defines the requirements for a workout in a session
protocol Goal {
    var exercise: String { get }
    var numSets: Int { get  }
    var numReps: Int { get  }
    var targetWeight: Double { get }
}

/// Represents an exercise, how many sets and reps you want to do, at what target weight.
/// Used in the Session Struct to define what goals should be met that week in accordance to the program.
struct FitnessGoal: Goal {
    
    /// Name of the exercise
    let exercise: String
    
    /// Number of sets needed to perform for this exercise
    let numSets: Int
    
    /// Number of reps to perform per set
    let numReps: Int
    
    /// Weight to perform the exercise at
    let targetWeight: Double
    
    /// As Many Reps As Possible set on the last set
    let isAMRAP: Bool
    
    public init(exerciseName: String, numSets: Int, numReps: Int, targetWeight: Double, isAMRAP: Bool = false) {
        self.exercise = exerciseName
        self.numSets = numSets
        self.numReps = numReps
        self.targetWeight = targetWeight.truncate(places: 2)
        self.isAMRAP = isAMRAP
    }
}
