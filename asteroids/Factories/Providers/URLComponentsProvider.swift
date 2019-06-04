//
//  URLComponentsProvider.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/4/19.
//

import Foundation

internal class URLComponentsProvider {
    internal static func get(queryType: BaseURLForQuery) -> URLComponents {
        guard let urlCompoments = URLComponents(string: queryType.rawValue) else {
            fatalError("Not created URLComponents for \(queryType)")
        }
        return urlCompoments
    }
}
