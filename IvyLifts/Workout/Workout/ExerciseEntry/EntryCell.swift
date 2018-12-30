//
//  ExerciseEntryCell.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit


class EntryCell: UICollectionViewCell {
    
    var setNumber: Int? {
        didSet {
            guard let setNumber = setNumber else { return }
            setNumberLabel.text = "Set \(setNumber)"
        }
    }
    
    var setEntry: Entry! {
        didSet {
            self.numRepsTextfield.text = "\(setEntry.repsRecorded)"
            self.weightPerformedTextField.text = "\(setEntry.weightRecorded)"
            log.debug("Set entry set!")
        }
    }
    
    let setNumberLabel = UILabel()
    
    let numRepsTextfield: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .asciiCapableNumberPad
        tf.textAlignment = .right
        tf.isEnabled = false
        return tf
    }()
    
    lazy var numRepsContainer: UIStackView = {
        
        let label = UILabel()
        label.text = " reps"
        
        let stackView = UIStackView(arrangedSubviews: [numRepsTextfield, label])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
        
    }()
    
    let weightPerformedTextField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .right
        tf.isEnabled = false
        return tf
    }()
    
    lazy var weightPerformedContainer: UIStackView = {
        
        let label = UILabel()
        label.text = " lbs"
        
        let stackView = UIStackView(arrangedSubviews: [weightPerformedTextField, label])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 3
        
//        let stackview = UIStackView(arrangedSubviews: [setNumberLabel, weightPerformedContainer, numRepsContainer])
//        stackview.distribution = .fillEqually
//        stackview.axis = .horizontal
//        stackview.spacing = 10
//        addSubview(stackview)
        
        addSubview(setNumberLabel)
        addSubview(weightPerformedContainer)
        addSubview(numRepsContainer)
        
        setNumberLabel.placeCenterVerticallyInContainer(self)
        setNumberLabel.pinLeftAnchor(to: leftAnchor, padding: 16)
        
        weightPerformedContainer.placeCenterVerticallyInContainer(self)
        weightPerformedContainer.placeCenterHorizontallyInContainer(self)
        
        numRepsContainer.placeCenterVerticallyInContainer(self)
        numRepsContainer.pinRightAnchor(to: rightAnchor, padding: 16)
        
        numRepsTextfield.delegate = self
        weightPerformedTextField.delegate = self
//        stackview.pinHorizontalSides(left: leftAnchor, leftPadding: 16, right: rightAnchor, rightPadding: 16)
//        stackview.pinVerticalSides(top: topAnchor, topPadding: 0, bottom: bottomAnchor, bottomPadding: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EntryCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let decimalCharacterSet = CharacterSet.decimalDigits
        let inputCharacterSet = CharacterSet(charactersIn: string)
        return decimalCharacterSet.isSuperset(of: inputCharacterSet)
    }
}


