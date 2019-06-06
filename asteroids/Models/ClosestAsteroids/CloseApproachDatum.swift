//
//  CloseApproachDatum.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/6/19.
//

import Foundation

internal struct CloseApproachDatum : Codable {
    let closeApproachDate: String
    let closeApproachDateFull: String?
    let epochDateCloseApproach: Int
    let relativeVelocity: RelativeVelocity
    let missDistance: MissDistance
    let orbitingBody: OrbitingBody
    
    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case closeApproachDateFull = "close_approach_date_full"
        case epochDateCloseApproach = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
        case orbitingBody = "orbiting_body"
    }
}
