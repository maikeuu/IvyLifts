//
//  IvyBrain.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/30/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation
/**
     This class encapsulates the algorithm that will determine progress
        1. Take in personal records (Dependency Inject Personal Records)
        2. Calculate 1RM from personal records (Brzycki Formula (1RM = weight * (36 / (37 - r)))
        3. Generate fitness goals from those 1RM numbers (For every ORM, look at the session requirements and generate fitnessGoals for each day)
        4. Determine based on entries whether or not to progress
        5. Read from entries, have some sort of pub-sub/observer pattern notify when a session has been finished
        6. Progress accordingly if requirements have been met
*/
struct IvyBrain {
    
    /// The Personal Records of the user, used to calculate the ORM
    var personalRecords: PersonalRecords
    
    /// Exercises
//    /// 8 rep weight is 90% of 4 rep weight
//    let conversionFactor = 0.90

    
    var program: IvyLiftsProgramGenerator
    
    /// Personal records are measured in
    init(personalRecords: PersonalRecords) {
        self.personalRecords = personalRecords
        self.program = IvyLiftsProgramGenerator(
            benchFourRep: IvyBrain.calculateFourRep(oneRepMax: personalRecords.bench),
            squatFourRep: IvyBrain.calculateFourRep(oneRepMax: personalRecords.squat),
            shoulderPressFourRep: IvyBrain.calculateFourRep(oneRepMax: personalRecords.shoulderPress),
            deadliftFourRep: IvyBrain.calculateFourRep(oneRepMax: personalRecords.deadlift),
            pullUpsFourRep: IvyBrain.calculateFourRep(oneRepMax: personalRecords.pullUps),
            barbellRowFourRep: IvyBrain.calculateFourRep(oneRepMax: personalRecords.barbellRow)
        )
    }
    
    func oddWeek() -> Program {
        return program.oddWeek()
    }
    
    func evenWeek() -> Program {
        return program.evenWeek()
    }
    
    /// Uses the Brzycki Formula (1RM = weight * (36 / (37 - r))) to calculate the one rep max
    /// Debug method
    @discardableResult
    func calculateFourRep(oneRepMax: Double, exercise: String = "") -> Double {
        let fourRepWeight = oneRepMax / (36.0/33.0)
        log.info("Calculating for: \(exercise)")
        log.info("Four rep weight is \(fourRepWeight)")
        log.info("Eight rep weight would be \(fourRepWeight * 0.90)")
        return fourRepWeight
    }
    
    static func calculateFourRep(oneRepMax: Double) -> Double {
        return oneRepMax / (36.0/33.0)
    }
}

struct IvyLiftsProgramGenerator {
    
    /// Bench
    var benchFourRepWeight: Double
    
    /// Squat
    var squatFourRepWeight: Double
    
    /// ShoulderPress
    var shoulderPressFourRepWeight: Double
    
    /// Deadlift
    var deadliftFourRepWeight: Double
    
    /// Pull Ups
    var pullUpsFourRepWeight: Double
    
    /// Barbell Rows
    var barbellRowFourRepWeight: Double
    
    init(benchFourRep: Double, squatFourRep: Double, shoulderPressFourRep: Double, deadliftFourRep: Double, pullUpsFourRep: Double, barbellRowFourRep: Double) {
        self.benchFourRepWeight = benchFourRep
        self.squatFourRepWeight = squatFourRep
        self.shoulderPressFourRepWeight = shoulderPressFourRep
        self.deadliftFourRepWeight = deadliftFourRep
        self.pullUpsFourRepWeight = pullUpsFourRep
        self.barbellRowFourRepWeight = barbellRowFourRep
    }
    
    func oddWeek() -> Program {
        let sessions = [
            IvyLiftsSessionGenerator.createOddDaySession(benchFourRepWeight: self.benchFourRepWeight, squatFourRepWeight: self.squatFourRepWeight, shoulderPressFourRepWeight: self.shoulderPressFourRepWeight, pullUpsFourRepWeight: self.pullUpsFourRepWeight, isAMRAP: false),
            IvyLiftsSessionGenerator.createEvenDaySession(benchFourRepWeight: self.benchFourRepWeight, deadliftFourRepWeight: self.deadliftFourRepWeight, shoulderPressFourRepWeight: self.shoulderPressFourRepWeight, barbellRowsFourRepWeight: self.barbellRowFourRepWeight, isEvenWeek: false),
            IvyLiftsSessionGenerator.createOddDaySession(benchFourRepWeight: self.benchFourRepWeight, squatFourRepWeight: self.squatFourRepWeight, shoulderPressFourRepWeight: self.shoulderPressFourRepWeight, pullUpsFourRepWeight: self.pullUpsFourRepWeight, isAMRAP: true)
        ]
        return Program(sessions: sessions)
    }
    
