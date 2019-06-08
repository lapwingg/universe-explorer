//
//  DateValidator.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import Foundation

protocol DateValidator {
    func validate(dateComponents: DateComponents, calendar: Calendar) -> DateComponents
    func validate(_ date: Date?) -> Date
}
