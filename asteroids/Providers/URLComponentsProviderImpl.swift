//
//  URLComponentsProvider.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/4/19.
//

import Foundation

internal class URLComponentsProviderImpl : URLComponentsProvider {
    private var validator: URLComponentsValidator!
    
    init() {
        validator = URLComponentsValidatorImpl()
    }
    
    internal func get(queryType: QueryType) -> URLComponents {
        let urlCompoments = URLComponents(string: queryType.associatedData.baseURL)
        return validator.validate(urlCompoments)
    }
}
