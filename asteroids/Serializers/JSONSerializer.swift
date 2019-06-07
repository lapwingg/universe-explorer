//
//  JSONSerializer.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/5/19.
//

import Foundation

internal class JSONSerializer : Serializer {
    // Validator 
    func decode<Entity>(ofType: Entity.Type, data: Data, completion: @escaping (Entity) -> Void) where Entity : Codable {
        DispatchQueue.global(qos: .utility).async {
            let resultEntity = try? JSONDecoder().decode(ofType.self, from: data)
            if resultEntity == nil {
                fatalError("Cannot deserialize data from JSON")
            }
            
            DispatchQueue.main.async {
                completion(resultEntity!)
            }
        }
    }
}
