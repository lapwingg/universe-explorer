//
//  MarsPhotos.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/15/19.
//

import UIKit

class MarsPhoto {
    var date: Date
    var photo: [UIImage] = []
    private var imageDownloadService: ImageDownloadService!
    
    init(date: Date) {
        self.date = date
        imageDownloadService = ImageDownloadServiceImpl()
    }
    
    func downloadPhotos(_ marsPhotosRoot: MarsPhotosRoot, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            let group = DispatchGroup()
            for p in marsPhotosRoot.photos {
                group.enter()
                _ = self.imageDownloadService.runDownload(link: p.imgSrc) {
                    image in self.photo.append(image!)
                    group.leave()
                }
            }
        
            group.wait()
        
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
