//
//  SettingsController.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/30/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit
import RealmSwift

class SettingsController: UIViewController {
    
    
    var realm: Realm!
    let resetButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetButton.setTitle("Reset App", for: .normal)
        resetButton.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        
        view.addSubview(resetButton)
        
        resetButton.pinTopAnchor(to: view.layoutMarginsGuide.topAnchor, padding: 16)
        resetButton.pinHorizontalSides(left: view.leftAnchor, leftPadding: 16, right: view.rightAnchor, rightPadding: 16)
        resetButton.setHeight(constant: 80)
        resetButton.layer.borderWidth = 1
        resetButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @objc func handleReset() {
        try! realm.write {
            realm.deleteAll()
            log.error("Deleting all realm entries!")
            DispatchQueue.main.async {
                let calibrateViewController = CalibrationController()
                calibrateViewController.realm = self.realm
                self.present(calibrateViewController, animated: true, completion: nil)
            }
            return
        }
    }
}
