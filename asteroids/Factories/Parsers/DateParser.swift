//
//  DateParser.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/4/19.
//

import Foundation

internal class DateParser {
    // non-static init
    internal static func parseToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateInString = formatter.string(from: date)
        let validateResult = DateParserValidator().isValid(dateInString)
        if validateResult == false {
            fatalError("Unable parse to string for date: \(date)")
        }
        return dateInString
    }
}