    func evenWeek() -> Program {
        let sessions = [
            IvyLiftsSessionGenerator.createEvenDaySession(benchFourRepWeight: self.benchFourRepWeight, deadliftFourRepWeight: self.deadliftFourRepWeight, shoulderPressFourRepWeight: self.shoulderPressFourRepWeight, barbellRowsFourRepWeight: self.barbellRowFourRepWeight, isAMRAP: false, isEvenWeek: true),
            IvyLiftsSessionGenerator.createOddDaySession(benchFourRepWeight: self.benchFourRepWeight, squatFourRepWeight: self.squatFourRepWeight, shoulderPressFourRepWeight: self.shoulderPressFourRepWeight, pullUpsFourRepWeight: self.pullUpsFourRepWeight),
            IvyLiftsSessionGenerator.createEvenDaySession(benchFourRepWeight: self.benchFourRepWeight, deadliftFourRepWeight: self.deadliftFourRepWeight, shoulderPressFourRepWeight: self.shoulderPressFourRepWeight, barbellRowsFourRepWeight: self.barbellRowFourRepWeight, isAMRAP: true, isEvenWeek: false)
        ]
        return Program(sessions: sessions)
    }
}


/// This class creates each possible session
struct IvyLiftsSessionGenerator {
    
    static func createOddDaySession(benchFourRepWeight: Double, squatFourRepWeight: Double, shoulderPressFourRepWeight: Double, pullUpsFourRepWeight: Double, isAMRAP: Bool = false) -> Session {
        
        if isAMRAP {
            let exercises = [
                IvyLiftsGoalGenerator.createBenchFourRepGoal(benchFourRep: benchFourRepWeight, isAMRAP: isAMRAP),
                IvyLiftsGoalGenerator.createSquatFourRepGoal(squatFourRep: squatFourRepWeight, isAMRAP: isAMRAP),
                IvyLiftsGoalGenerator.createShoulderEightRepGoal(shoulderPressEightRep: shoulderPressFourRepWeight * 0.90),
                IvyLiftsGoalGenerator.createPullUpsFourRepGoal(pullUpsFourRep: pullUpsFourRepWeight)
                ]
            return Session(sessionName: "Day A AMRAP", exercises: exercises)
        } else {
            let exercises = [
                IvyLiftsGoalGenerator.createBenchFourRepGoal(benchFourRep: benchFourRepWeight, isAMRAP: isAMRAP),
                IvyLiftsGoalGenerator.createSquatEightRepGoal(squatEightRep: squatFourRepWeight * 0.90),
                IvyLiftsGoalGenerator.createShoulderEightRepGoal(shoulderPressEightRep: shoulderPressFourRepWeight * 0.90),
                IvyLiftsGoalGenerator.createPullUpsEightRepGoal(pullUpsEightRep: pullUpsFourRepWeight * 0.90)
            ]
            return Session(sessionName: "Day A", exercises: exercises)
        }
    }
    
    /// Creates an even day (bench, deadlift, barbellRow, shoulder)
    static func createEvenDaySession(benchFourRepWeight: Double, deadliftFourRepWeight: Double, shoulderPressFourRepWeight: Double, barbellRowsFourRepWeight: Double, isAMRAP: Bool = false, isEvenWeek: Bool) -> Session {
        
        if isAMRAP {
            let exercises = [
                IvyLiftsGoalGenerator.createBenchEightRepGoal(benchEightRep: benchFourRepWeight * 0.90),
                IvyLiftsGoalGenerator.createDeadliftFourRepGoal(deadliftFourRep: deadliftFourRepWeight, isAMRAP: isAMRAP),
                IvyLiftsGoalGenerator.createShoulderPressFourRepGoal(shoulderPressFourRep: shoulderPressFourRepWeight, isAMRAP: isAMRAP),
                IvyLiftsGoalGenerator.createBarbellRowEightRepGoal(barbellRowEightRep: barbellRowsFourRepWeight * 0.90)
            ]
            return Session(sessionName: "Day B AMRAP", exercises: exercises)
        } else {
            if isEvenWeek {
                let exercises = [
                    IvyLiftsGoalGenerator.createBenchEightRepGoal(benchEightRep: benchFourRepWeight * 0.90),
                    IvyLiftsGoalGenerator.createDeadliftEightRepGoal(deadliftEightRep: deadliftFourRepWeight * 0.90),
                    IvyLiftsGoalGenerator.createShoulderPressFourRepGoal(shoulderPressFourRep: shoulderPressFourRepWeight, isAMRAP: isAMRAP),
                    IvyLiftsGoalGenerator.createBarbellRowFourRepGoal(barbellRowFourRep: barbellRowsFourRepWeight)
                ]
                return Session(sessionName: "Day B", exercises: exercises)
            } else {
                let exercises = [
                    IvyLiftsGoalGenerator.createBenchEightRepGoal(benchEightRep: benchFourRepWeight * 0.90),
                    IvyLiftsGoalGenerator.createDeadliftFourRepGoal(deadliftFourRep: deadliftFourRepWeight),
                    IvyLiftsGoalGenerator.createShoulderPressFourRepGoal(shoulderPressFourRep: shoulderPressFourRepWeight, isAMRAP: isAMRAP),
                    IvyLiftsGoalGenerator.createBarbellRowEightRepGoal(barbellRowEightRep: barbellRowsFourRepWeight * 0.90)
                ]
                return Session(sessionName: "Day B", exercises: exercises)
            }
        }
    }
}

