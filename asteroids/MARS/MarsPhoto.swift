//
//  MarsPhotos.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/15/19.
//

import UIKit

class MarsPhoto {
    var date: Date
    var marsPhotoRoot: MarsPhotosRoot
    var links: [String] = []
    var photos: [UIImage] = []
    private var imageDownloadService: ImageDownloadService!
    
    init(date: Date, marsPhotoRoot: MarsPhotosRoot) {
        self.date = date
        self.marsPhotoRoot = marsPhotoRoot
        imageDownloadService = ImageDownloadServiceImpl()
    }

    func prepareToDownloadPhoto() {
        for m in marsPhotoRoot.photos {
            self.links.append(m.imgSrc)
            self.photos.append(UIImage(named: "tmp")!)
        }
    }
}
