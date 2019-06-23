//
//  AsteroidListDependsOnDate.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/21/19.
//

import Foundation

internal class AsteroidListDependsOnDate {
    internal var date: String
    internal var asteroids: [Asteroid] = []
    
    init(date: String) {
        self.date = date
    }
}
