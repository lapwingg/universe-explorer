//
//  Created by Czajka, Kamil
//

import Foundation

internal class AsteroidListDependsOnDate {
    internal var date: String
    internal var asteroids: [Asteroid] = []
    
    init(date: String) {
        self.date = date
    }
}
