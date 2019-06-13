//
//  URLFactory.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import Foundation

protocol URLFactory {
    func createRequest(queryType: QueryType, date: Date) -> URL
    func createRequest(link: String) -> URL
}
