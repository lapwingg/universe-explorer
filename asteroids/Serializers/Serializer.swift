//
//  Serializer.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/5/19.
//

import Foundation

protocol Serializer {
    func decode<Entity>(ofType: Entity.Type, data: Data, completion: @escaping (Entity) -> Void) where Entity : Codable
}
