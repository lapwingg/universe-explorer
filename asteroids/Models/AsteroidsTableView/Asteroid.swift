//
//  PrepareData.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/17/19.
//

import Foundation

internal class Asteroid {
    var name: String
    var diameterMax: Double
    var hazardous: Bool
    var sentry: Bool
    var absoluteMagnitude: Double
    var relativeVelocity: String
    
    init(name: String, diameterMax: Double, hazardous: Bool, sentry: Bool, absoluteMagnitude: Double, relativeVelocity: String) {
        self.name = name
        self.diameterMax = diameterMax
        self.hazardous = hazardous
        self.sentry = sentry
        self.absoluteMagnitude = absoluteMagnitude
        self.relativeVelocity = relativeVelocity
    }
}
