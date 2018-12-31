//
//  CalibrationScreen.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/30/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit
import RealmSwift

class CalibrationController: UIViewController {
    
    let benchPressLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Bench"
        lb.textAlignment = .center
        lb.backgroundColor = .white
        lb.layer.cornerRadius = 5
        
        return lb
    }()
    
    let benchPressRepsTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.placeholder = "8 reps"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        
        let lineSeperator = UIView()
        tf.addSubview(lineSeperator)
        lineSeperator.setHeight(constant: 0.5)
        lineSeperator.backgroundColor = .black
        lineSeperator.pinHorizontalSides(left: tf.leftAnchor, leftPadding: 0, right: tf.rightAnchor, rightPadding: 0)
        lineSeperator.pinTopAnchor(to: tf.bottomAnchor, padding: 0)
        return tf
    }()
    
    let benchPressCalibrationTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.placeholder = "235 lbs"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        
        let lineSeperator = UIView()
        tf.addSubview(lineSeperator)
        lineSeperator.setHeight(constant: 0.5)
        lineSeperator.backgroundColor = .black
        lineSeperator.pinHorizontalSides(left: tf.leftAnchor, leftPadding: 0, right: tf.rightAnchor, rightPadding: 0)
        lineSeperator.pinTopAnchor(to: tf.bottomAnchor, padding: 0)
        return tf
    }()
    
    let squatLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Squat"
        lb.textAlignment = .center
        lb.backgroundColor = .white
        lb.layer.cornerRadius = 5
        
        return lb
    }()
    
    let squatRepsTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.placeholder = "4 reps"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        
        let lineSeperator = UIView()
        tf.addSubview(lineSeperator)
        lineSeperator.setHeight(constant: 0.5)
        lineSeperator.backgroundColor = .black
        lineSeperator.pinHorizontalSides(left: tf.leftAnchor, leftPadding: 0, right: tf.rightAnchor, rightPadding: 0)
        lineSeperator.pinTopAnchor(to: tf.bottomAnchor, padding: 0)
        return tf
    }()
    
    let squatCalibrationTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.placeholder = "235 lbs"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        
        let lineSeperator = UIView()
        tf.addSubview(lineSeperator)
        lineSeperator.setHeight(constant: 0.5)
        lineSeperator.backgroundColor = .black
        lineSeperator.pinHorizontalSides(left: tf.leftAnchor, leftPadding: 0, right: tf.rightAnchor, rightPadding: 0)
        lineSeperator.pinTopAnchor(to: tf.bottomAnchor, padding: 0)
        return tf
    }()
    
    let shoulderPressLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Shoulder Press"
        lb.textAlignment = .center
        lb.backgroundColor = .white
        lb.layer.cornerRadius = 5
        
        return lb
    }()
    
    let shoulderPressRepsTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.placeholder = "235 lbs"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        
        let lineSeperator = UIView()
        tf.addSubview(lineSeperator)
        lineSeperator.setHeight(constant: 0.5)
        lineSeperator.backgroundColor = .black
        lineSeperator.pinHorizontalSides(left: tf.leftAnchor, leftPadding: 0, right: tf.rightAnchor, rightPadding: 0)
        lineSeperator.pinTopAnchor(to: tf.bottomAnchor, padding: 0)
        return tf
    }()
    
    let shoulderPressCalibrationTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.placeholder = "235 lbs"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        
        let lineSeperator = UIView()
        tf.addSubview(lineSeperator)
        lineSeperator.setHeight(constant: 0.5)
        lineSeperator.backgroundColor = .black
        lineSeperator.pinHorizontalSides(left: tf.leftAnchor, leftPadding: 0, right: tf.rightAnchor, rightPadding: 0)
        lineSeperator.pinTopAnchor(to: tf.bottomAnchor, padding: 0)
        return tf
    }()
    
    let deadLiftLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Deadlift"
        lb.textAlignment = .center
        lb.backgroundColor = .white
        lb.layer.cornerRadius = 5
        
        return lb
    }()
    
    let deadliftRepsTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.placeholder = "2 reps"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        
        let lineSeperator = UIView()
        tf.addSubview(lineSeperator)
        lineSeperator.setHeight(constant: 0.5)
        lineSeperator.backgroundColor = .black
        lineSeperator.pinHorizontalSides(left: tf.leftAnchor, leftPadding: 0, right: tf.rightAnchor, rightPadding: 0)
        lineSeperator.pinTopAnchor(to: tf.bottomAnchor, padding: 0)
        return tf
    }()
    
    let deadLiftCalibrationTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.placeholder = "235 lbs"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        let lineSeperator = UIView()
        tf.addSubview(lineSeperator)
        lineSeperator.setHeight(constant: 0.5)
        lineSeperator.backgroundColor = .black
        lineSeperator.pinHorizontalSides(left: tf.leftAnchor, leftPadding: 0, right: tf.rightAnchor, rightPadding: 0)
        lineSeperator.pinTopAnchor(to: tf.bottomAnchor, padding: 0)
        return tf
    }()
    
    let barbellRowLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Barbell Row"
        lb.textAlignment = .center
        lb.backgroundColor = .white
        lb.layer.cornerRadius = 5
        
        let lineSeperator = UIView()
        lb.addSubview(lineSeperator)
        return lb
    }()
    
    let barbellRowRepsTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.placeholder = "8 reps"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        
        let lineSeperator = UIView()
        tf.addSubview(lineSeperator)
        lineSeperator.setHeight(constant: 0.5)
        lineSeperator.backgroundColor = .black
        lineSeperator.pinHorizontalSides(left: tf.leftAnchor, leftPadding: 0, right: tf.rightAnchor, rightPadding: 0)
        lineSeperator.pinTopAnchor(to: tf.bottomAnchor, padding: 0)
        return tf
    }()
    
    let barbellRowCalibrationTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.placeholder = "235 lbs"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        
        let lineSeperator = UIView()
        tf.addSubview(lineSeperator)
        lineSeperator.setHeight(constant: 0.5)
        lineSeperator.backgroundColor = .black
        lineSeperator.pinHorizontalSides(left: tf.leftAnchor, leftPadding: 0, right: tf.rightAnchor, rightPadding: 0)
        lineSeperator.pinTopAnchor(to: tf.bottomAnchor, padding: 0)
        return tf
    }()
    
    let pullUpsLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Pull Ups"
        lb.textAlignment = .center
        lb.backgroundColor = .white
        lb.layer.cornerRadius = 5
        return lb
    }()
    
    let pullUpsRepsTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.placeholder = "32 reps"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        
        let lineSeperator = UIView()
        tf.addSubview(lineSeperator)
        lineSeperator.setHeight(constant: 0.5)
        lineSeperator.backgroundColor = .black
        lineSeperator.pinHorizontalSides(left: tf.leftAnchor, leftPadding: 0, right: tf.rightAnchor, rightPadding: 0)
        lineSeperator.pinTopAnchor(to: tf.bottomAnchor, padding: 0)
        return tf
    }()
    
    let pullUpsCalibrationTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.placeholder = "235 lbs"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        //        tf.backgroundColor = .red
        
        let lineSeperator = UIView()
        tf.addSubview(lineSeperator)
        lineSeperator.setHeight(constant: 0.5)
        lineSeperator.backgroundColor = .black
        lineSeperator.pinHorizontalSides(left: tf.leftAnchor, leftPadding: 0, right: tf.rightAnchor, rightPadding: 0)
        lineSeperator.pinTopAnchor(to: tf.bottomAnchor, padding: 0)
        return tf
    }()
    
    @objc func handleInput() {
        let isFormFilledOut = benchPressCalibrationTextField.text?.count ?? 0 > 0 && benchPressRepsTextField.text?.count ?? 0 > 0 &&
                squatCalibrationTextField.text?.count ?? 0 > 0 && squatRepsTextField.text?.count ?? 0 > 0 &&
                deadLiftCalibrationTextField.text?.count ?? 0 > 0 && deadliftRepsTextField.text?.count ?? 0 > 0 &&
                barbellRowCalibrationTextField.text?.count ?? 0 > 0 && barbellRowRepsTextField.text?.count ?? 0 > 0 &&
                shoulderPressCalibrationTextField.text?.count ?? 0 > 0 && shoulderPressRepsTextField.text?.count ?? 0 > 0 &&
                pullUpsCalibrationTextField.text?.count ?? 0 > 0 && pullUpsRepsTextField.text?.count ?? 0 > 0
        
        if isFormFilledOut {
            doneButton.backgroundColor = .white
            doneButton.isEnabled = true
        } else {
            doneButton.backgroundColor = .lightGray
            doneButton.isEnabled = false
        }
    }
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.isEnabled = false
        return button
    }()
    
    var realm: Realm!
    
    @objc func handleDone() {
        let bench = Double(benchPressCalibrationTextField.text!)!
        let squat = Double(squatCalibrationTextField.text!)!
        let deadlift = Double(deadLiftCalibrationTextField.text!)!
        let barbellRow = Double(deadLiftCalibrationTextField.text!)!
        let shoulderPress = Double(shoulderPressCalibrationTextField.text!)!
        let pullUps = Double(pullUpsCalibrationTextField.text!)!
        
        let benchReps = Double(benchPressRepsTextField.text!)!
        let squatReps = Double(squatRepsTextField.text!)!
        let deadliftReps = Double(deadliftRepsTextField.text!)!
        let barbellRowReps = Double(barbellRowRepsTextField.text!)!
        let shoulderPressReps = Double(shoulderPressRepsTextField.text!)!
        let pullUpsReps = Double(pullUpsRepsTextField.text!)!
        
        let userMetric = PersonalRecords()
        userMetric.bench = OneRepCalculator.calculate(reps: benchReps, weight: bench)
        userMetric.squat = OneRepCalculator.calculate(reps: squatReps, weight: squat)
        userMetric.deadlift = OneRepCalculator.calculate(reps: deadliftReps, weight: deadlift)
        userMetric.barbellRow = OneRepCalculator.calculate(reps: barbellRowReps, weight: barbellRow)
        userMetric.shoulderPress = OneRepCalculator.calculate(reps: shoulderPressReps, weight: shoulderPress)
        userMetric.pullUps = OneRepCalculator.calculate(reps: pullUpsReps, weight: pullUps)
        
        try! realm.write {
            self.realm.add(userMetric)
            log.info("Adding PersonalRecord to persistence!")
            
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
            mainTabBarController.createIvyBrain()
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background()
        addCancelEditingTapGesture()
        
        view.addSubview(doneButton)
//        let benchStack = UIStackView(arrangedSubviews: [benchPressLabel, benchPressCalibrationTextField])
//        benchStack.axis = .vertical
//        benchStack.distribution = .fillProportionally
//        benchStack.spacing = 0
//
//        view.addSubview(benchStack)
        
        let benchStack = UIStackView(arrangedSubviews: [benchPressRepsTextField, benchPressCalibrationTextField])
        benchStack.axis = .horizontal
        benchStack.distribution = .fillEqually
        benchStack.spacing = 8
        
        let squatStack = UIStackView(arrangedSubviews: [squatRepsTextField, squatCalibrationTextField])
        squatStack.axis = .horizontal
        squatStack.distribution = .fillEqually
        squatStack.spacing = 8
        
        let deadliftStack = UIStackView(arrangedSubviews: [deadliftRepsTextField, deadLiftCalibrationTextField])
        deadliftStack.axis = .horizontal
        deadliftStack.distribution = .fillEqually
        deadliftStack.spacing = 8
        
        let barbellRowStack = UIStackView(arrangedSubviews: [barbellRowRepsTextField, barbellRowCalibrationTextField])
        barbellRowStack.axis = .horizontal
        barbellRowStack.distribution = .fillEqually
        barbellRowStack.spacing = 8
        
        let shoulderPressStack = UIStackView(arrangedSubviews: [shoulderPressRepsTextField, shoulderPressCalibrationTextField])
        shoulderPressStack.axis = .horizontal
        shoulderPressStack.distribution = .fillEqually
        shoulderPressStack.spacing = 8
        
        let pullUpsStack = UIStackView(arrangedSubviews: [pullUpsRepsTextField, pullUpsCalibrationTextField])
        pullUpsStack.axis = .horizontal
        pullUpsStack.distribution = .fillEqually
        pullUpsStack.spacing = 8
        
        let bigStack = UIStackView(arrangedSubviews: [benchPressLabel, benchStack, squatLabel, squatStack, deadLiftLabel, deadliftStack, barbellRowLabel, barbellRowStack, shoulderPressLabel, shoulderPressStack, pullUpsLabel, pullUpsStack])
        bigStack.axis = .vertical
        bigStack.distribution = .fillEqually
        bigStack.spacing = 8
        
        view.addSubview(bigStack)
        
        bigStack.pinHorizontalSides(left: view.leftAnchor, leftPadding: 16, right: view.rightAnchor, rightPadding: 16)
        bigStack.pinTopAnchor(to: view.layoutMarginsGuide.topAnchor, padding: 16)
        bigStack.setHeight(constant: view.frame.height * 2/3)
        
        doneButton.setWidth(constant: 160)
        doneButton.setHeight(constant: 40)
        doneButton.placeCenterHorizontallyInContainer(self.view)
        doneButton.pinTopAnchor(to: bigStack.bottomAnchor, padding: 16)
    }
    
    fileprivate func addCancelEditingTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        self.view.endEditing(true)
        log.debug("Tap gesture is recognized!")
    }
}
