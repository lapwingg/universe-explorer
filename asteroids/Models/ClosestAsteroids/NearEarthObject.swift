//
//  NearEarthObject.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/6/19.
//

import Foundation

internal struct NearEarthObject : Codable {
    let links: NearEarthObjectLinks
    let id: String
    let neoReferenceID: String
    let name: String
    let nasaJplURL: String
    let absoluteMagnitudeH: Double
    let estimatedDiameter: EstimatedDiameter
    let isPotentiallyHazardousAsteroid: Bool
    let closeApproachData: [CloseApproachDatum]
    let isSentryObject: Bool
    
    enum CodingKeys: String, CodingKey {
        case links
        case id
        case neoReferenceID = "neo_reference_id"
        case name
        case nasaJplURL = "nasa_jpl_url"
        case absoluteMagnitudeH = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
        case isSentryObject = "is_sentry_object"
    }
}
