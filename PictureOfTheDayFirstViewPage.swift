//
//  PageView1Controller.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import UIKit

internal class PictureOfTheDayFirstViewPage: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var pictureImageView: UIImageView!
    private var imageDownloadService: ImageDownloadService!
    private var entityValidator: EntityValidator!
    private let PARAMETER_NAME = "picture"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
        setupServices()
    }
    
    private func setupObserver() {
         NotificationCenter.default.addObserver(self, selector: #selector(updateUI(_:)), name: .newDownloadedData, object: nil)
    }
    
    private func setupServices() {
        imageDownloadService = ImageDownloadServiceImpl()
        entityValidator = EntityValidatorImpl()
    }
    
    @objc private func updateUI(_ notification: NSNotification) {
        let p = notification.userInfo?[PARAMETER_NAME] as? PictureOfTheDay
        let picture = entityValidator.validate(p)
        fillTextView(picture)
        setupImage(picture)
    }
    
    private func setupImage(_ picture: PictureOfTheDay) {
     //   let alert = UIAlertController(title: "Downloading...", message: "Please wait for end", preferredStyle: .alert)
      //      self.present(alert, animated: true)
        _ = imageDownloadService.runDownload(link: picture.url) { [unowned self] image in
            self.pictureImageView.image = image
       //     print("DOWNLOADED IMAGE")
      //      self.dismiss(animated: true)
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
