//
//  ProgramOverviewCell.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class ProgramOverviewCell: UICollectionViewCell {
    var model: Session? {
        didSet {
            // TODO: - Refactor this LOL
            guard let session = model else { return }
            let exerciseOne = session.fitnessGoals[0]
            let exerciseTwo = session.fitnessGoals[1]
            let exerciseThree = session.fitnessGoals[2]
            let exerciseFour = session.fitnessGoals[3]
            
            if exerciseOne.isAMRAP {
                let attributedText = NSMutableAttributedString(string: exerciseOne.exercise, attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor: UIColor.red]
                )
                log.error("\(exerciseOne.exercise) is AMRAP: \(exerciseOne.isAMRAP)")
                exerciseOneNameLabel.attributedText = attributedText
            } else {
                exerciseOneNameLabel.text = exerciseOne.exercise
            }
            
            if exerciseTwo.isAMRAP {
                let attributedText = NSMutableAttributedString(string: exerciseTwo.exercise, attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor: UIColor.red]
                )
                log.error("\(exerciseTwo.exercise) is AMRAP: \(exerciseTwo.isAMRAP)")
                exerciseTwoNameLabel.attributedText = attributedText
            } else {
                exerciseTwoNameLabel.text = exerciseTwo.exercise
            }
            
            if exerciseThree.isAMRAP {
                let attributedText = NSMutableAttributedString(string: exerciseThree.exercise, attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor: UIColor.red]
                )
                log.error("\(exerciseThree.exercise) is AMRAP: \(exerciseThree.isAMRAP)")
                exerciseThreeNameLabel.attributedText = attributedText
            } else {
                exerciseThreeNameLabel.text = exerciseThree.exercise
            }
            
            if exerciseFour.isAMRAP {
                let attributedText = NSMutableAttributedString(string: exerciseFour.exercise, attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor: UIColor.red]
                )
                log.error("\(exerciseFour.exercise) is AMRAP: \(exerciseFour.isAMRAP)")
                exerciseFourNameLabel.attributedText = attributedText
            } else {
                exerciseFourNameLabel.text = exerciseFour.exercise
                
            }
            
            let goalOne = "\(exerciseOne.numSets) x \(exerciseOne.numReps) - \(exerciseOne.targetWeight) lbs"
            let goalTwo = "\(exerciseTwo.numSets) x \(exerciseTwo.numReps) - \(exerciseTwo.targetWeight) lbs"
            let goalThree = "\(exerciseThree.numSets) x \(exerciseThree.numReps) - \(exerciseThree.targetWeight) lbs"
            let goalFour = "\(exerciseFour.numSets) x \(exerciseFour.numReps) - \(exerciseFour.targetWeight) lbs"
            
            exerciseOneGoalLabel.text = goalOne
            exerciseTwoGoalLabel.text = goalTwo
            exerciseThreeGoalLabel.text = goalThree
            exerciseFourGoalLabel.text = goalFour
        }
    }
    
    let titleLabel: UILabel = {
        let lb = UILabel()
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
        
        layer.cornerRadius = 10
        
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
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bigStack)
        titleLabel.pinHorizontalSides(left: leftAnchor, leftPadding: 4, right: rightAnchor, rightPadding: 4)
        titleLabel.pinTopAnchor(to: topAnchor)
        titleLabel.setHeight(constant: 35)
        bigStack.pinVerticalSides(top: titleLabel.bottomAnchor, bottom: bottomAnchor)
        bigStack.pinHorizontalSides(left: leftAnchor, leftPadding: 4, right: rightAnchor, rightPadding: 4)
    }
    
    override func prepareForReuse() {
        exerciseOneNameLabel.text = ""
        exerciseTwoNameLabel.text = ""
        exerciseThreeNameLabel.text = ""
        exerciseFourNameLabel.text = ""
        super.prepareForReuse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

