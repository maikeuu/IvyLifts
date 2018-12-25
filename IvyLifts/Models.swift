//
//  Models.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/23/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation


/// Represents a single day workout.
struct Workout {
    var exercises: [ExerciseGoal]
}
/// Represents the workouts to be done that week.
struct WeeklyRoutine {
    var workouts: [Workout]
}

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


// MARK- : Data Generators
struct WeeklyRoutineGenerator {
    static public func createWeek() -> WeeklyRoutine {
        return WeeklyRoutine(workouts: [WorkoutGenerator.createDay(), WorkoutGenerator.createDay(), WorkoutGenerator.createAMRAPDay()])
    }
}


struct WorkoutGenerator {
    static public func createDay() -> Workout {
        return Workout(exercises: [ExerciseGoalGenerator.createBenchGoal(), ExerciseGoalGenerator.createSquatGoal(), ExerciseGoalGenerator.createShoulderPressGoal(), ExerciseGoalGenerator.createDeadliftGoal()])
    }
    
    static public func createAMRAPDay() -> Workout {
        return Workout(exercises: [ExerciseGoalGenerator.createBenchGoal(), ExerciseGoalGenerator.createSquatGoal(),
                                   ExerciseGoalGenerator.createShoulderPressGoal(), ExerciseGoalGenerator.createAMRAPDeadliftGoal()])
    }
}




struct ExerciseGoalGenerator {
    static public func createBenchGoal() -> ExerciseGoal {
        return ExerciseGoal(exerciseName: "Bench", numSets: 4, numReps: 8, targetWeight: 225)
    }
    
    static public func createAMRAPBenchGoal() -> ExerciseGoal {
        return ExerciseGoal(exerciseName: "Bench", numSets: 4, numReps: 4, targetWeight: 235, isAMRAP: true)
    }
    
    static public func createSquatGoal() -> ExerciseGoal {
        return ExerciseGoal(exerciseName: "Squat", numSets: 4, numReps: 4, targetWeight: 315)
    }
    
    static public func createAMRAPSquatGoal() -> ExerciseGoal {
        return ExerciseGoal(exerciseName: "Squat", numSets: 4, numReps: 4, targetWeight: 335, isAMRAP: true)
    }
    
    static public func createDeadliftGoal() -> ExerciseGoal {
        return ExerciseGoal(exerciseName: "Deadlift", numSets: 4, numReps: 4, targetWeight: 345)
    }
    
    static public func createAMRAPDeadliftGoal() -> ExerciseGoal {
        return ExerciseGoal(exerciseName: "Deadlift", numSets: 4, numReps: 4, targetWeight: 435, isAMRAP: true)
    }
    
    static public func createShoulderPressGoal() -> ExerciseGoal {
        return ExerciseGoal(exerciseName: "Shoulder Press", numSets: 4, numReps: 8, targetWeight: 135)
    }
}
