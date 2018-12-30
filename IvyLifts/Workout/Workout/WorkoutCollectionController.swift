//
//  WorkoutController.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class WorkoutCollectionController: UICollectionViewController {
    
    var exercises: [ExerciseGoal] = [] {
        didSet {
            self.collectionView.reloadData()
            
            for _ in exercises {
                self.entriesCollection.append(contentsOf: [[]])
            }
        }
    }
    
    var entriesCollection: [[SetEntry]] = [] {
        didSet {
            log.debug("Setting entries")
            log.debug(entriesCollection)
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - View lifecycle methods 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    
    /// Make TabBar disappear once this view is pushed
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        log.warning(entriesCollection)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupCollectionView() {
        self.collectionView.backgroundColor = UIColor.lightGray
        self.collectionView.register(WorkoutCollectionCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! WorkoutCollectionCell
        cell.model = exercises[indexPath.item]
        
        if indexPath.item < entriesCollection.count {
            print(indexPath.row)
            log.debug("Passing \(entriesCollection[indexPath.item]) to \(indexPath.item)")
            cell.entries = entriesCollection[indexPath.item]
        }
        
        return cell
    }
    
    /// Creates the exerciseEntryController and if we have an collection of entries from it, then we load the
    /// exerciseEntryController's collectionView with these structs
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        log.info("Transitioning to ExerciseEntryController")
        let exerciseEntryController = ExerciseEntryController()
        exerciseEntryController.exercise = exercises[indexPath.item]
        exerciseEntryController.index = indexPath.item
        exerciseEntryController.delegate = self
        
        if indexPath.item < entriesCollection.count {
            exerciseEntryController.setEntries = entriesCollection[indexPath.item]
        }
        
        self.navigationController?.pushViewController(exerciseEntryController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercises.count
    }
}

extension WorkoutCollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height/CGFloat(exercises.count + 1)
        return CGSize(width: view.frame.width - 32, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

extension WorkoutCollectionController: ExerciseEntryDelegate {
    func passRecordedEntries(entries: [SetEntry], for index: Int) {
        log.debug("Entries collected from index \(index)")
        log.debug(entries)
        self.entriesCollection[index] = entries
    }
}
