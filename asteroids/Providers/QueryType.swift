//
//  QueryType.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/7/19.
//

import Foundation

internal enum QueryType : String {
    case pictureOfTheDay
    case singleAsteroidData
    case marsRoverPhotos
    case asteroidsStats
    case asteroidsData
    case closestAsteroids
    
    internal var associatedData: (baseURL: String, parameterName: String) {
        switch self {
        case .pictureOfTheDay:
            return ("https://api.nasa.gov/planetary/apod", "date")
        case .singleAsteroidData:
            return ("https://api.nasa.gov/neo/rest/v1/neo", "")
        case .marsRoverPhotos:
            return ("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos", "earth_date")
        case .asteroidsStats:
            return ("https://api.nasa.gov/neo/rest/v1/neo/browse", "")
        case .asteroidsData:
            return ("", "")
        case .closestAsteroids:
            return ("https://api.nasa.gov/neo/rest/v1/feed", "startDate")
        }
    }
}
