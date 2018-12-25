//
//  ExerciseEntryController.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit


class ExerciseEntryCollectionController: UICollectionViewController {
    
    var setEntries: [SetEntry] = [] {
        didSet {
        }
    }
    
    
    var exercise: ExerciseGoal? {
        didSet {
            guard let exercise = exercise else { return }
            log.debug(exercise)
            self.setEntries = generateSetEntries(for: exercise)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func generateSetEntries(for exercise: ExerciseGoal) -> [SetEntry]{
        let numSets = exercise.numSets
        var entries: [SetEntry] = []
        for _ in 0..<numSets {
            entries.append(SetEntry(exerciseName: exercise.exerciseName, weightRecorded: 0))
        }
        return entries
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .purple
        collectionView.register(ExerciseEntryCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.register(ExerciseDetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ExerciseDetailCellID")
        collectionView.delaysContentTouches = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAdditionalSet))
        log.info("ExerciseEntryController loaded!")
        addCancelEditingTapGesture()
    }
    
    fileprivate func addCancelEditingTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        self.collectionView.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap() {
        self.view.endEditing(true)
        log.debug("Tap gesture is recognized!")
    }
    
    @objc func addAdditionalSet() {
        log.debug("Adding another set")
        // TODO: Change this
        guard let exercise = exercise else { return }
        self.setEntries.append(SetEntry(exerciseName: exercise.exerciseName, weightRecorded: 0))
    }
    
    /// Make TabBar disappear once this view is pushed
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        log.debug("Number of entries when leaving \(self.setEntries.count)")
        log.debug(self.setEntries)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! ExerciseEntryCell
        cell.setNumber = indexPath.row + 1
        cell.numRepsGoal = exercise?.numReps
        cell.targetWeight = exercise?.targetWeight
        cell.setEntry = setEntries[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExerciseDetailCellID", for: indexPath) as! ExerciseDetailHeader
        header.exerciseName = self.exercise?.exerciseName
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.setEntries.count
    }
}

extension ExerciseEntryCollectionController: ExerciseEntryDelegate {
    func updateNumberOfReps(reps: Int, at index: Int) {
        self.setEntries[index].updateRepsRecorded(reps: reps)
    }
}



// MARK: - Size and spacing delegate methods
extension ExerciseEntryCollectionController: UICollectionViewDelegateFlowLayout {
    
    /// Spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    // Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    // Size for cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 100
        return CGSize(width: self.view.frame.width, height: height)
    }
}
