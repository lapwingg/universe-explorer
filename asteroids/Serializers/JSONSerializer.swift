//
//  JSONSerializer.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/5/19.
//

import Foundation

internal class JSONSerializer : Serializer {
    internal func decode(data: Data, completion: @escaping (PictureOfTheDay) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            let pictureOfTheDay = try? JSONDecoder().decode(PictureOfTheDay.self, from: data)
            if pictureOfTheDay == nil {
                fatalError("Cannot deserialize data from JSON")
            }
            
            DispatchQueue.main.async {
                completion(pictureOfTheDay!)
            }
        }
    }
}
