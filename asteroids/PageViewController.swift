//
//  PageViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import UIKit

internal class PageViewController: UIPageViewController, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var searchByDate: UIBarButtonItem!
    @IBOutlet weak var addToFavourite: UIBarButtonItem!
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [newColoredViewController(name: "PageView1"),
                newColoredViewController(name: "PageView2")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }

    
    @IBAction func addToFavouriteTapped(_ sender: Any) {
        print("Add To Favourite Was Tapped")
    }
    
    @IBAction func searchByDateTapped(_ sender: UIBarButtonItem) {
        print("Search By Date Was Tapped")
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popoverContent = storyboard.instantiateViewController(withIdentifier: "SearchByDatePopover")
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = .popover
        let popover = nav.popoverPresentationController
        if UIDevice.current.userInterfaceIdiom == .pad {
            popoverContent.preferredContentSize = CGSize(width: 500, height: 500)
        } else {
            popoverContent.preferredContentSize = CGSize(width: 250, height: 250)
        }
      
        popover!.delegate = self
        popover!.sourceView = self.view
        popover!.sourceRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.present(nav, animated: true, completion: nil)
    }
    
    private func newColoredViewController(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return adaptivePresentationStyle(for: controller)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return orderedViewControllers.count
//    }
//
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        guard let firstViewController = viewControllers?.first,
//            let firstViewControllerIndex = orderedViewControllers.firstIndex(of: firstViewController) else {
//                return 0
//        }
//
//        return firstViewControllerIndex
//    }
}
