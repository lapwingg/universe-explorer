//
//  PictureOfTheDay.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/1/19.
//

import Foundation

internal struct PictureOfTheDay : Codable {
    let date: String
    let explanation: String
    let hdurl: String
    let media_type: String
    let service_version: String
    let title: String
    let url: String
}
