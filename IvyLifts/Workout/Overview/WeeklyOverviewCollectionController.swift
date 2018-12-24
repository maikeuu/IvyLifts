//
//  WeeklyRoutineViewController.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/23/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class WeeklyOverviewCollectionController: UICollectionViewController {
    
    weak var delegate: WeeklyOverviewCollectionDelegate?
    
    let workoutOfTheWeek = WeeklyRoutineGenerator.createWeek()
    var workouts: [Workout] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    func setupCollectionView() {
        self.collectionView.register(WeeklyOverviewCollectionCell.self, forCellWithReuseIdentifier: "cellID")
        self.collectionView.backgroundColor = UIColor.lightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// REMOVE THIS TO STOP DEBUGGING
        delegate?.present()
        
        
        setupCollectionView()
        self.workouts = workoutOfTheWeek.workouts
        let pageControlHeight: CGFloat = 50
        self.collectionView.pinVerticalSides(top: view.layoutMarginsGuide.topAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, bottomPadding: pageControlHeight)
        self.collectionView.pinHorizontalSides(left: view.leftAnchor, right: view.rightAnchor)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        /// Make the cell have a highlight animation on click
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            cell?.backgroundColor = UIColor.init(white: 255/255, alpha: 0.7)
        }, completion: { _ in
          cell?.backgroundColor = UIColor.white
        })
        delegate?.present()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workouts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! WeeklyOverviewCollectionCell
        cell.model = workouts[indexPath.row]
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


