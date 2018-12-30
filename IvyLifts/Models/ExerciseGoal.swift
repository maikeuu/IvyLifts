//
//  ExerciseGoal.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/30/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation

/// Represents an exercise, how many sets and reps you want to do, at what target weight.
struct ExerciseGoal {
    let exerciseName: String
    let numSets: Int
    let numReps: Int
    let targetWeight: Double
    let isAMRAP: Bool
    
    init(exerciseName: String, numSets: Int, numReps: Int, targetWeight: Double, isAMRAP: Bool = false) {
        self.exerciseName = exerciseName
        self.numSets = numSets
        self.numReps = numReps
        self.targetWeight = targetWeight
        self.isAMRAP = isAMRAP
    }
}
