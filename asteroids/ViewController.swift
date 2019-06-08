//
//  ViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/1/19.
//

import UIKit

public class ViewController: UIViewController {
    @IBOutlet weak var resultField: UITextView!
    @IBOutlet weak var resultView: UIView!
    private var downloader: DataDownloadService?
    private var serializer: Serializer?
    private var formatter: DataFormatter?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

    }

    private func performPOTDDownloadAction() {
        print("Run Page View Controller")
        
//        let downloader = NASADownloadService()
//        serializer = JSONSerializer()
//        formatter = NasaDataFormatter()
//        _ = downloader.runDownload(queryType: .pictureOfTheDay) { [unowned self] data in
//            self.serializer?.decode(ofType: PictureOfTheDay.self, data: data) { [unowned self] pictureOfTheDay in
//                self.resultField.text = self.formatter?.getFormattedData(pictureOfTheDay: pictureOfTheDay)
//            }
//        }
    }
    
    private func performMPADownloadAction() {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PageView") as! PageViewController
//        resultView.
//        vc.loadView()
        print("Run Collection View Controller")
//        let downloader = NASADownloadService()
//        serializer = JSONSerializer()
//        formatter = NasaDataFormatter()
//        _ = downloader.runDownload(queryType: .marsRoverPhotos) { [unowned self] data in
//            self.serializer?.decode(ofType: MarsPhotosRoot.self, data: data) { [unowned self] marsPhotosRoot in
//                self.resultField.text = "\(marsPhotosRoot.photos.count)"
//            }
//        }
    }
    
    private func performCAEDownloadAction() {
        print("Run Table View Controller")
//        let downloader = NASADownloadService()
//        serializer = JSONSerializer()
//        formatter = NasaDataFormatter()
//        _ = downloader.runDownload(queryType: .closestAsteroids) { [unowned self] data in
//            self.serializer?.decode(ofType: ClosestAsteroidsRoot.self, data: data) { [unowned self] closestAsteroids in
//                self.resultField.text = "\(closestAsteroids.links.linksSelf.count)\n\(closestAsteroids.elementCount)\n\(closestAsteroids.nearEarthObjects.count)"
//            }
//        }
    }
    
    private func performFavouritePhotosAction() {
        print("Stay here")
//        resultField.text = "Favourite photos to do ..."
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
