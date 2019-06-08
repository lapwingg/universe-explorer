//
//  DateParser.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/4/19.
//

import Foundation

internal class DateParserImpl : DateParser {
    var dateFormatter: DateFormatter!
    var dateParserValidator: DateParserValidator!
    
    init() {
        dateFormatter = DateFormatter()
        dateParserValidator = DateParserValidatorImpl()
        setDateFormat()
    }
    
    internal func parseToString(date: Date) -> String {
        let dateInString = dateFormatter.string(from: date)
        return dateParserValidator.validate(dateInString)
    }
    
    private func setDateFormat() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
}
