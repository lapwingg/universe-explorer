//
//  ViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/1/19.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultField: UITextView!
    private var downloader: DataDownloadService?
    private var serializer: Serializer?
    private var formatter: DataFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloader = NASADownloadService()
        serializer = JSONSerializer()
        formatter = NasaDataFormatter()
    }

    private func performDownloadAction() {
        _ = downloader?.runDownload { [unowned self] data in
            self.serializer?.decode(data: data) { [unowned self] pictureOfTheDay in
                self.resultField.text = self.formatter?.getFormattedData(pictureOfTheDay: pictureOfTheDay)
            }
        }
    }
    
    @IBAction func downloadButton(_ sender: Any) {
        performDownloadAction()
    }
}
