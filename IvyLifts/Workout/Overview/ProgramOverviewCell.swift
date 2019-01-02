//
//  ProgramOverviewCell.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class ProgramOverviewCell: UICollectionViewCell {
    
    /// User has pressed the startWeek button, which should trigger changing the opacity of all the elements in the cell
    var isActive: Bool = false {
        didSet {
            if isActive {
                self.opacity = 1.0
            }
        }
    }
    
    var opacity: CGFloat = 0.75
    
    var model: Session? {
        didSet {
            // TODO: - Refactor this LOL
            guard let session = model else { return }
            self.titleLabel.text = session.sessionName
            
            let exerciseOne = session.fitnessGoals[0]
            let exerciseTwo = session.fitnessGoals[1]
            let exerciseThree = session.fitnessGoals[2]
            let exerciseFour = session.fitnessGoals[3]
            
            if exerciseOne.isAMRAP {
                exerciseOneNameLabel.attributedText = setupAttributedText(string: exerciseOne.exercise, color: UIColor.red, opacity: opacity)
            } else {
                exerciseOneNameLabel.attributedText = setupAttributedText(string: exerciseOne.exercise, color: UIColor.black, opacity: opacity)
            }
            
            if exerciseTwo.isAMRAP {
                exerciseTwoNameLabel.attributedText = setupAttributedText(string: exerciseTwo.exercise, color: UIColor.red, opacity: opacity)
            } else {
                exerciseTwoNameLabel.attributedText = setupAttributedText(string: exerciseTwo.exercise, color: UIColor.black, opacity: opacity)
            }
            
            if exerciseThree.isAMRAP {
                exerciseThreeNameLabel.attributedText = setupAttributedText(string: exerciseThree.exercise, color: UIColor.red, opacity: opacity)
            } else {
                exerciseThreeNameLabel.attributedText = setupAttributedText(string: exerciseThree.exercise, color: UIColor.black, opacity: opacity)
            }
            
            if exerciseFour.isAMRAP {
                exerciseFourNameLabel.attributedText = setupAttributedText(string: exerciseFour.exercise, color: UIColor.red, opacity: opacity)
            } else {
                exerciseFourNameLabel.attributedText = setupAttributedText(string: exerciseFour.exercise, color: UIColor.black, opacity: opacity)
            }
            
            let goalOne = "\(exerciseOne.numSets) x \(exerciseOne.numReps) - \(exerciseOne.targetWeight) lbs"
            let goalTwo = "\(exerciseTwo.numSets) x \(exerciseTwo.numReps) - \(exerciseTwo.targetWeight) lbs"
            let goalThree = "\(exerciseThree.numSets) x \(exerciseThree.numReps) - \(exerciseThree.targetWeight) lbs"
            let goalFour = "\(exerciseFour.numSets) x \(exerciseFour.numReps) - \(exerciseFour.targetWeight) lbs"
            
            exerciseOneGoalLabel.attributedText = setupAttributedText(string: goalOne, color: .black, opacity: opacity)
            exerciseTwoGoalLabel.attributedText = setupAttributedText(string: goalTwo, color: .black, opacity: opacity)
            exerciseThreeGoalLabel.attributedText = setupAttributedText(string: goalThree, color: .black, opacity: opacity)
            exerciseFourGoalLabel.attributedText = setupAttributedText(string: goalFour, color: .black, opacity: opacity)
        }
    }
    
    func setupAttributedText(string: String, color: UIColor, opacity: CGFloat) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: color.withAlphaComponent(opacity)]
        )
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
    let exerciseOneNameLabel = UILabel()
    let exerciseTwoNameLabel = UILabel()
    let exerciseThreeNameLabel = UILabel()
    let exerciseFourNameLabel = UILabel()
    
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
        layer.cornerRadius = 10
        backgroundColor = UIColor(white: 1.0, alpha: opacity)
        
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
        titleLabel.pinHorizontalSides(left: leftAnchor, leftPadding: 4, right: rightAnchor, rightPadding: 4)
        titleLabel.pinTopAnchor(to: topAnchor)
        titleLabel.setHeight(constant: 35)
        bigStack.pinVerticalSides(top: titleLabel.bottomAnchor, bottom: bottomAnchor)
        bigStack.pinHorizontalSides(left: leftAnchor, leftPadding: 4, right: rightAnchor, rightPadding: 4)
    }
    
    /// Done so that the exerciseNameLabels properly reset on deinitialization
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

