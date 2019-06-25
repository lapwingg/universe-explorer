//
//  Created by Czajka, Kamil
//

import Foundation

extension Notification.Name {
    static let newDownloadedData = Notification.Name(rawValue: "newDownloadedData")
    static let explicityUpdateUI = Notification.Name(rawValue: "explicityUpdateUI")
    static let savePictureInDatabase = Notification.Name(rawValue: "savePictureInDatabase")
    static let stopActivityIndicator = Notification.Name(rawValue: "stopActivityIndicator")
}
