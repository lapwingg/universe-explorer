//
//  URLQueryItemProvider.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/7/19.
//

import Foundation

internal class URLQueryItemProviderImpl : URLQueryItemProvider {
    private let API_KEY = "K2O45BgzWeaeHQUueqOSeVCa95d2nckyadRYC8IL"
    private var dateParser: DateParser!
    
    init() {
        dateParser = DateParserImpl()
    }
    
    internal func getAuthenticationItem() -> URLQueryItem {
        return URLQueryItem(name: "api_key", value: API_KEY)
    }
    
    internal func get(queryType: QueryType, date: Date) -> URLQueryItem {
        return URLQueryItem(name: queryType.associatedData.parameterName, value: dateParser.parseToString(date: date))
    }
}
