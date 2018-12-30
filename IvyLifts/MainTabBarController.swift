//
//  MainTabBarController.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/22/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit
import RealmSwift

class MainTabBarController: UITabBarController {
    
    var realm: Realm!
    
    func setupRealm() {
        log.info("This is working")
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("maikeuu.realm")
        
        self.realm = try! Realm(configuration: config)
        log.debug("Realm being set up at: \(config.fileURL!)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log.info("MainTabBarController loaded!")
        view.backgroundColor = .white
        setupRealm()
        
        let userMetric = realm.objects(UserMetric.self)
        if userMetric.count == 0 {
            DispatchQueue.main.async {
                let calibrateViewController = CalibrationController()
                calibrateViewController.realm = self.realm
                self.present(calibrateViewController, animated: true, completion: nil)
            }
            return
        }
        setupControllers()
    }
    
    func setupControllers() {
        let flowLayout = UICollectionViewFlowLayout()
        let weeklyOverviewController = WeeklyOverviewCollectionController(collectionViewLayout: flowLayout)
        let navigationScreenOne = UINavigationController(rootViewController: weeklyOverviewController)
        weeklyOverviewController.title = "Home"
        weeklyOverviewController.tabBarItem.image = #imageLiteral(resourceName: "home_unselected")
        weeklyOverviewController.tabBarItem.selectedImage = #imageLiteral(resourceName: "home_selected")
        
        let vcTwo = UIViewController()
        vcTwo.view.backgroundColor = .orange
        vcTwo.title = "Entries"
        vcTwo.tabBarItem.image = #imageLiteral(resourceName: "list")
        let navTwo = UINavigationController(rootViewController: vcTwo)
        
        let vcThree = UIViewController()
        vcThree.view.backgroundColor = .yellow
        vcThree.title = "Settings"
        vcThree.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        vcThree.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        let navThree = UINavigationController(rootViewController: vcThree)
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear"), style: .plain, target: self, action: nil)
        
        viewControllers = [navigationScreenOne, navTwo, navThree]
        tabBar.tintColor = .black
    }
}
