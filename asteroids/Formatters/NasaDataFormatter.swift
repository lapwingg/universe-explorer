//
//  NasaDataFormatter.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/5/19.
//

import Foundation

internal class NasaDataFormatter : DataFormatter {
    internal func getFormattedData(pictureOfTheDay: PictureOfTheDay) -> String {
        return "\(pictureOfTheDay.date)\n\(pictureOfTheDay.explanation)\n\(pictureOfTheDay.hdurl)\n\(pictureOfTheDay.media_type)\n\(pictureOfTheDay.service_version)\n\(pictureOfTheDay.title)\n\(pictureOfTheDay.url)"
    }
}
