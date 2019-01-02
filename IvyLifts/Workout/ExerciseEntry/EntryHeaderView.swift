//
//  EntryHeaderView.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit


class EntryHeaderView: UIView {
    
    weak var delegate: ExerciseDetailDelegate?
    
    let exerciseLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Foo"
        return lb
    }()
    
    var exerciseGoal: FitnessGoal? {
        didSet {
            guard let exerciseGoal = exerciseGoal else { return }
            
            let exerciseName = exerciseGoal.exercise
            let targetWeight = exerciseGoal.targetWeight
            let numReps = exerciseGoal.numReps
            let isAMRAP = exerciseGoal.isAMRAP
            
            
            
            let titleString = "\(exerciseName) (\(numReps) reps, \(targetWeight) lbs,"
            let attributedText = NSMutableAttributedString(string: titleString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
            if isAMRAP {
                attributedText.append(NSMutableAttributedString(string: " AMRAP", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.red]))
            }
            attributedText.append(NSMutableAttributedString(string: ")", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            
            self.exerciseLabel.attributedText = attributedText
            
            repsTextField.placeholder = "\(numReps)"
            weightTextField.placeholder = "\(targetWeight)"
        }
    }
    
    let repsTextField: UITextField = {
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: 70, height: 40))
        tf.textAlignment = .center
        tf.keyboardType = .asciiCapableNumberPad
        
        let lineSeperator = UIView()
        tf.addSubview(lineSeperator)
        lineSeperator.setHeight(constant: 0.5)
        lineSeperator.backgroundColor = .black
        lineSeperator.pinHorizontalSides(left: tf.leftAnchor, leftPadding: 0, right: tf.rightAnchor, rightPadding: 0)
        lineSeperator.pinTopAnchor(to: tf.bottomAnchor, padding: 0)
        
        
        return tf
    }()
    
    let repsLabel: UILabel = {
        let label = UILabel()
        label.text = "reps"
        return label
    }()
    
    let weightTextField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .center
        tf.keyboardType = .decimalPad

        let lineSeperator = UIView()
        tf.addSubview(lineSeperator)
        lineSeperator.setHeight(constant: 0.5)
        lineSeperator.backgroundColor = .black
        lineSeperator.pinHorizontalSides(left: tf.leftAnchor, leftPadding: 0, right: tf.rightAnchor, rightPadding: 0)
        lineSeperator.pinTopAnchor(to: tf.bottomAnchor, padding: 0)
        
        return tf
    }()
    
    let weightMeasurementLabel: UILabel = {
        let label = UILabel()
        label.text = "lbs"
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        button.layer.cornerRadius = 3
        button.backgroundColor = UIColor.lightGray
        button.isEnabled = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 10
        layer.borderWidth = 1
        addSubview(exerciseLabel)
        addSubview(addButton)
        
        exerciseLabel.pinTopAnchor(to: topAnchor, padding: 16)
        exerciseLabel.pinLeftAnchor(to: leftAnchor, padding: 16)
        
        let repsStackView = UIStackView(arrangedSubviews: [repsTextField, repsLabel])
        repsStackView.distribution = .fillProportionally
        repsStackView.axis = .horizontal
        repsTextField.setWidth(constant: 70)
        
        let weightStackView = UIStackView(arrangedSubviews: [weightTextField, weightMeasurementLabel])
        weightStackView.distribution = .fillProportionally
        weightStackView.axis = .horizontal
        weightTextField.setWidth(constant: 70)
        
        let inputStackView = UIStackView(arrangedSubviews: [repsStackView, weightStackView])
        inputStackView.distribution = .fillEqually
        inputStackView.axis = .vertical
        inputStackView.spacing = 16
        
        addSubview(inputStackView)
        inputStackView.pinLeftAnchor(to: leftAnchor, padding: 16)
        inputStackView.pinTopAnchor(to: exerciseLabel.bottomAnchor, padding: 32)
        inputStackView.pinRightAnchor(to: addButton.leftAnchor)
        inputStackView.pinBottomAnchor(to: bottomAnchor, padding: 16)
        
        addButton.setSize(width: 64, height: 64)
        addButton.pinBottomAnchor(to: bottomAnchor, padding: 16)
        addButton.pinRightAnchor(to: rightAnchor, padding: 16)
        
        // Target Actions
        repsTextField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        weightTextField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        addButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    }
    
    @objc func handleTextInput() {
        let isValidInput = repsTextField.text?.count ?? 0 > 0 && weightTextField.text?.count ?? 0 > 0
        
        if isValidInput {
            addButton.isEnabled = true
            addButton.backgroundColor = UIColor.darkGray
        } else {
            addButton.isEnabled = false
            addButton.backgroundColor = UIColor.lightGray
        }
    }
    
    @objc func handleButtonTap() {
        guard let numRepsString = repsTextField.text, let numReps = Int(numRepsString) else { return }
        guard let weightRecordedString = weightTextField.text, let weightRecorded = Double(weightRecordedString) else { return }
        delegate?.didAddEntry(reps: numReps, weight: weightRecorded)
        log.debug("Adding Entry!")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol ExerciseDetailDelegate: class {
    func didAddEntry(reps: Int, weight: Double)
}
