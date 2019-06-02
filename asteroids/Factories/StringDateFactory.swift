//
//  DateFactory.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/2/19.
//

import Foundation

internal class StringDateFactory {
    internal static func create(year: Int, month: Int, day: Int) -> String {
        switch (month, day) {
            case (1..<10, 1..<10):
                return "\(year)-0\(month)-0\(day)"
            case (1..<10, day):
                return "\(year)-0\(month)-\(day)"
            case (month, 1..<10):
                return "\(year)-\(month)-0\(day)"
            case (month, day):
                return "\(year)-\(month)-\(day)"
            default:
                fatalError("Unable to create string date for values \(year), \(month), \(day)")
        }
    }
}
