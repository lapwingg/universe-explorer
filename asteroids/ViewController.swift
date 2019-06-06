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

    private func performPOTDDownloadAction() {
        downloader = NASADayDownloadService()
        serializer = JSONSerializer()
        formatter = NasaDataFormatter()
        _ = downloader?.runDownload { [unowned self] data in
            self.serializer?.decode(ofType: PictureOfTheDay.self, data: data) { [unowned self] pictureOfTheDay in
                self.resultField.text = self.formatter?.getFormattedData(pictureOfTheDay: pictureOfTheDay)
            }
        }
    }
    
    private func performMPADownloadAction() {
        downloader = MarsPhotosDownloadService()
        serializer = JSONSerializer()
        formatter = NasaDataFormatter()
        _ = downloader?.runDownload { [unowned self] data in
            self.serializer?.decode(ofType: MarsPhotosRoot.self, data: data) { [unowned self] marsPhotosRoot in
                self.resultField.text = "\(marsPhotosRoot.photos.count)"
            }
        }
    }
    
    private func performCAEDownloadAction() {
        downloader = AsteroidsDownloadService()
        serializer = JSONSerializer()
        formatter = NasaDataFormatter()
        _ = downloader?.runDownload  { [unowned self] data in
            self.serializer?.decode(ofType: ClosestAsteroidsRoot.self, data: data) { [unowned self] closestAsteroids in
                self.resultField.text = "\(closestAsteroids.links.linksSelf.count)\n\(closestAsteroids.elementCount)\n\(closestAsteroids.nearEarthObjects.count)"
            }
        }
    }
    
    private func performFavouritePhotosAction() {
        resultField.text = "Favourite photos to do ..."
    }
    
    @IBAction func showPictureOfTheDay(_ sender: Any) {
        performPOTDDownloadAction()
    }
    
    @IBAction func showMarsPhotosAlbum(_ sender: Any) {
        performMPADownloadAction()
    }
    
    @IBAction func showClosestAsteroids(_ sender: Any) {
        performCAEDownloadAction()
    }
    
    @IBAction func showFavouritePhotos(_ sender: Any) {
        performFavouritePhotosAction()
    }
    
}
