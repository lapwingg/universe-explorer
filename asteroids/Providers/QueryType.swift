//
//  Created by Czajka, Kamil
//

import Foundation

internal enum QueryType : String {
    case pictureOfTheDay
    case marsRoverPhotos
    case closestAsteroids
    
    internal var associatedData: (baseURL: String, parameterName: String) {
        switch self {
        case .pictureOfTheDay:
            return ("https://api.nasa.gov/planetary/apod", "date")
        case .marsRoverPhotos:
            return ("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos", "earth_date")
        case .closestAsteroids:
            return ("https://api.nasa.gov/neo/rest/v1/feed", "startDate")
        }
    }
}
