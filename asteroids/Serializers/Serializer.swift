//
//  Serializer.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/5/19.
//

import Foundation

protocol Serializer {
    func decode(data: Data, completion: @escaping (PictureOfTheDay) -> Void)
}
