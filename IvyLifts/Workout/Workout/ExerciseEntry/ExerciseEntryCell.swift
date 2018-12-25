//
//  ExerciseEntryCell.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

protocol ExerciseEntryDelegate: class {
//    func updateEntry(new entry: SetEntry, at index: Int)
    func updateNumberOfReps(reps: Int, at index: Int)
}

class ExerciseEntryCell: UICollectionViewCell {
    
    weak var delegate: ExerciseEntryDelegate?
    
    var setNumber: Int? {
        didSet {
            guard let setNumber = setNumber else { return }
            setNumberLabel.text = "Set \(setNumber)"
        }
    }
    
    var numRepsGoal: Int? {
        didSet {
            guard let numReps = numRepsGoal else { return }
            numRepsTextfield.text = "\(numReps)"
        }
    }
    
    var targetWeight: Double? {
        didSet {
            guard let weight = targetWeight else { return }
            weightPerformedTextField.text = "\(weight)"
        }
    }
    
    var setEntry: SetEntry! {
        didSet {
            log.debug("Set entry set!")
        }
    }
    
    let setNumberLabel: UILabel = {
        let lb = UILabel()
        lb.backgroundColor = .red
        return lb
    }()
    
    let numRepsTextfield: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .orange
        tf.keyboardType = .asciiCapableNumberPad
        tf.textAlignment = .right
        return tf
    }()
    
    @objc func handleChangeNumberOfReps() {
        if let repsString = numRepsTextfield.text, let reps = Int(repsString), let setNumber = setNumber {
            let index = setNumber - 1
            if index >= 0 {
//                setEntry.updateRepsRecorded(reps: reps)
//                delegate?.updateEntry(new: setEntry, at: index)
                delegate?.updateNumberOfReps(reps: reps, at: index)
            }
        }
    }
    
    lazy var numRepsContainer: UIStackView = {
        
        let label = UILabel()
        label.text = " reps"
        label.backgroundColor = .orange
        
        let stackView = UIStackView(arrangedSubviews: [numRepsTextfield, label])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
        
    }()
    
    let weightPerformedTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .yellow
        tf.textAlignment = .right
        return tf
    }()
    
    lazy var weightPerformedContainer: UIStackView = {
        
        let label = UILabel()
        label.text = " lbs"
        label.backgroundColor = .yellow
        
        let stackView = UIStackView(arrangedSubviews: [weightPerformedTextField, label])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let stackview = UIStackView(arrangedSubviews: [setNumberLabel, numRepsContainer, weightPerformedContainer])
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        stackview.spacing = 10
        
        addSubview(stackview)
        numRepsTextfield.delegate = self
        numRepsTextfield.addTarget(self, action: #selector(handleChangeNumberOfReps), for: .editingChanged)
        weightPerformedTextField.delegate = self
        stackview.pinHorizontalSides(left: leftAnchor, leftPadding: 8, right: rightAnchor, rightPadding: 8)
        stackview.pinVerticalSides(top: topAnchor, topPadding: 0, bottom: bottomAnchor, bottomPadding: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExerciseEntryCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let decimalCharacterSet = CharacterSet.decimalDigits
        let inputCharacterSet = CharacterSet(charactersIn: string)
        return decimalCharacterSet.isSuperset(of: inputCharacterSet)
    }
}


