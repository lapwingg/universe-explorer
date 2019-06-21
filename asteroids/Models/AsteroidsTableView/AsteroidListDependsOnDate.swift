//
//  AsteroidListDependsOnDate.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/21/19.
//

import Foundation

internal class AsteroidListDependsOnDate {
    var date: String
    var asteroids: [Asteroid] = []
    
    init(date: String) {
        self.date = date
    }
}
