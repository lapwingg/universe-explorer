//
//  DataFormatter.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/5/19.
//

import Foundation

protocol DataFormatter {
    func getFormattedData(pictureOfTheDay: PictureOfTheDay) -> String
}
