//
//  DateValidator.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/7/19.
//

import Foundation

internal class DateValidator {
    internal func isValidDateInCalendar(dateComponents: DateComponents, calendar: Calendar) -> Bool {
        return dateComponents.isValidDate(in: calendar)
    }
    
    internal func isValidDateObject(_ date: Date?) -> Bool {
        if date != nil {
            return true
        }
        return false
    }
}
