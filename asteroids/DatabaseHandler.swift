//
//  DatabaseHandler.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/18/19.
//

import UIKit

protocol DatabaseHandler {
    func connect()
    func insert(url eUrl: String, name eName: String, image: UIImage)
    func delete(whereUrl: String)
    func read() -> [DatabaseModel]
    func update(whereUrl: String, toName: String)
    func contain(url eUrl: String) -> Bool
}
