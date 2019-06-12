//
//  PageView2Controller.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import UIKit

internal class PictureOfTheDaySecondViewPage: UIViewController {
    @IBOutlet weak var textView2: UITextView!
    private let PARAMETER_NAME = "picture"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
        makeInitialUIUpdate()
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(_:)), name: .newDownloadedData, object: nil)
    }
    
    private func makeInitialUIUpdate() {
        NotificationCenter.default.post(name: .explicityUpdateUI, object: PictureOfTheDayViewController.self)
    }
    
    @objc private func updateUI(_ notification: NSNotification) {
        let p = notification.userInfo?[PARAMETER_NAME] as? PictureOfTheDay
        fillTextView(p)
    }
    
    private func fillTextView(_ p: PictureOfTheDay?) {
        guard let picture = p else {
            textView2.text = "Page2"
            return
        }
        textView2.text = getTextToDisplay(picture)
    }
    
    private func getTextToDisplay(_ picture: PictureOfTheDay) -> String {
        return "\(picture.date)\n\n\n\(picture.title)\n\n\(picture.explanation)"
    }
}
