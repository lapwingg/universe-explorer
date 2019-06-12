//
//  PageViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import UIKit

internal class PictureOfTheDayViewController: UIPageViewController {
    private var downloader: DataDownloadService?
    private var serializer: Serializer?
    private var formatter: DataFormatter?
    private var uiViewControllerFactory: UIViewControllerFactory!
    private var uiViewControllerValidator: UIViewControllerValidator!
    private var sendPicture: [String: PictureOfTheDay?]?
    private let FIRST_PAGE_NAME = "PictureOfTheDayFirstPage"
    private let SECOND_PAGE_NAME = "PictureOfTheDaySecondPage"
    private let PARAMETER_NAME = "picture"
    internal lazy var associatedPageViews: [UIViewController] = {
        return [uiViewControllerFactory.create(name: FIRST_PAGE_NAME),
                uiViewControllerFactory.create(name: SECOND_PAGE_NAME)]
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    @IBAction internal func searchByDateTapped(_ sender: UIBarButtonItem) {
        let nav = SearchDatePopover.create(controller: self) { [unowned self] date in
            _ = self.downloader?.runDownload(date: date, queryType: .pictureOfTheDay) { [unowned self] data in
                self.serializer?.decode(ofType: PictureOfTheDay.self, data: data) { [unowned self] pictureOfTheDay in
                    self.sendPicture = [self.PARAMETER_NAME: pictureOfTheDay]
                    self.sendData()
                }
            }
        }
        self.present(nav, animated: true)
    }
    
    @IBAction internal func addToFavouriteTapped(_ sender: Any) {
        print("Add To Favourite Was Tapped")
    }
    
    private func configure() {
        setupDelegates()
        setupServices()
        setupObserver()
        setupAssosiatedPageViews()
    }
    
    @objc private func sendData() {
        NotificationCenter.default.post(name: .newDownloadedData, object: PictureOfTheDayFirstViewPage.self, userInfo: sendPicture)
        NotificationCenter.default.post(name: .newDownloadedData, object: PictureOfTheDaySecondViewPage.self, userInfo: sendPicture)
    }
    
    fileprivate func setupDelegates() {
        dataSource = self
    }
    
    fileprivate func setupServices() {
        downloader = NASADownloadService()
        serializer = JSONSerializer()
        formatter = NasaDataFormatter()
        uiViewControllerFactory = UIViewControllerFactoryImpl()
        uiViewControllerValidator = UIViewControllerValidatorImpl()
    }
    
    fileprivate func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(sendData), name: .explicityUpdateUI, object: sendPicture)
    }
    
    fileprivate func setupAssosiatedPageViews() {
        let firstViewController = uiViewControllerValidator.validate(associatedPageViews.first)
        setViewControllers([firstViewController], direction: .forward, animated: true)
    }
}
