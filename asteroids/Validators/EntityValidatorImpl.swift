//
//  ModelValidatorImpl.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import Foundation

internal class EntityValidatorImpl : EntityValidator {
    internal func validate<Entity>(_ entity: Entity?) -> Entity where Entity : Decodable, Entity : Encodable {
        guard let validEntity = entity else {
            fatalError("Entity is nil")
        }
        return validEntity
    }
    
    
}
