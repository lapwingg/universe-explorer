//
//  URLSessionValidator.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import Foundation

protocol URLSessionValidator {
    func validate(error: Error?)
    func validate(urlReponse: URLResponse?) -> URLResponse
    func validate(data: Data?) -> Data
}
