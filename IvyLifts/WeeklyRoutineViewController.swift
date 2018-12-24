//
//  WeeklyRoutineViewController.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/23/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class WeeklyRoutineViewController: UIViewController {
    
    let tableview = UITableView()
    
    let workoutOfTheWeek = WeeklyRoutineGenerator.createWeek()
    var workouts: [Workout] = [] {
        didSet {
            tableview.reloadData()
        }
    }
    
    func setupTableView() {
        self.tableview.register(WeeklyRoutineTableCell.self, forCellReuseIdentifier: "cellID")
        self.tableview.dataSource = self
        self.tableview.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        self.workouts = workoutOfTheWeek.workouts
        setupTableView()
        
        view.addSubview(tableview)
        tableview.pinHorizontalSides(left: view.leftAnchor, right: view.rightAnchor)
        // Set bottomPadding == to pageControlHeight
        tableview.pinVerticalSides(top: view.layoutMarginsGuide.topAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, bottomPadding: 50)
    }
}

extension WeeklyRoutineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! WeeklyRoutineTableCell
        cell.model = workouts[indexPath.row]
//        if indexPath.row == 0 {
//            cell.backgroundColor = .red
//        } else if indexPath.row == 1 {
//            cell.backgroundColor = .orange
//        } else {
//            cell.backgroundColor = .yellow
//        }
        return cell
    }
}

extension WeeklyRoutineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableview.frame.height / CGFloat((workouts.count+1))
    }
    
    /// Get rid of hanging animation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
// FUK refactor this to CollectionView
class WeeklyRoutineTableCell: UITableViewCell {
    var model: Workout? {
        didSet {
            // TODO: - Refactor this LOL
            guard let model = model else { return }
            let exerciseOne = model.exercises[0]
            let exerciseTwo = model.exercises[1]
            let exerciseThree = model.exercises[2]
            let exerciseFour = model.exercises[3]
            
            exerciseOneNameLabel.text = exerciseOne.exerciseName
            exerciseTwoNameLabel.text = exerciseTwo.exerciseName
            exerciseThreeNameLabel.text = exerciseThree.exerciseName
            exerciseFourNameLabel.text = exerciseFour.exerciseName
            
            let goalOne = "\(exerciseOne.numReps) x \(exerciseOne.numSets) - \(exerciseOne.targetWeight) lbs"
            let goalTwo = "\(exerciseTwo.numReps) x \(exerciseTwo.numSets) - \(exerciseTwo.targetWeight) lbs"
            let goalThree = "\(exerciseThree.numReps) x \(exerciseThree.numSets) - \(exerciseThree.targetWeight) lbs"
            let goalFour = "\(exerciseFour.numReps) x \(exerciseFour.numSets) - \(exerciseFour.targetWeight) lbs"
            
            exerciseOneGoalLabel.text = goalOne
            exerciseTwoGoalLabel.text = goalTwo
            exerciseThreeGoalLabel.text = goalThree
            exerciseFourGoalLabel.text = goalFour
        }
    }
    
    // Name Labels
    let exerciseOneNameLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    let exerciseTwoNameLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    let exerciseThreeNameLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    let exerciseFourNameLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    // Weight labels
    let exerciseOneGoalLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        return lb
    }()
    let exerciseTwoGoalLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        return lb
    }()
    let exerciseThreeGoalLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        return lb
    }()
    let exerciseFourGoalLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackOne = UIStackView(arrangedSubviews: [exerciseOneNameLabel, exerciseOneGoalLabel])
        stackOne.axis = .horizontal
        stackOne.distribution = .fillEqually
        let stackTwo = UIStackView(arrangedSubviews: [exerciseTwoNameLabel, exerciseTwoGoalLabel])
        stackTwo.axis = .horizontal
        stackTwo.distribution = .fillEqually
        let stackThree = UIStackView(arrangedSubviews: [exerciseThreeNameLabel, exerciseThreeGoalLabel])
        stackThree.axis = .horizontal
        stackThree.distribution = .fillEqually
        let stackFour = UIStackView(arrangedSubviews: [exerciseFourNameLabel, exerciseFourGoalLabel])
        stackFour.axis = .horizontal
        stackFour.distribution = .fillEqually
        
        let bigStack = UIStackView(arrangedSubviews: [stackOne, stackTwo, stackThree, stackFour])
        bigStack.axis = .vertical
        bigStack.distribution = .fillEqually
        
        addSubview(bigStack)
        bigStack.pinVerticalSides(top: topAnchor, bottom: bottomAnchor)
        bigStack.pinHorizontalSides(left: leftAnchor, right: rightAnchor)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// Represents a single exercise done, the date recorded, number of sets done and number of reps per set
struct Entry {
    let exerciseString: String
    var weightsRecorded: [Int]
    
}
