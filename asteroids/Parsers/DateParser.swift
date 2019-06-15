//
//  DateParser.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import Foundation

// refactor !  broken Liskov !!!
@objc protocol DateParser {
    func parseToString(date: Date) -> String
    @objc optional func parseToString(date: Date, format: String) -> String
}
