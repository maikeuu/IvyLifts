//
//  ExerciseEntryController.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

protocol ExerciseEntryDelegate: class {
    func passRecordedEntries(entries: [SetEntry], for index: Int)
}

class ExerciseEntryController: UIViewController {
    
    weak var delegate: ExerciseEntryDelegate?
    
    var index: Int?
    
    var setEntries: [SetEntry] = [] {
        didSet {
            if collectionView != nil {
                self.collectionView.reloadData()
            }
        }
    }
    
    var header = ExerciseDetailHeader()
    var collectionView: UICollectionView!
    
    var exercise: ExerciseGoal? {
        didSet {
            guard let exercise = exercise else { return }
            log.debug(exercise)
            self.header.exerciseGoal = exercise
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background()
        setupHeader()
        setupCollectionView()
        
        addCancelEditingTapGesture()
         log.info("ExerciseEntryController loaded!")
    }
    
    fileprivate func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.backgroundColor = .background()
        collectionView.delegate = self
        collectionView.register(ExerciseEntryCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.register(ExerciseDetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ExerciseDetailCellID")
        collectionView.pinVerticalSides(top: header.bottomAnchor, topPadding: 16, bottom: view.layoutMarginsGuide.bottomAnchor, bottomPadding: 8)
        collectionView.pinHorizontalSides(left: view.layoutMarginsGuide.leftAnchor, leftPadding: 0, right: view.layoutMarginsGuide.rightAnchor, rightPadding: 0)
        collectionView.delaysContentTouches = false
    }
    
    fileprivate func setupHeader() {
        view.addSubview(header)
        header.delegate = self
        header.pinTopAnchor(to: view.layoutMarginsGuide.topAnchor, padding: 8)
        header.pinHorizontalSides(left: view.layoutMarginsGuide.leftAnchor, leftPadding: 0, right: view.layoutMarginsGuide.rightAnchor, rightPadding: 0)
        header.setHeight(constant: 145)
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
        delegate?.passRecordedEntries(entries: self.setEntries, for: self.index!)
    }
}

extension ExerciseEntryController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! ExerciseEntryCell
        cell.setNumber = indexPath.row + 1
        cell.setEntry = setEntries[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.setEntries.count
    }
}

// MARK: - Size and spacing delegate methods
extension ExerciseEntryController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    /// Spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    // Size for cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 64
        return CGSize(width: self.collectionView.frame.width, height: height)
    }
}

extension ExerciseEntryController: ExerciseDetailDelegate {
    func didAddEntry(reps: Int, weight: Double) {
        guard let exerciseName = exercise?.exerciseName else { return }
        let entry = SetEntry(exerciseName: exerciseName, weightRecorded: weight, repsRecorded: reps)
        setEntries.append(entry)
    }
}
