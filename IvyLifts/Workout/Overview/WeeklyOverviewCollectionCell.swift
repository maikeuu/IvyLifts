//
//  WeeklyOverviewCollectionCell.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class WeeklyOverviewCollectionCell: UICollectionViewCell {
    var model: Workout? {
        didSet {
            // TODO: - Refactor this LOL
            guard let model = model else { return }
            let exerciseOne = model.exercises[0]
            let exerciseTwo = model.exercises[1]
            let exerciseThree = model.exercises[2]
            let exerciseFour = model.exercises[3]
            
            exerciseOneNameLabel.text = exerciseOne.exerciseName
            exerciseTwoNameLabel.text = exerciseTwo.exerciseName
            exerciseThreeNameLabel.text = exerciseThree.exerciseName
            exerciseFourNameLabel.text = exerciseFour.exerciseName
            
            let goalOne = "\(exerciseOne.numReps) x \(exerciseOne.numSets) - \(exerciseOne.targetWeight) lbs"
            let goalTwo = "\(exerciseTwo.numReps) x \(exerciseTwo.numSets) - \(exerciseTwo.targetWeight) lbs"
            let goalThree = "\(exerciseThree.numReps) x \(exerciseThree.numSets) - \(exerciseThree.targetWeight) lbs"
            let goalFour = "\(exerciseFour.numReps) x \(exerciseFour.numSets) - \(exerciseFour.targetWeight) lbs"
            
            exerciseOneGoalLabel.text = goalOne
            exerciseTwoGoalLabel.text = goalTwo
            exerciseThreeGoalLabel.text = goalThree
            exerciseFourGoalLabel.text = goalFour
        }
    }
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Day A"
        lb.textAlignment = .center
        
        let lineSeperator = UIView()
        lineSeperator.backgroundColor = .black
        lb.addSubview(lineSeperator)
        lineSeperator.pinHorizontalSides(left: lb.leftAnchor, right: lb.rightAnchor)
        lineSeperator.pinTopAnchor(to: lb.bottomAnchor)
        lineSeperator.setHeight(constant: 0.5)
        
        
        return lb
    }()
    
    // Name Labels
    let exerciseOneNameLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    let exerciseTwoNameLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    let exerciseThreeNameLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    let exerciseFourNameLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    // Weight labels
    let exerciseOneGoalLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        return lb
    }()
    let exerciseTwoGoalLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        return lb
    }()
    let exerciseThreeGoalLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        return lb
    }()
    let exerciseFourGoalLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        return lb
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let stackOne = UIStackView(arrangedSubviews: [exerciseOneNameLabel, exerciseOneGoalLabel])
        stackOne.axis = .horizontal
        stackOne.distribution = .fillEqually
        let stackTwo = UIStackView(arrangedSubviews: [exerciseTwoNameLabel, exerciseTwoGoalLabel])
        stackTwo.axis = .horizontal
        stackTwo.distribution = .fillEqually
        let stackThree = UIStackView(arrangedSubviews: [exerciseThreeNameLabel, exerciseThreeGoalLabel])
        stackThree.axis = .horizontal
        stackThree.distribution = .fillEqually
        let stackFour = UIStackView(arrangedSubviews: [exerciseFourNameLabel, exerciseFourGoalLabel])
        stackFour.axis = .horizontal
        stackFour.distribution = .fillEqually
        
        // big stack is a Vertical Stackview containing the workouts
        let bigStack = UIStackView(arrangedSubviews: [stackOne, stackTwo, stackThree, stackFour])
        bigStack.axis = .vertical
        bigStack.distribution = .fillEqually
        
        addSubview(titleLabel)
        addSubview(bigStack)
        titleLabel.pinHorizontalSides(left: leftAnchor, right: rightAnchor)
        titleLabel.pinTopAnchor(to: topAnchor)
        titleLabel.setHeight(constant: 35)
        bigStack.pinVerticalSides(top: titleLabel.bottomAnchor, bottom: bottomAnchor)
        bigStack.pinHorizontalSides(left: leftAnchor, right: rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

