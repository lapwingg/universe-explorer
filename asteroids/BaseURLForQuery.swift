//
//  URLQueryType.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/2/19.
//

import Foundation

public enum BaseURLForQuery : String {
    case pictureOfTheDay = "https://api.nasa.gov/planetary/apod"
    case singleAsteroidData = "https://api.nasa.gov/neo/rest/v1/neo/"
    case marsRoverPhotos = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos"
    case asteroidsStats = "https://api.nasa.gov/neo/rest/v1/neo/browse"
    case asteroidsData = ""
    case closestAsteroids = "https://api.nasa.gov/neo/rest/v1/feed"
}
