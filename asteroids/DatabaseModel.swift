//
//  DatabaseModel.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/20/19.
//

import UIKit

class DatabaseModel {
    var url: String
    var name: String
    var picture: UIImage
    
    init(url: String, name: String, picture: UIImage) {
        self.url = url
        self.name = name
        self.picture = picture
    }
}
