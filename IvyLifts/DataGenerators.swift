//
//  DataGenerators.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/29/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation

// MARK- : Data Generators
struct WeeklyRoutineGenerator {
    static public func createOddWeek() -> WeeklyRoutine {
        return WeeklyRoutine(workouts: [WorkoutGenerator.createOddDay(), WorkoutGenerator.createEvenDay(), WorkoutGenerator.createAMRAPOddDay()])
    }
    
    static public func createEvenWeek() -> WeeklyRoutine {
        return WeeklyRoutine(workouts: [WorkoutGenerator.createEvenDay(), WorkoutGenerator.createOddDay(), WorkoutGenerator.createAMRAPEvenDay()])
    }
}

struct WorkoutGenerator {
    static public func createOddDay() -> Workout {
        return Workout(exercises: [ExerciseGoalGenerator.createBenchGoal(), ExerciseGoalGenerator.createSquatGoal(), ExerciseGoalGenerator.createShoulderPressGoal(), ExerciseGoalGenerator.createPullupsGoal()])
    }
    
    static public func createEvenDay() -> Workout {
        let exercises: [ExerciseGoal] = [ExerciseGoalGenerator.createBenchGoal(), ExerciseGoalGenerator.createDeadliftGoal(), ExerciseGoalGenerator.createShoulderPressGoal(), ExerciseGoalGenerator.createBarbellRowGoal()]
        return Workout(exercises: exercises)
    }
    
    static public func createAMRAPOddDay() -> Workout {
        return Workout(exercises: [ExerciseGoalGenerator.createAMRAPBenchGoal(), ExerciseGoalGenerator.createSquatGoal(),
                                   ExerciseGoalGenerator.createShoulderPressGoal(), ExerciseGoalGenerator.createAMRAPDeadliftGoal()])
    }
    
    static public func createAMRAPEvenDay() -> Workout {
        return Workout(exercises: [ExerciseGoalGenerator.createAMRAPBenchGoal(), ExerciseGoalGenerator.createSquatGoal(),
                                   ExerciseGoalGenerator.createShoulderPressGoal(), ExerciseGoalGenerator.createAMRAPDeadliftGoal()])
    }
}

struct ExerciseGoalGenerator {
    static public func createBenchGoal() -> ExerciseGoal {
        return ExerciseGoal(exerciseName: "Bench", numSets: 4, numReps: 8, targetWeight: 225)
    }
    
    static public func createAMRAPBenchGoal() -> ExerciseGoal {
        return ExerciseGoal(exerciseName: "Barbell Bench Press", numSets: 4, numReps: 4, targetWeight: 235, isAMRAP: true)
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
    
    static public func createBarbellRowGoal() -> ExerciseGoal {
        return ExerciseGoal(exerciseName: "Barbell Row", numSets: 4, numReps: 8, targetWeight: 155)
    }
    
    static public func createPullupsGoal() -> ExerciseGoal {
        return ExerciseGoal(exerciseName: "Pullups", numSets: 4, numReps: 8, targetWeight: 155)
    }
}
