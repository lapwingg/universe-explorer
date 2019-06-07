//
//  URLComponentsProvider.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/4/19.
//

import Foundation

internal class URLComponentsProvider {
    // non-static , init
    internal static func get(queryType: QueryType) -> URLComponents {
        let urlCompoments = URLComponents(string: queryType.associatedData.baseURL)
        let validateResult = URLComponentsValidator().isValid(urlCompoments)
        if validateResult == false {
            fatalError("UNABLE TO GET COMPONENT")
        }
        return urlCompoments!
    }
}
