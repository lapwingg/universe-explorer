//
//  URLComponentsProvider.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import Foundation

protocol URLComponentsProvider {
    func get(queryType: QueryType) -> URLComponents
}
