//
//  CollectionViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import UIKit

internal class MarsPhotosCollectionViewController: UICollectionViewController, UICollectionViewDataSourcePrefetching {
    private var downloader: DataDownloadService?
    private var serializer: Serializer?
    private var marsPhotosRoot: MarsPhotosRoot?
    private var marsPhoto: [MarsPhoto] = []
    private var dateFactory: DateFactory!
    private var imageDownloadService: ImageDownloadService!
    private let REUSE_IDENTIFIER = "marsPhoto"
    private let HEADER_REUSE_IDENTIFIER = "marsPhotosHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupServices()
        runDownload()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
    }

    private func runDownload() {
       _ = downloader?.runDownload(date: dateFactory.create(year: 2019, month: 06, day: 12), queryType: .marsRoverPhotos) { [unowned self] data in
            self.serializer?.decode(ofType: MarsPhotosRoot.self, data: data) { [unowned self] marsPhotosRoot in
                self.marsPhotosRoot = marsPhotosRoot
                self.marsPhoto.append(MarsPhoto(date: self.dateFactory.create(year: 2019, month: 06, day: 12)))
                self.marsPhoto.last?.downloadPhotos(self.marsPhotosRoot!) {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    fileprivate func setupServices() {
        downloader = NASADownloadService()
        serializer = JSONSerializer()
        dateFactory = DateFactoryImpl()
        imageDownloadService = ImageDownloadServiceImpl()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return marsPhoto.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marsPhoto[section].photo.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: REUSE_IDENTIFIER, for: indexPath) as! MarsPhotosCollectionViewCell
        let photos = photo(for: indexPath)
        cell.backgroundColor = .white
        cell.photoImageView.image = photos
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

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
    func photo(for indexPath: IndexPath) -> UIImage {
        return marsPhoto[indexPath.section].photo[indexPath.row]
    }
}
