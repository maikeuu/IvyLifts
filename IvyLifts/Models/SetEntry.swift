//
//  Models.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/23/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation

/// Represents a single exercise done, the date recorded, number of sets done and number of reps per set
struct SetEntry {
    let exerciseName: String
    var weightRecorded: Double
    var repsRecorded: Int
    
    init(exerciseName: String, weightRecorded: Double, repsRecorded: Int = 0) {
        self.exerciseName = exerciseName
        self.weightRecorded = weightRecorded
        self.repsRecorded = repsRecorded
    }
    
    mutating func updateWeightRecorded(weight: Double) {
        self.weightRecorded = weight
    }
    
    mutating func updateRepsRecorded(reps: Int) {
        self.repsRecorded = reps
        log.debug("Method being called!")
        log.debug(self)
    }
}
