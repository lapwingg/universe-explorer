//
//  DateParserValidator.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/7/19.
//

import Foundation

internal class DateParserValidatorImpl : DateParserValidator {
    internal func validate(_ dateInString: String) -> String {
        if dateInString.isEmpty {
            fatalError("EMPTY DATE IN STRING")
        }
        return dateInString
    }
}
