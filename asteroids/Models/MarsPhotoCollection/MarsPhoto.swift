//
//  Created by Czajka, Kamil
//

import UIKit

internal class MarsPhoto {
    internal var date: Date
    internal var marsPhotoRoot: MarsPhotosRoot
    internal var links: [String] = []
    internal var photos: [UIImage] = []
    private var imageDownloadService: ImageDownloadService!
    
    init(date: Date, marsPhotoRoot: MarsPhotosRoot) {
        self.date = date
        self.marsPhotoRoot = marsPhotoRoot
        imageDownloadService = ImageDownloadServiceImpl()
    }

    internal func prepareToDownloadPhoto() {
        for m in marsPhotoRoot.photos {
            self.links.append(m.imgSrc)
            self.photos.append(UIImage(named: "tmp")!)
        }
    }
}
