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
        createIvyBrain()
    }
    
    var ivyBrain: IvyBrain!
    
    func createIvyBrain() {
        let userMetric = realm.objects(PersonalRecords.self)
        if userMetric.count == 0 {
            DispatchQueue.main.async {
                let calibrateViewController = CalibrationController()
                calibrateViewController.realm = self.realm
                self.present(calibrateViewController, animated: true, completion: nil)
            }
            return
        } else {
            self.ivyBrain = IvyBrain(personalRecords: userMetric[0])
            setupControllers()
        }
    }
    
    func setupControllers() {
        log.info("Setting up MainTabBar Controllers")
        let flowLayout = UICollectionViewFlowLayout()
        let programOverviewController = ProgramOverviewController(collectionViewLayout: flowLayout)
        programOverviewController.ivyBrain = self.ivyBrain
        
        programOverviewController.title = "Home"
        programOverviewController.tabBarItem.image = #imageLiteral(resourceName: "home_unselected")
        programOverviewController.tabBarItem.selectedImage = #imageLiteral(resourceName: "home_selected")
        let navigationScreenOne = UINavigationController(rootViewController: programOverviewController)
        
        let vcTwo = UIViewController()
        vcTwo.view.backgroundColor = .orange
        vcTwo.title = "Entries"
        vcTwo.tabBarItem.image = #imageLiteral(resourceName: "list")
        let navTwo = UINavigationController(rootViewController: vcTwo)
        
        let vcThree = SettingsController()
        vcThree.realm = realm
        vcThree.title = "Settings"
        vcThree.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        vcThree.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        let navThree = UINavigationController(rootViewController: vcThree)
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear"), style: .plain, target: self, action: nil)
        
        viewControllers = [navigationScreenOne, navTwo, navThree]
        tabBar.tintColor = .black
    }
}
