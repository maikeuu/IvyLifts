//
//  RoutineCollectionView.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/23/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

protocol WeeklyOverviewCollectionDelegate: class {
    func present()
}

/// This class servers as the "Home" screen, where it shows a page view that alternates between Workout Week A/B.
class RoutinePageView: UIPageViewController, WeeklyOverviewCollectionDelegate {
    
    // TODO: - Decide if this is the best place to put the delegate
    func present() {
        let flow = UICollectionViewFlowLayout()
        self.navigationController?.pushViewController(WorkoutCollectionController(collectionViewLayout: flow), animated: true)
    }
    
    var orderedViewControllers = [UIViewController]()
    
    // Create the pages and append them to orderedViewControllers
    func setupPages() {
        let flow = UICollectionViewFlowLayout()
        let vcOne = WeeklyOverviewCollectionController(collectionViewLayout: flow)
        vcOne.delegate = self
        let navOne = UINavigationController(rootViewController: vcOne)
        
        let vcTwo = WeeklyOverviewCollectionController(collectionViewLayout: flow)
        vcTwo.view.backgroundColor = .blue
        vcTwo.delegate = self
        let navTwo = UINavigationController(rootViewController: vcTwo)
        
        self.orderedViewControllers.append(contentsOf: [navOne, navTwo])
    }
    
    /// Set the properties of pageControl and
    var pageControl = UIPageControl()
    func setupPageControl() {
        self.view.addSubview(pageControl)
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = .black
        self.pageControl.pageIndicatorTintColor = .black
        self.pageControl.currentPageIndicatorTintColor = .gray
        self.pageControl.pinHorizontalSides(left: view.leftAnchor, leftPadding: 16, right: view.rightAnchor, rightPadding: 16)
        self.pageControl.setHeight(constant: 50)
        self.pageControl.pinBottomToMargins(container: view, constant: 0)
        self.pageControl.backgroundColor = .red
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        setupPages()
        setupPageControl()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    /// Makes the transition between the pages scroll instead of curl
    required override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RoutinePageView: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContent = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContent)!
        
    }
    
}

extension RoutinePageView: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        /// If the previous index returns negative index, do not move left
        guard previousIndex >= 0 else { return nil }
        return orderedViewControllers[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        /// If the next index is the same viewController, then do nothing
        guard orderedViewControllers.count != nextIndex else { return nil }
        return orderedViewControllers[nextIndex]
    }
    
    
}
