//
//  OneRepCalculator.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/30/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation

extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

/// This class calculates the one rep max of a specific exercise given the number of reps lifted at a given weight
struct OneRepCalculator {
    /// Uses the Brzycki Formula (1RM = weight * (36 / (37 - r))) to calculate the one rep max
    static func calculate(reps: Double, weight: Double) -> Double {
        let ORM = weight * (36.0 / (37.0 - reps))
        log.info("ORM is: \(ORM)")
        return ORM.truncate(places: 2)
    }
}
