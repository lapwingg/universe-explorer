//
//  URLComponentsValidator.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import Foundation

protocol URLComponentsValidator {
    func validate(_ urlComponents: URLComponents?) -> URLComponents
}
