//
//  URLComponentsValidator.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/7/19.
//

import Foundation

internal class URLComponentsValidator {
    internal func isValid(_ urlCompoments: URLComponents?) -> Bool {
        if urlCompoments != nil {
            return true
        }
        return false
    }
}
