//
//  URLValidator.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import Foundation

protocol URLValidator {
    func validate(_ url: URL?) -> URL
}
