//
//  File.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/11/19.
//

import UIKit

extension PictureOfTheDayViewController: UIPageViewControllerDataSource {
    internal func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let pageViewIndex = associatedPageViews.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = pageViewIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard associatedPageViews.count > previousIndex else {
            return nil
        }
        
        return associatedPageViews[previousIndex]
    }
    
    internal func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let pageViewIndex = associatedPageViews.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = pageViewIndex + 1
        let assosiatedPageViewCount = associatedPageViews.count
        
        guard assosiatedPageViewCount != nextIndex else {
            return nil
        }
        
        guard assosiatedPageViewCount > nextIndex else {
            return nil
        }
        
        return associatedPageViews[nextIndex]
    }
}
