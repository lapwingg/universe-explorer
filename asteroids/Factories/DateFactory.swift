//
//  DateFactory.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import Foundation

protocol DateFactory {
    func create(year: Int, month: Int, day: Int) -> Date
}