/// This struct takes in a personal record, modifies the numbers to return the target weight for either 4 rep sets or 8 rep sets
struct IvyLiftsGoalGenerator {
    
    static let benchPress = "Bench Press"
    static let squat = "Barbell Back Squat"
    static let shoulderPress = "Shoulder Press"
    static let pullUps = "Pull Ups"
    static let deadlift = "Deadlift"
    static let barbellRow = "Barbell Row"
    
    ///Bench
    static func createBenchFourRepGoal(benchFourRep: Double, isAMRAP: Bool = false) -> FitnessGoal{
        return FitnessGoal(exerciseName: benchPress, numSets: 4, numReps: 4, targetWeight: benchFourRep, isAMRAP: isAMRAP)
    }
    
    static func createBenchEightRepGoal(benchEightRep: Double) -> FitnessGoal {
        return FitnessGoal(exerciseName: benchPress, numSets: 4, numReps: 8, targetWeight: benchEightRep, isAMRAP: false)
    }
    
    // Squat
    static func createSquatFourRepGoal(squatFourRep: Double, isAMRAP: Bool = false) -> FitnessGoal {
        return FitnessGoal(exerciseName: squat, numSets: 4, numReps: 4, targetWeight: squatFourRep, isAMRAP: isAMRAP)
    }
    
    static func createSquatEightRepGoal(squatEightRep: Double) -> FitnessGoal {
        return FitnessGoal(exerciseName: squat, numSets: 4, numReps: 8, targetWeight: squatEightRep, isAMRAP: false)
    }
    
    // Shoulder
    static func createShoulderPressFourRepGoal(shoulderPressFourRep: Double, isAMRAP: Bool = false) -> FitnessGoal {
        return FitnessGoal(exerciseName: shoulderPress, numSets: 4, numReps: 4, targetWeight: shoulderPressFourRep, isAMRAP: isAMRAP)
    }
    
    static func createShoulderEightRepGoal(shoulderPressEightRep: Double) -> FitnessGoal {
        return FitnessGoal(exerciseName: shoulderPress, numSets: 4, numReps: 8, targetWeight: shoulderPressEightRep)
    }
    
    // Pullups
    static func createPullUpsFourRepGoal(pullUpsFourRep: Double) -> FitnessGoal {
        return FitnessGoal(exerciseName: pullUps, numSets: 4, numReps: 4, targetWeight: pullUpsFourRep, isAMRAP: false)
    }
    
    static func createPullUpsEightRepGoal(pullUpsEightRep: Double) -> FitnessGoal {
        return FitnessGoal(exerciseName: pullUps, numSets: 4, numReps: 8, targetWeight: pullUpsEightRep, isAMRAP: false)
    }
    
    // Barbell Row
    static func createBarbellRowFourRepGoal(barbellRowFourRep: Double) -> FitnessGoal {
        return FitnessGoal(exerciseName: barbellRow, numSets: 4, numReps: 4, targetWeight: barbellRowFourRep, isAMRAP: false)
    }
    
    static func createBarbellRowEightRepGoal(barbellRowEightRep: Double) -> FitnessGoal {
        return FitnessGoal(exerciseName: barbellRow, numSets: 4, numReps: 8, targetWeight: barbellRowEightRep, isAMRAP: false)
    }
    
    // Deadlift
    static func createDeadliftFourRepGoal(deadliftFourRep: Double, isAMRAP: Bool = false) -> FitnessGoal {
        return FitnessGoal(exerciseName: deadlift, numSets: 4, numReps: 4, targetWeight: deadliftFourRep, isAMRAP: isAMRAP)
    }
    
    static func createDeadliftEightRepGoal(deadliftEightRep: Double) -> FitnessGoal {
        return FitnessGoal(exerciseName: deadlift, numSets: 4, numReps: 8, targetWeight: deadliftEightRep, isAMRAP: false)
    }
}

