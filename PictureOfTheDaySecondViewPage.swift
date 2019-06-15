//
//  PageView2Controller.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import UIKit

internal class PictureOfTheDaySecondViewPage: UIViewController {
    private var entityValidator: EntityValidator!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var explanationTextView: UITextView!
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
        entityValidator = EntityValidatorImpl()
    }
    
    private func makeInitialUIUpdate() {
        NotificationCenter.default.post(name: .explicityUpdateUI, object: PictureOfTheDayViewController.self)
    }
    
    @objc private func updateUI(_ notification: NSNotification) {
        let p = notification.userInfo?[PARAMETER_NAME] as? PictureOfTheDay
        let picture = entityValidator.validate(p)
        fillTextView(picture)
    }
    
    private func fillTextView(_ picture: PictureOfTheDay) {
        let result = getDataToDisplay(picture)
        dateLabel.text = result.date
        titleTextView.text = result.title
        explanationTextView.text = result.explanation
    }
    
    private func getDataToDisplay(_ picture: PictureOfTheDay) -> (date: String, title: String, explanation: String) {
        return ("\(picture.date)", "\(picture.title)", "\(picture.explanation)")
    }
}
