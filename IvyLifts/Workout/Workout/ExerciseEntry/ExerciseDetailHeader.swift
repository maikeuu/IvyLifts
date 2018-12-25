//
//  ExerciseDetailHeader.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class ExerciseDetailHeader: UICollectionViewCell {
    
    var exerciseName: String? {
        didSet {
            guard let exerciseName = exerciseName else { return }
            excerciseNameLabel.text = exerciseName
        }
    }
    
    let excerciseNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Foo"
        lb.textAlignment = .center
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        addSubview(excerciseNameLabel)
        excerciseNameLabel.pinTopAnchor(to: topAnchor)
        excerciseNameLabel.placeCenterHorizontallyInContainer(self)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
