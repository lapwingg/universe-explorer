//
//  JSONSerializer.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/5/19.
//

import Foundation

internal class JSONSerializer : Serializer {
    private var modelValidator: ModelValidator!
    
    init() {
        modelValidator = ModelValidatorImpl()
    }
    
    func decode<Entity>(ofType: Entity.Type, data: Data, completion: @escaping (Entity) -> Void) where Entity : Codable {
        DispatchQueue.global(qos: .utility).async {
            let resultEntity = try? JSONDecoder().decode(ofType.self, from: data)
            let validEntity = self.modelValidator.validate(resultEntity)
            DispatchQueue.main.async {
                completion(validEntity)
            }
        }
    }
}
