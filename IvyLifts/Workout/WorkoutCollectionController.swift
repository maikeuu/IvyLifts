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
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
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
        return 4
    }
}
