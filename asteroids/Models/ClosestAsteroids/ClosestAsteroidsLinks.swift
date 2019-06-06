//
//  ClosestAsteroidsLinks.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/6/19.
//

import Foundation

internal struct ClosestAsteroidsLinks : Codable {
    let next: String
    let prev: String
    let linksSelf: String
    
    enum CodingKeys: String, CodingKey {
        case next
        case prev
        case linksSelf = "self"
    }
}
