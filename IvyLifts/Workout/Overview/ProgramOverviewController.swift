//
//  ProgramOverviewController.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/23/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

/// This class is the controller that shows the Week A / Week B Workouts.
class ProgramOverviewController: UICollectionViewController {
    
    /// Initialize the week to start on oddWeek
    var ivyBrain: IvyBrain! {
        didSet {
            self.isOddWeek = true
            self.navigationItem.title = "Odd Week"
            log.error("Setting")
        }
    }
    
    var isOddWeek = true {
        didSet {
            if isOddWeek {
                self.navigationItem.title = "Odd Week"
                self.workouts = self.ivyBrain.program.oddWeek().sessions
            } else {
                self.navigationItem.title = "Even Week"
                self.workouts = self.ivyBrain.program.evenWeek().sessions
            }
        }
    }
    
    var workouts: [Session] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var programIsStarted: Bool = false {
        didSet {
            if programIsStarted {
                print("Starting program")
                self.collectionView.reloadData()
            }
        }
    }
    
    let startWeekButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start week", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleStartWeek), for: .touchUpInside)
        return button
    }()
    
    @objc func handleStartWeek() {
        self.programIsStarted = true
        self.collectionView.reloadData()
    }
    
    let switchWeekButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Switch week", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleSwitchWeek), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSwitchWeek() {
        if isOddWeek {
            self.isOddWeek = false
        } else {
            self.isOddWeek = true
        }
    }
    
    /// For startWeekButton and switchWeekButton
    var buttonsStackView: UIStackView!
    func setupButtonsStackView() {
        self.buttonsStackView = UIStackView(arrangedSubviews: [startWeekButton, switchWeekButton])
        self.buttonsStackView.axis = .vertical
        self.buttonsStackView.distribution = .fillEqually
        self.buttonsStackView.spacing = 8
        view.addSubview(buttonsStackView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background()
//        self.collectionView.backgroundColor = UIColor(white: 1.0, alpha: 0.75)
        setupCollectionView()
        setupButtonsStackView()
        self.collectionView.pinVerticalSides(top: view.layoutMarginsGuide.topAnchor, bottom: buttonsStackView.topAnchor, bottomPadding: 8)
        self.collectionView.pinHorizontalSides(left: view.leftAnchor, right: view.rightAnchor)
        self.buttonsStackView.pinVerticalSides(top: collectionView.bottomAnchor, topPadding: 8, bottom: view.layoutMarginsGuide.bottomAnchor, bottomPadding: 8)
        self.buttonsStackView.placeCenterHorizontallyInContainer(self.view)
        self.buttonsStackView.setWidth(constant: 160)
    }
    
    func setupCollectionView() {
        self.collectionView.register(ProgramOverviewCell.self, forCellWithReuseIdentifier: "cellID")
        self.collectionView.backgroundColor = UIColor.background()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! ProgramOverviewCell
        cell.model = workouts[indexPath.item]
        if programIsStarted {
            cell.opacity = 1.0
        } else {
            cell.opacity = 0.75
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workouts.count
    }
    
    /// On click, push to the WorkoutCollectionViewController
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        /// Make the cell have a highlight animation on click
//        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
//            cell?.backgroundColor = UIColor.init(white: 255/255, alpha: 0.7)
//        }, completion: { _ in
//          cell?.backgroundColor = UIColor.white
//        })
//
        let flow = UICollectionViewFlowLayout()
        let workoutController = SessionCollectionController(collectionViewLayout: flow)
        workoutController.exercises = workouts[indexPath.item].fitnessGoals
        
        self.navigationController?.pushViewController(workoutController, animated: true)
    }
}

extension ProgramOverviewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height/CGFloat(workouts.count + 1)
        return CGSize(width: view.frame.width - 32, height: height - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    }
}


