//
//  URLQueryItemProvider.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import Foundation

protocol URLQueryItemProvider {
    func getAuthenticationItem() -> URLQueryItem
    func get(queryType: QueryType, date: Date) -> URLQueryItem
}
