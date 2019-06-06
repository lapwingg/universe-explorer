//
//  ViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/1/19.
//

import UIKit

public class ViewController: UIViewController {
    @IBOutlet weak var resultField: UITextView!
    private var downloader: DataDownloadService?
    private var serializer: Serializer?
    private var formatter: DataFormatter?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

    }

    private func performDownloadAction() {
        downloader = NASADayDownloadService()
        serializer = JSONSerializer()
        formatter = NasaDataFormatter()
        _ = downloader?.runDownload { [unowned self] data in
            self.serializer?.decode(ofType: PictureOfTheDay.self, data: data) { [unowned self] pictureOfTheDay in
                self.resultField.text = self.formatter?.getFormattedData(pictureOfTheDay: pictureOfTheDay)
            }
        }
    }
    
    private func performDownload2Action() {
        downloader = MarsPhotosDownloadService()
        serializer = JSONSerializer()
        formatter = NasaDataFormatter()
        _ = downloader?.runDownload { [unowned self] data in
            self.serializer?.decode(ofType: MarsPhotosRoot.self, data: data) { [unowned self] marsPhotosRoot in
                self.resultField.text = "\(marsPhotosRoot.photos.count)"
            }
        }
    }
    
    private func performDownload3Action() {
        
    }
    
    private func performDownload4Action() {
        
    }
    
    @IBAction func downloadButton(_ sender: Any) {
        performDownloadAction()
    }
    
    @IBAction func download2Button(_ sender: Any) {
        performDownload2Action()
    }
    
    @IBAction func download3Button(_ sender: Any) {
        performDownload3Action()
    }
    
    @IBAction func download4Button(_ sender: Any) {
        performDownload4Action()
    }
}
