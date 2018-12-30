//
//  Models.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/23/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation

/// Represents a single recorded set, containing information on the number of reps performed, weight recorded at,
/// exerciseName and entryDate
struct Entry {
    /// The name of the exercise performed
    let exercise: String
    
    /// The recorded weight in lbs, of the exercise performed
    var weightRecorded: Double
    
    /// Number of reps recorded for the set
    var repsRecorded: Int
    
    /// The day the entry was recorded
    let entryDate: Date
    
    init(exerciseName: String, weightRecorded: Double, repsRecorded: Int = 0, entryDate: Date = Date()) {
        self.exercise = exerciseName
        self.weightRecorded = weightRecorded
        self.repsRecorded = repsRecorded
        self.entryDate = entryDate
    }
}
