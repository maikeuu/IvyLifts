//
//  ViewController.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/21/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // TODO: Replace this with some sort of logo or something
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        return label
    }()
    
    let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.borderStyle = .roundedRect
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textfield
    }()
    
    let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.borderStyle = .roundedRect
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textfield
    }()
    
    
    @objc func handleTextInputChange() {
        
    }
    
    let needAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Need an account? ", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ]
        )
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)
            ])
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    @objc func handleShowSignUp() {
        
    }
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = false
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLogin() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        let stackview = UIStackView(arrangedSubviews: [loginLabel, emailTextField, passwordTextField, loginButton])
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.distribution = .fillEqually
        
        view.addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(needAccountButton)
        needAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            stackview.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 64),
            stackview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            stackview.heightAnchor.constraint(equalToConstant: view.frame.height * 1/6),
            
            needAccountButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            needAccountButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            needAccountButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            needAccountButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }


}

