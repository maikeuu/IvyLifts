//
//  WorkoutCollectionCell.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class WorkoutCollectionCell: UICollectionViewCell {
    
    var model: ExerciseGoal? {
        didSet {
            guard let model = model else { return }
            print(model)
            self.exerciseLabel.text = model.exerciseName
            self.weightLabel.text = "\(model.targetWeight) lbs"
            
            
            
            let targetNumberSetsString = "\(model.numSets) sets"
            let targetNumberRepsString = "| \(model.numReps) reps"
            
            var attributedString: NSMutableAttributedString?
            if model.isAMRAP {
                attributedString = NSMutableAttributedString(string: targetNumberSetsString, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                attributedString?.append(NSMutableAttributedString(string: targetNumberRepsString))
            } else {
                attributedString = NSMutableAttributedString(string: targetNumberSetsString + targetNumberRepsString)
            }
            self.targetSetsAndReps.attributedText = attributedString!
        }
    }
    
    let exerciseLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Squat"
        lb.backgroundColor = .cyan
        lb.textAlignment = .center
        return lb
    }()
    
    let weightLabel: UILabel = {
        let lb = UILabel()
        lb.backgroundColor = .blue
        lb.text = "225 lbs"
        lb.textAlignment = .center
        return lb
    }()
    
    let targetSetsAndReps: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        return lb
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let mainStackView = UIStackView(arrangedSubviews: [exerciseLabel, weightLabel, targetSetsAndReps])
        mainStackView.axis = .vertical
        mainStackView.spacing = 4
        mainStackView.distribution = .fillEqually
        
        addSubview(mainStackView)
        mainStackView.pinTopAnchor(to: topAnchor, padding: 4)
        mainStackView.pinHorizontalSides(left: leftAnchor, leftPadding: 4, right: rightAnchor, rightPadding: 4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

