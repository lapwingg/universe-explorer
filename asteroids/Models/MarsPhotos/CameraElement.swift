//
//  Created by Czajka, Kamil
//

import Foundation

internal struct CameraElement: Codable {
    let name: String
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}
