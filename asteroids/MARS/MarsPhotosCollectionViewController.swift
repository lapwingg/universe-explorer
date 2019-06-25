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
    private var databaseHandler: DatabaseHandler!
    private static var i = 0
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
        databaseHandler = DatabaseHandlerImpl()
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
            cell.photoImageView.image = image
            self.setPhoto(for: indexPath, image: image)
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Save photo", message: "Do you want to save already selected photo in favourite category?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default){ (_) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy_hh:mm:ss"
            let string = dateFormatter.string(from: self.lastDownloadedDate)
            self.databaseHandler.connect()
            self.databaseHandler.insert(url: self.link(for: indexPath), name: "Mars_Photo_\(string)_\(MarsPhotosCollectionViewController.i)", image: self.photo(for: indexPath))
           MarsPhotosCollectionViewController.i = MarsPhotosCollectionViewController.i + 1
        })
        alert.addAction(UIAlertAction(title: "No", style: .destructive))
        present(alert, animated: true)
    }
}

extension MarsPhotosCollectionViewController {
    func link(for indexPath: IndexPath) -> String {
        return marsPhoto[indexPath.section].links[indexPath.row]
    }
    
    func setPhoto(for indexPath: IndexPath, image: UIImage) {
        marsPhoto[indexPath.section].photos[indexPath.row] = image
    }
    
    func photo(for indexPath: IndexPath) -> UIImage {
        return marsPhoto[indexPath.section].photos[indexPath.row]
    }
}
