//
//  CollectionViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import UIKit

internal class MarsPhotosCollectionViewController: UICollectionViewController {
    private var downloader: DataDownloadService?
    private var serializer: Serializer?
    private var marsPhoto: [MarsPhoto] = []
    private var imageDownloadService: ImageDownloadService!
    private var lastDownloadedDate: Date!
    private var activityIndicator: UIActivityIndicatorView!
    private let REUSE_IDENTIFIER = "marsPhoto"
    private let HEADER_REUSE_IDENTIFIER = "marsPhotosHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupServices()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        if marsPhoto.isEmpty {
            runDownload()
        }
    }
    
    private func runDownload() {
        lastDownloadedDate = Date().addingTimeInterval(-1 * 60 * 60 * 24)
        runActivityIndicator(collectionView)
        DispatchQueue.global().async { [unowned self] in
            let group = DispatchGroup()
            for _ in 1...7 {
                group.enter()
                _ = self.downloader?.runDownload(date: self.lastDownloadedDate, queryType: .marsRoverPhotos) { [unowned self] data in
                    self.serializer?.decode(ofType: MarsPhotosRoot.self, data: data) { [unowned self] marsPhotosRoot in
                        self.marsPhoto.append(MarsPhoto(date: self.lastDownloadedDate, marsPhotoRoot: marsPhotosRoot))
                        self.marsPhoto.last?.prepareToDownloadPhoto()
                        self.lastDownloadedDate = Calendar.current.date(byAdding: .day, value: -1, to: self.lastDownloadedDate)
                        group.leave()
                    }
                }
                group.wait()
            }
            group.notify(queue: .main) {
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    private func runActivityIndicator(_ uiView: UICollectionView) {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.center = uiView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        uiView.addSubview(activityIndicator)
    }
    
    fileprivate func setupServices() {
        downloader = NASADownloadService()
        serializer = JSONSerializer()
        imageDownloadService = ImageDownloadServiceImpl()
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return marsPhoto.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marsPhoto[section].links.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: REUSE_IDENTIFIER, for: indexPath) as! MarsPhotosCollectionViewCell
        let l = link(for: indexPath)
        cell.backgroundColor = .blue
        cell.link = l
        cell.downloadPhoto { image in
            print("\(indexPath)")
            cell.photoImageView.image = image
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HEADER_REUSE_IDENTIFIER, for: indexPath) as? MarsPhotoCollectionHeader else {
                    fatalError("Invalid view type")
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        let date = marsPhoto[indexPath.section].date
        let string = dateFormatter.string(from: date)
        let searchTerm = string
        headerView.dayMonthHeader.text = searchTerm
        return headerView
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension MarsPhotosCollectionViewController {
    func link(for indexPath: IndexPath) -> String {
        return marsPhoto[indexPath.section].links[indexPath.row]
    }
}
