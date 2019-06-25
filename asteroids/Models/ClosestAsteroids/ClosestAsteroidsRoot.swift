//
//  Created by Czajka, Kamil
//

import Foundation

internal struct ClosestAsteroidsRoot : Codable {
    let links: ClosestAsteroidsLinks
    let elementCount: Int
    let nearEarthObjects: [String: [NearEarthObject]]
    
    enum CodingKeys: String, CodingKey {
        case links
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
}
