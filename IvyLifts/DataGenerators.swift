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
    static public func createOddWeek() -> Program {
        return Program(sessions: [WorkoutGenerator.createOddDay(), WorkoutGenerator.createEvenDay(), WorkoutGenerator.createAMRAPOddDay()])
    }
    
    static public func createEvenWeek() -> Program {
        return Program(sessions: [WorkoutGenerator.createEvenDay(), WorkoutGenerator.createOddDay(), WorkoutGenerator.createAMRAPEvenDay()])
    }
}

struct WorkoutGenerator {
    static public func createOddDay() -> Session {
        return Session(exercises: [ExerciseGoalGenerator.createBenchGoal(), ExerciseGoalGenerator.createSquatGoal(), ExerciseGoalGenerator.createShoulderPressGoal(), ExerciseGoalGenerator.createPullupsGoal()])
    }
    
    static public func createEvenDay() -> Session {
        let exercises: [FitnessGoal] = [ExerciseGoalGenerator.createBenchGoal(), ExerciseGoalGenerator.createDeadliftGoal(), ExerciseGoalGenerator.createShoulderPressGoal(), ExerciseGoalGenerator.createBarbellRowGoal()]
        return Session(exercises: exercises)
    }
    
    static public func createAMRAPOddDay() -> Session {
        return Session(exercises: [ExerciseGoalGenerator.createAMRAPBenchGoal(), ExerciseGoalGenerator.createSquatGoal(),
                                   ExerciseGoalGenerator.createShoulderPressGoal(), ExerciseGoalGenerator.createAMRAPDeadliftGoal()])
    }
    
    static public func createAMRAPEvenDay() -> Session {
        return Session(exercises: [ExerciseGoalGenerator.createAMRAPBenchGoal(), ExerciseGoalGenerator.createSquatGoal(),
                                   ExerciseGoalGenerator.createShoulderPressGoal(), ExerciseGoalGenerator.createAMRAPDeadliftGoal()])
    }
}

struct ExerciseGoalGenerator {
    static public func createBenchGoal() -> FitnessGoal {
        return FitnessGoal(exerciseName: "Bench", numSets: 4, numReps: 8, targetWeight: 225)
    }
    
    static public func createAMRAPBenchGoal() -> FitnessGoal {
        return FitnessGoal(exerciseName: "Barbell Bench Press", numSets: 4, numReps: 4, targetWeight: 235, isAMRAP: true)
    }
    
    static public func createSquatGoal() -> FitnessGoal {
        return FitnessGoal(exerciseName: "Squat", numSets: 4, numReps: 4, targetWeight: 315)
    }
    
    static public func createAMRAPSquatGoal() -> FitnessGoal {
        return FitnessGoal(exerciseName: "Squat", numSets: 4, numReps: 4, targetWeight: 335, isAMRAP: true)
    }
    
    static public func createDeadliftGoal() -> FitnessGoal {
        return FitnessGoal(exerciseName: "Deadlift", numSets: 4, numReps: 4, targetWeight: 345)
    }
    
    static public func createAMRAPDeadliftGoal() -> FitnessGoal {
        return FitnessGoal(exerciseName: "Deadlift", numSets: 4, numReps: 4, targetWeight: 435, isAMRAP: true)
    }
    
    static public func createShoulderPressGoal() -> FitnessGoal {
        return FitnessGoal(exerciseName: "Shoulder Press", numSets: 4, numReps: 8, targetWeight: 135)
    }
    
    static public func createBarbellRowGoal() -> FitnessGoal {
        return FitnessGoal(exerciseName: "Barbell Row", numSets: 4, numReps: 8, targetWeight: 155)
    }
    
    static public func createPullupsGoal() -> FitnessGoal {
        return FitnessGoal(exerciseName: "Pullups", numSets: 4, numReps: 8, targetWeight: 155)
    }
}
