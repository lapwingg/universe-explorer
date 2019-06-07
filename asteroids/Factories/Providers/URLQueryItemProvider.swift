//
//  URLQueryItemProvider.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/7/19.
//

import Foundation

internal class URLQueryItemProvider {
    // non-static 
    private static let API_KEY = "K2O45BgzWeaeHQUueqOSeVCa95d2nckyadRYC8IL"
    
    internal static func getAuthenticationItem() -> URLQueryItem {
        return URLQueryItem(name: "api_key", value: API_KEY)
    }
    
    internal static func get(queryType: QueryType, date: Date) -> URLQueryItem {
        return URLQueryItem(name: queryType.associatedData.parameterName, value: DateParser.parseToString(date: date))
    }
}
