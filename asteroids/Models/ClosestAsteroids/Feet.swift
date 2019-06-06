//
//  Feet.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/6/19.
//

import Foundation

internal struct Feet : Codable {
    let estimatedDiameterMin: Double
    let estimatedDiameterMax: Double
    
    enum CodingKeys: String, CodingKey {
        case estimatedDiameterMin = "estimated_diameter_min"
        case estimatedDiameterMax = "estimated_diameter_max"
    }
}
