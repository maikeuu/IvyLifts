//
//  AutoLayoutUtil.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/23/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

/// My personal autolayout library

// MARK: - Container based constraints
extension UIView {
    
    /// Pin top of view to the layout margins of some container
    public func pinTopToMargins(container: UIView, padding: CGFloat = 0) {
        self.pinTopAnchor(to: container.layoutMarginsGuide.topAnchor, padding: padding)
    }
    
    /// Pin bottom of view to the layout margins of some container
    public func pinBottomToMargins(container: UIView, padding: CGFloat = 0) {
        self.pinBottomAnchor(to: container.layoutMarginsGuide.bottomAnchor, padding: padding)
    }
    
    /// Places the view in the center X of some UIView container
    public func placeCenterHorizontallyInContainer(_ container: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    }
    
    /// Places the view in the center Y of some UIView container
    public func placeCenterVerticallyInContainer(_ container: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
    }

}
// MARK: - Size based constraints
extension UIView {
    /// Sets the size of a UIView
    public func setSize(width: CGFloat, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if width != 0 {
            self.setWidth(padding: width)
        }
        if height != 0 {
            self.setHeight(padding: height)
        }
    }
    
    /// Set width of a UIView
    public func setWidth(padding: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: padding).isActive = true
    }
    
    /// Set height of a UIView
    public func setHeight(padding: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: padding).isActive = true
    }
}

// MARK: - Abstract anchor methods
extension UIView {
    /// Anchor the left and right sides of a UIView
    public func pinHorizontalSides(left: NSLayoutXAxisAnchor, leftPadding: CGFloat = 0, right: NSLayoutXAxisAnchor, rightPadding: CGFloat = 0) {
        self.pinLeftAnchor(to: left, padding: leftPadding)
        self.pinRightAnchor(to: right, padding: rightPadding)
    }
    
    /// Anchor the top and bottom sides of a UIView
    public func pinVerticalSides(top: NSLayoutYAxisAnchor, topPadding: CGFloat = 0, bottom: NSLayoutYAxisAnchor, bottomPadding: CGFloat = 0) {
        self.pinTopAnchor(to: top, padding: topPadding)
        self.pinBottomAnchor(to: bottom, padding: bottomPadding)
    }
}

// MARK: - Basic anchor wrappers
extension UIView {
    /// Set the left anchor of a view.
    public func pinLeftAnchor(to view: NSLayoutXAxisAnchor, padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: view, constant: padding).isActive = true
    }
    
    /// Set the right anchor of a view. Converts constant to use positive values for padding respective to right side
    public func pinRightAnchor(to view: NSLayoutXAxisAnchor, padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rightAnchor.constraint(equalTo: view, constant: -padding).isActive = true
    }
    
    /// Set the top anchor of a view
    public func pinTopAnchor(to view: NSLayoutYAxisAnchor, padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view, constant: padding).isActive = true
    }
    
    /// Set the bottom anchor of a view. Converts constant to use positive values for padding respective to the bottom side
    public func pinBottomAnchor(to view: NSLayoutYAxisAnchor, padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: view, constant: -padding).isActive = true
    }
}
