//
//  URLFactory.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/1/19.
//

import Foundation
 
internal class URLFactoryImpl : URLFactory {
    private var urlComponentsProvider: URLComponentsProvider!
    private var urlQueryItemProvider: URLQueryItemProvider!
    private var urlValidator: URLValidator!
    
    init() {
        urlComponentsProvider = URLComponentsProviderImpl()
        urlQueryItemProvider = URLQueryItemProviderImpl()
        urlValidator = URLValidatorImpl()
    }
    
    public func createRequest(queryType: QueryType, date: Date) -> URL {
        var request = urlComponentsProvider.get(queryType: queryType)
        request.queryItems = [
            urlQueryItemProvider.getAuthenticationItem(),
            urlQueryItemProvider.get(queryType: queryType, date: date)
        ]
        return urlValidator.validate(request.url)
    }
}
