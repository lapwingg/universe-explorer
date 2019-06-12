//
//  URLValidatorImpl.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import Foundation

internal class URLValidatorImpl : URLValidator {
    internal func validate(_ url: URL?) -> URL {
        guard let validURL = url else {
            fatalError("INVALID URL \(String(describing: url))")
        }
        return validURL
    }
}
