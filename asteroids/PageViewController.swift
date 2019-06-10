//
//  PageViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import UIKit

extension Notification.Name {
    static let dataTap = Notification.Name(rawValue: "dataTap")
    static let dataNoTap = Notification.Name(rawValue: "dataNoTap")
}

internal class PageViewController: UIPageViewController, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var searchByDate: UIBarButtonItem!
    @IBOutlet weak var addToFavourite: UIBarButtonItem!
    private var downloader: DataDownloadService?
    private var serializer: Serializer?
    private var formatter: DataFormatter?
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [newColoredViewController(name: "PageView1"),
                newColoredViewController(name: "PageView2")]
    }()
    private var pictureOfTheDay: PictureOfTheDay?
    private var sendPicture: [String: PictureOfTheDay?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        downloader = NASADownloadService()
        serializer = JSONSerializer()
        formatter = NasaDataFormatter()
        NotificationCenter.default.addObserver(self, selector: #selector(sendData), name: .dataNoTap, object: sendPicture)
    }

    @objc func sendData() {
        NotificationCenter.default.post(name: .dataTap, object: PageView1Controller.self, userInfo: sendPicture)
        NotificationCenter.default.post(name: .dataTap, object: PageView2Controller.self, userInfo: sendPicture)
    }
    
    @IBAction func addToFavouriteTapped(_ sender: Any) {
        print("Add To Favourite Was Tapped")
    }
    
    @IBAction func searchByDateTapped(_ sender: UIBarButtonItem) {
        print("Search By Date Was Tapped")
        let nav = PopoverViewController.create(controller: self) { [unowned self] date in
            _ = self.downloader?.runDownload(date: date, queryType: .pictureOfTheDay) { [unowned self] data in
                self.serializer?.decode(ofType: PictureOfTheDay.self, data: data) { [unowned self] pictureOfTheDay in
                    self.pictureOfTheDay = pictureOfTheDay
                    print(pictureOfTheDay)
                    self.sendPicture = ["picture": pictureOfTheDay]
                    self.sendData()
                }
            }
        }
        self.present(nav, animated: true)
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
}
