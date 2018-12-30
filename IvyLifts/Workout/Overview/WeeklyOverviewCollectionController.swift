//
//  WeeklyRoutineViewController.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/23/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit
/// This class is the controller that shows the Week A / Week B Workouts to do.
class WeeklyOverviewCollectionController: UICollectionViewController {
    
    var isOddWeek = true {
        didSet {
            if isOddWeek {
                self.workouts = WeeklyRoutineGenerator.createOddWeek().workouts
            } else {
                self.workouts = WeeklyRoutineGenerator.createEvenWeek().workouts
            }
        }
    }
    
    var workouts: [Workout] = WeeklyRoutineGenerator.createOddWeek().workouts {
        didSet {
            self.collectionView.reloadData()
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupCollectionView()
        view.addSubview(switchWeekButton)
        
        self.collectionView.pinVerticalSides(top: view.layoutMarginsGuide.topAnchor, topPadding: 16, bottom: switchWeekButton.topAnchor, bottomPadding: 8)
        self.collectionView.pinHorizontalSides(left: view.leftAnchor, right: view.rightAnchor)
        switchWeekButton.pinVerticalSides(top: collectionView.bottomAnchor, topPadding: 8, bottom: view.layoutMarginsGuide.bottomAnchor, bottomPadding: 8)
        switchWeekButton.placeCenterHorizontallyInContainer(self.view)
        switchWeekButton.setWidth(constant: 160)
    }
    
    func setupCollectionView() {
        self.collectionView.register(WeeklyOverviewCollectionCell.self, forCellWithReuseIdentifier: "cellID")
        self.collectionView.backgroundColor = UIColor.lightGray
    }
    
    /// On click, push to the WorkoutCollectionViewController
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        /// Make the cell have a highlight animation on click
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            cell?.backgroundColor = UIColor.init(white: 255/255, alpha: 0.7)
        }, completion: { _ in
          cell?.backgroundColor = UIColor.white
        })
        
        let flow = UICollectionViewFlowLayout()
        let workoutController = WorkoutCollectionController(collectionViewLayout: flow)
        workoutController.exercises = workouts[indexPath.item].exercises
        
        self.navigationController?.pushViewController(workoutController, animated: true)
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workouts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! WeeklyOverviewCollectionCell
        cell.model = workouts[indexPath.row]
        
        // Temporary workaround to labeling the days
        if isOddWeek {
            switch indexPath.item {
            case 0, 2: cell.titleLabel.text = "Day A"
            default: cell.titleLabel.text = "Day B"
            }
        } else {
            switch indexPath.item {
            case 0, 2: cell.titleLabel.text = "Day B"
            default: cell.titleLabel.text = "Day A"
            }
        }
        
        return cell
    }
}

extension WeeklyOverviewCollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height/CGFloat(workouts.count + 1)
        return CGSize(width: view.frame.width, height: height)
    }
}


