//
//  Created by Czajka, Kamil
//

import UIKit

internal class PictureOfTheDayViewController: UIPageViewController {
    @IBOutlet weak var favouriteButton: UIBarButtonItem!
    private var downloader: DataDownloadService!
    private var serializer: Serializer!
    private var uiViewControllerFactory: UIViewControllerFactory!
    private var uiViewControllerValidator: UIViewControllerValidator!
    private var databaseHandler: DatabaseHandler!
    private var sendPicture: [String: PictureOfTheDay?]?
    private var lastDownloadedPictureOfTheDay: PictureOfTheDay!
    private var activityIndicator: UIActivityIndicatorView!
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
    
    override func viewDidAppear(_ animated: Bool) {
        if lastDownloadedPictureOfTheDay == nil {
            getTodayPictureOfTheDay()
        }
        else {
            fillFavouriteButtonText(url: lastDownloadedPictureOfTheDay.url)
        }
    }

    @IBAction internal func searchByDateTapped(_ sender: UIBarButtonItem) {
        let nav = SearchDatePopover.create(controller: self) { [unowned self] date in
            if date <= self.getCurrentDate() {
                self.downloadJSONfromServer(date: date)
            } else {
                return
            }
        }
        self.present(nav, animated: true)
    }
    
    @IBAction internal func addToFavouriteTapped(_ sender: Any) {
        changeFavouriteButtonText()
        NotificationCenter.default.post(name: .savePictureInDatabase, object: PictureOfTheDayFirstViewPage.self, userInfo: sendPicture)
    }
    
    internal func getTodayPictureOfTheDay() {
        downloadJSONfromServer(date: getCurrentDate())
    }
    
    internal func downloadJSONfromServer(date: Date) {
        runActivityIndicator(associatedPageViews.first!)
        _ = downloader.runDownload(date: date, queryType: .pictureOfTheDay) { [unowned self] data in
            self.serializer.decode(ofType: PictureOfTheDay.self, data: data) { [unowned self] pictureOfTheDay in
                self.databaseHandler.connect()
                self.lastDownloadedPictureOfTheDay = pictureOfTheDay
                self.fillFavouriteButtonText(url: pictureOfTheDay.url)
                self.sendPicture = [self.PARAMETER_NAME: pictureOfTheDay]
                self.sendData()
            }
        }
    }
    
    @objc private func stopActivityIndicator() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [unowned self] in
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func configure() {
        setupDelegates()
        setupServices()
        setupObserver()
        setupAssosiatedPageViews()
    }
    
    @objc private func sendData() {
        NotificationCenter.default.post(name: .newDownloadedData, object: PictureOfTheDayFirstViewPage.self, userInfo: sendPicture)
    }
    
    private func runActivityIndicator(_ uiView: UIViewController) {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.center = uiView.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        uiView.view.addSubview(activityIndicator)
    }
    
    fileprivate func setupDelegates() {
        dataSource = self
    }
    
    fileprivate func setupServices() {
        downloader = NASADownloadService()
        serializer = JSONSerializer()
        uiViewControllerFactory = UIViewControllerFactoryImpl()
        uiViewControllerValidator = UIViewControllerValidatorImpl()
        databaseHandler = DatabaseHandlerImpl()
    }
    
    fileprivate func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(sendData), name: .explicityUpdateUI, object: sendPicture)
        NotificationCenter.default.addObserver(self, selector: #selector(stopActivityIndicator), name: .stopActivityIndicator, object: nil)
    }
    
    fileprivate func setupAssosiatedPageViews() {
        let firstViewController = uiViewControllerValidator.validate(associatedPageViews.first)
        setViewControllers([firstViewController], direction: .forward, animated: true)
    }
    
    fileprivate func getCurrentDate() -> Date {
        return Date()
    }
    
    fileprivate func fillFavouriteButtonText(url: String) {
        if databaseHandler.contain(url: url) {
            favouriteButton.title = "Delete from favourite"
        } else {
            favouriteButton.title = "Add to favourite"
        }
    }
    
    fileprivate func changeFavouriteButtonText() {
        if favouriteButton.title == "Delete from favourite" {
            favouriteButton.title = "Add to favourite"
        } else {
            favouriteButton.title = "Delete from favourite"
        }
    }
}
