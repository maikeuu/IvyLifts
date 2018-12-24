//
//  WorkoutController.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class WorkoutCollectionController: UICollectionViewController {
    
    func setupCollectionView() {
        self.collectionView.backgroundColor = UIColor.lightGray
        self.collectionView.register(WorkoutCollectionCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
    let exercises = WorkoutGenerator.createAMRAPDay().exercises
    
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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! WorkoutCollectionCell
        switch indexPath.row {
        case 0:
            cell.backgroundColor = .red
        case 1:
            cell.backgroundColor = .orange
        case 2:
            cell.backgroundColor = .yellow
        case 3:
            cell.backgroundColor = .green
        default:
            cell.backgroundColor = .white
        }
        return cell
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
        return CGSize(width: view.frame.width, height: height)
    }
}

class WorkoutCollectionCell: UICollectionViewCell {
    
    var model: ExerciseGoal? {
        didSet {
            guard let model = model else { return }
        }
    }
    
    let exerciseLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Squat"
        lb.backgroundColor = .cyan
        lb.textAlignment = .center
        return lb
    }()
    
    let weightTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .blue
        tf.text = "225 lbs"
        tf.textAlignment = .center
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let sv = UIStackView(arrangedSubviews: [exerciseLabel, weightTextField])
        sv.axis = .vertical
        sv.spacing = 4
        sv.distribution = .fillEqually
        
        addSubview(sv)
        sv.pinTopAnchor(to: topAnchor, constant: 4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
