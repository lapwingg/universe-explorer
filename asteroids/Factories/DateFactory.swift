//
//  DateFactory.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/2/19.
//

import Foundation

internal class DateFactory {
    internal static func create(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar.init(identifier: .gregorian)
        let timeZone = TimeZone(secondsFromGMT: 2)
        let dateComponents = DateComponents(calendar: calendar, timeZone: timeZone, year: year, month: month, day: day)
        guard dateComponents.isValidDate(in: calendar) else {
            fatalError("Invalid data \(year) - \(month) - \(day) in Gregorian calendar")
        }
        guard let date = dateComponents.date else {
            fatalError("Unable to create data for \(year) - \(month) - \(day)")
        }
        return date
    }
}
