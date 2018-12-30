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
    
    let benchPressCalibrationTextField: UITextField = {
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
    
    let squatLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Squat"
        lb.textAlignment = .center
        lb.backgroundColor = .white
        lb.layer.cornerRadius = 5
        
        return lb
    }()
    
    let squatCalibrationTextField: UITextField = {
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
    
    let shoulderPressLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Squat"
        lb.textAlignment = .center
        lb.backgroundColor = .white
        lb.layer.cornerRadius = 5
        
        return lb
    }()
    
    let shoulderPressCalibrationTextField: UITextField = {
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
    
    let deadLiftLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Deadlift"
        lb.textAlignment = .center
        lb.backgroundColor = .white
        lb.layer.cornerRadius = 5
        
        return lb
    }()
    
    let deadLiftCalibrationTextField: UITextField = {
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
    
    let barbellRowCalibrationTextField: UITextField = {
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
    
    let pullUpsLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Pull Ups"
        lb.textAlignment = .center
        lb.backgroundColor = .white
        lb.layer.cornerRadius = 5
        return lb
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
        let isFormFilledOut = benchPressCalibrationTextField.text?.count ?? 0 > 0 && squatCalibrationTextField.text?.count ?? 0 > 0 &&
                deadLiftCalibrationTextField.text?.count ?? 0 > 0 && barbellRowCalibrationTextField.text?.count ?? 0 > 0 &&
                squatCalibrationTextField.text?.count ?? 0 > 0 && pullUpsCalibrationTextField.text?.count ?? 0 > 0
        
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
        
        var userMetric = UserMetric()
        userMetric.bench = bench
        userMetric.squat = squat
        userMetric.deadlift = deadlift
        userMetric.barbellRow = barbellRow
        userMetric.shoulderPress = shoulderPress
        userMetric.pullUps = pullUps
        
        try! realm.write {
            self.realm.add(userMetric)
            log.info("Adding UserMetric to persistence!")
            
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
            mainTabBarController.setupControllers()
            
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
        
        let bigStack = UIStackView(arrangedSubviews: [benchPressLabel, benchPressCalibrationTextField, squatLabel, squatCalibrationTextField, deadLiftLabel, deadLiftCalibrationTextField, barbellRowLabel, barbellRowCalibrationTextField, shoulderPressLabel, shoulderPressCalibrationTextField, pullUpsLabel, pullUpsCalibrationTextField])
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
