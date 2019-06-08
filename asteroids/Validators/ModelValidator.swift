//
//  ModelValidator.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import Foundation

protocol ModelValidator {
    func validate<Entity>(_ entity: Entity?) -> Entity where Entity : Codable
}
