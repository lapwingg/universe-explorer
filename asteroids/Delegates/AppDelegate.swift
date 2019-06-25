//
//  AppDelegate.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/1/19.
//

import UIKit

@UIApplicationMain
internal class AppDelegate: UIResponder, UIApplicationDelegate {
    internal var window: UIWindow?

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let mainViewController = window?.rootViewController as? MainScreenViewController,
            let splitViewContoller = mainViewController.viewControllers?.last as? FavouriteSplitViewController,
            let leftNavController = splitViewContoller.viewControllers.first as? UINavigationController,
            let masterViewController = leftNavController.topViewController as? FavouriteTableViewController,
            let detailViewController = splitViewContoller.viewControllers.last as? FavouriteDetailViewController
            else { fatalError() }
        
        let firstTableData = masterViewController.favouriteTable?.first
        detailViewController.favouriteTableData = firstTableData
        masterViewController.delegate = detailViewController
        return true
    }
}
