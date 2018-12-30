//
//  UserMetrics.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/30/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation
import RealmSwift

/// This struct represents the user's strength metrics for each of the IvySaur 4x4 lifts. The weight recorded
/// is in terms of their 1 rep max
class PersonalRecords: Object {
    @objc dynamic var bench: Double = 0.0
    @objc dynamic var squat: Double = 0.0
    @objc dynamic var deadlift: Double = 0.0
    @objc dynamic var shoulderPress: Double = 0.0
    @objc dynamic var barbellRow: Double = 0.0
    @objc dynamic var pullUps: Double = 0.0
}
