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
    private var imageDownloadService: ImageDownloadService!
    
    init(date: Date, marsPhotoRoot: MarsPhotosRoot) {
        self.date = date
        self.marsPhotoRoot = marsPhotoRoot
        imageDownloadService = ImageDownloadServiceImpl()
    }

    func prepareToDownloadPhoto() {
        print("HRR \(date) \(marsPhotoRoot.photos.count)")
        for m in marsPhotoRoot.photos {
            print("M")
            self.links.append(m.imgSrc)
        }
    }
}
