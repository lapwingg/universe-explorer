//
//  Created by Czajka, Kamil
//

import Foundation

internal class Asteroid {
    internal var name: String
    internal var diameterMax: Double
    internal var hazardous: Bool
    internal var sentry: Bool
    internal var absoluteMagnitude: Double
    internal var relativeVelocity: String
    
    init(name: String, diameterMax: Double, hazardous: Bool, sentry: Bool, absoluteMagnitude: Double, relativeVelocity: String) {
        self.name = name
        self.diameterMax = diameterMax
        self.hazardous = hazardous
        self.sentry = sentry
        self.absoluteMagnitude = absoluteMagnitude
        self.relativeVelocity = relativeVelocity
    }
}
