//
//  MarsPhotosCollectionViewCell.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/15/19.
//

import UIKit

internal class MarsPhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    var link: String!
    
    func downloadPhoto(completion: @escaping (UIImage) -> Void) {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.center = photoImageView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        photoImageView.addSubview(activityIndicator)
        let imageDownloadService = ImageDownloadServiceImpl()
        DispatchQueue.global(qos: .userInteractive).async {
            let group = DispatchGroup()
            group.enter()
            _ = imageDownloadService.runDownload(link: self.link) {image in
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    completion(image!)
                }
                group.leave()
            }
            
            group.wait()
        }
    }
}
