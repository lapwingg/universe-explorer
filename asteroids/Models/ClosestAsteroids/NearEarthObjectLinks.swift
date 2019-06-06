//
//  NearEarthObjectLinks.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/6/19.
//

import Foundation

internal struct NearEarthObjectLinks : Codable {
    let linksSelf: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}
