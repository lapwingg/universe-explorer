//
//  AppDelegate.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/1/19.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let mainViewController = window?.rootViewController as? MainScreenViewController,
            let splitViewContoller = mainViewController.viewControllers?.last as? FavouriteSplitViewController,
            let leftNavController = splitViewContoller.viewControllers.first as? UINavigationController,
            let masterViewController = leftNavController.topViewController as? FavouriteTableViewController,
            let detailViewController = splitViewContoller.viewControllers.last as? FavouriteDetailViewController
            else { fatalError() }
        
        let firstMonster = masterViewController.favouriteTable?.first
        detailViewController.favouriteTableData = firstMonster
        masterViewController.delegate = detailViewController
        return true
    }
}
