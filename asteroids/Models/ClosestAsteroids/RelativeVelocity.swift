//
//  RelativeVelocity.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/6/19.
//

import Foundation

internal struct RelativeVelocity : Codable {
    let kilometersPerSecond: String
    let kilometersPerHour: String
    let milesPerHour: String
    
    enum CodingKeys: String, CodingKey {
        case kilometersPerSecond = "kilometers_per_second"
        case kilometersPerHour = "kilometers_per_hour"
        case milesPerHour = "miles_per_hour"
    }
}

