//
//  URLFactory.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/1/19.
//

import Foundation
 
internal class URLFactory {
    // non-static init 
    public static func createRequest(queryType: QueryType, date: Date) -> URL? {
        var request = URLComponentsProvider.get(queryType: queryType)
        request.queryItems = [
            URLQueryItemProvider.getAuthenticationItem(),
            URLQueryItemProvider.get(queryType: queryType, date: date)
        ]
        return request.url
    }
}
