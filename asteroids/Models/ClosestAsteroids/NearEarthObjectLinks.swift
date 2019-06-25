//
//  Created by Czajka, Kamil
//

import Foundation

internal struct NearEarthObjectLinks : Codable {
    let linksSelf: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}
