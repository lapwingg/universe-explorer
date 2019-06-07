//
//  DateParserValidator.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/7/19.
//

import Foundation

internal class DateParserValidator {
    internal func isValid(_ dateInString: String) -> Bool {
        if dateInString.isEmpty {
            return false
        }
        return true
    }
}
