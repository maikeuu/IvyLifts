//
//  WorkoutCollectionCell.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class WorkoutCollectionCell: UICollectionViewCell {
    
    var model: ExerciseGoal? {
        didSet {
            guard let model = model else { return }
            self.exerciseLabel.text = model.exerciseName
            
            let goalString = "\(model.numSets) sets | \(model.numReps) reps | \(model.targetWeight) lbs"
            self.goalLabel.text = goalString
            
            if model.isAMRAP {
                isAMRAPLabel.isHidden = false
            }
        }
    }
    
    var entries: [SetEntry]? {
        didSet {
            guard let entries = entries else { return }
            if entriesCollection.isHidden {
                entriesCollection.isHidden = false
            }
            self.entriesCollection.reloadData()
        }
    }
    
    let exerciseLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Squat"
        lb.textAlignment = .center
        return lb
    }()
    
    let goalLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        return lb
    }()
    
    let isAMRAPLabel: UILabel = {
        let lb = UILabel()
        lb.text = "AMRAP"
        lb.textColor = UIColor.red
        lb.textAlignment = .center
        lb.isHidden = true
        return lb
    }()
    
    let entriesCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
//        layer.borderColor = UIColor.black.cgColor
//        layer.borderWidth = 1
        layer.cornerRadius = 10
        
        let detailsStackView = UIStackView(arrangedSubviews: [exerciseLabel, goalLabel, isAMRAPLabel])
        detailsStackView.axis = .vertical
        detailsStackView.spacing = 4
        detailsStackView.distribution = .fillEqually
        
        addSubview(detailsStackView)
        detailsStackView.pinTopAnchor(to: topAnchor, padding: 4)
        detailsStackView.pinHorizontalSides(left: leftAnchor, leftPadding: 4, right: rightAnchor, rightPadding: 4)
        
        addSubview(entriesCollection)
        entriesCollection.pinHorizontalSides(left: leftAnchor, leftPadding: 4, right: rightAnchor, rightPadding: 4)
        entriesCollection.pinBottomAnchor(to: bottomAnchor, padding: 8)
        entriesCollection.setHeight(constant: 80)
        entriesCollection.register(RecordedEntryCell.self, forCellWithReuseIdentifier: "cellID")
        entriesCollection.backgroundColor = .white
        entriesCollection.dataSource = self
        entriesCollection.delegate = self
        entriesCollection.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WorkoutCollectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entries?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! RecordedEntryCell
        cell.model = entries?[indexPath.row]
        cell.setNumber = indexPath.row + 1
        return cell
    }
}

extension WorkoutCollectionCell: UICollectionViewDelegateFlowLayout {
    
    // Spacing between successive cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    // Size for cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: collectionView.frame.height)
    }
}

class RecordedEntryCell: UICollectionViewCell {
    
    var model: SetEntry? {
        didSet {
            guard let model = model else { return }
            recordedEntryLabel.text = "\(model.repsRecorded) x \(model.weightRecorded) lbs"
        }
    }
    
    var setNumber: Int? {
        didSet {
            guard let setNumber = setNumber else { return }
            setNumberLabel.text = "Set \(setNumber)"
        }
    }
    
    let setNumberLabel = UILabel()
    let recordedEntryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setNumberLabel.textAlignment = .center
        setNumberLabel.font = UIFont.systemFont(ofSize: 18)
//        setNumberLabel.backgroundColor = .green
//        recordedEntryLabel.backgroundColor = .blue
        
        
        recordedEntryLabel.textAlignment = .center
        recordedEntryLabel.numberOfLines = 0
        recordedEntryLabel.font = UIFont.systemFont(ofSize: 14)
        
        let stackView = UIStackView(arrangedSubviews: [setNumberLabel, recordedEntryLabel])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        
        addSubview(stackView)
        stackView.pinVerticalSides(top: topAnchor, bottom: bottomAnchor)
        stackView.pinHorizontalSides(left: leftAnchor, right: rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

