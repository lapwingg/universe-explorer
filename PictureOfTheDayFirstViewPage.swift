//
//  PageView1Controller.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import UIKit

// download picture and display its

internal class PictureOfTheDayFirstViewPage: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var pictureImageView: UIImageView!
    private var imageDownloadService: ImageDownloadService!
    private let PARAMETER_NAME = "picture"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
        setupServices()
        makeInitialUIUpdate()
    }
    
    private func setupObserver() {
         NotificationCenter.default.addObserver(self, selector: #selector(updateUI(_:)), name: .newDownloadedData, object: nil)
    }
    
    private func setupServices() {
        imageDownloadService = ImageDownloadServiceImpl()
    }
    
    private func makeInitialUIUpdate() {
        NotificationCenter.default.post(name: .explicityUpdateUI, object: PictureOfTheDayViewController.self)
    }
    
    @objc private func updateUI(_ notification: NSNotification) {
        let p = notification.userInfo?[PARAMETER_NAME] as? PictureOfTheDay
        guard let picture = p else {
            dateLabel.text = "Date"
            titleTextView.text = "Title"
            return
        }
        fillTextView(picture)
        setupImage(picture)
    }
    
    private func setupImage(_ picture: PictureOfTheDay) {
        _ = imageDownloadService.runDownload(link: picture.url) { [unowned self] image in
            self.pictureImageView.image = image
        }
    }
    
    private func fillTextView(_ picture: PictureOfTheDay) {
        let result = getDataToDisplay(picture)
        dateLabel.text = result.date
        titleTextView.text = result.title
    }
    
    private func getDataToDisplay(_ picture: PictureOfTheDay) -> (date: String, title: String) {
        return ("\(picture.date)", "\(picture.title)")
    }
}
