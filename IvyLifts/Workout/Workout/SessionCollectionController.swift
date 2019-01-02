//
//  SessionCollectionController.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

/// This class is a collection view that loads exercises from WeeklyOverViewCollection controller and displays the 4 workouts to do
/// in a collectionView display. On clicking any of the cells, the navigationController will push ExerciseEntryController
class SessionCollectionController: UICollectionViewController {
    
    /// The exercises that define each cell.
    var exercises: [FitnessGoal] = [] {
        didSet {
            self.collectionView.reloadData()
            
            /// Once we find out how many exercises there are, let entriesCollection populate empty lists in order to
            /// match the number of cells created and have them map to some empty list corresponding w/ the cell's index.item
            self.entriesCollection = [FitnessEntry](repeating: FitnessEntry(entries: []), count: exercises.count)
        }
    }
    
    /// An array of SetEntry arrays, which serves to cache any recorded data passed from ExerciseEntryController through it's delegate.
    /// Once this array is populated, the collectionView will pass in the list of SetEntrys corresponding to the cell that
    /// recorded those set entries. That way, there is no need to re-make those list of Entries again, it is automatically populated.
    /// The cells of WorkoutCollectionController use this collection to populate their own collectionViews, which list the sets that
    /// have been recorded but on the cell.
    var entriesCollection: [FitnessEntry] = [] {
        didSet {
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupCollectionView() {
        self.collectionView.backgroundColor = UIColor.background()
        self.collectionView.register(SessionCollectionCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! SessionCollectionCell
        cell.model = exercises[indexPath.item]
        /// Pass the entries collected from ExerciseEntryController to the cells in this collectionView, which then
        /// populate their own collectionView with the entries recorded
        cell.entries = entriesCollection[indexPath.item].entries
        if entriesCollection[indexPath.item].isFinished {
            cell.isFinished = true
        }
        return cell
    }
    
    /// Creates the exerciseEntryController and if we have an collection of entries from it, then we load the
    /// exerciseEntryController's collectionView with these structs
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        log.info("Transitioning to ExerciseEntryController")
        let exerciseEntryController = EntryController()
        exerciseEntryController.exercise = exercises[indexPath.item]
        exerciseEntryController.index = indexPath.item
        exerciseEntryController.delegate = self
        exerciseEntryController.setEntries = entriesCollection[indexPath.item].entries
        
        self.navigationController?.pushViewController(exerciseEntryController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercises.count
    }
}

extension SessionCollectionController: UICollectionViewDelegateFlowLayout {
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

extension SessionCollectionController: ExerciseEntryDelegate {
    func passRecordedEntries(entries: [Entry], for index: Int) {
        log.debug("Entries collected from index \(index)")
        log.debug(entries)
        self.entriesCollection[index] = FitnessEntry(entries: entries)
        if entries.count == exercises[index].numSets {
            log.info("Set finished!")
            self.collectionView.reloadData()
        }
    }
}
