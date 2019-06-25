//
//  DateParser.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import Foundation

protocol DateParser {
    func parseToString(date: Date) -> String
    func parseToString(date: Date, format: String) -> String
}
