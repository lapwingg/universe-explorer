//
//  PrepareData.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/17/19.
//

import Foundation

class DataA {
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

class PrepareData {
    var date: String
    var data: [DataA] = []
    
    init(date: String) {
        self.date = date
    }
}
