//
//  NotificationExtension.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/10/19.
//

import Foundation

extension Notification.Name {
    static let newDownloadedData = Notification.Name(rawValue: "newDownloadedData")
    static let explicityUpdateUI = Notification.Name(rawValue: "explicityUpdateUI")
    static let savePictureInDatabase = Notification.Name(rawValue: "savePictureInDatabase")
}
