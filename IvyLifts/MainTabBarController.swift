//
//  MainTabBarController.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/22/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log.info("MainTabBarController loaded!")
        view.backgroundColor = .white
        
        let vcOne = RoutinePageView()
        vcOne.view.backgroundColor = .red
        vcOne.title = "Home"
        vcOne.tabBarItem.image = #imageLiteral(resourceName: "home_unselected")
        vcOne.tabBarItem.selectedImage = #imageLiteral(resourceName: "home_selected")
        let navOne = UINavigationController(rootViewController: vcOne)

        
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
        
        viewControllers = [navOne, navTwo, navThree]
        tabBar.tintColor = .black
    }
}
