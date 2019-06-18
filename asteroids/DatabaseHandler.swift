//
//  DatabaseHandler.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/18/19.
//

import UIKit

protocol DatabaseHandler {
    func connect()
    func insert(image: UIImage)
    func delete()
    func read()
    func update()
}
