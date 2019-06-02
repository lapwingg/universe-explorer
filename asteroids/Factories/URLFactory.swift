//
//  URLFactory.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/1/19.
//

import Foundation

internal class URLFactory {
    private static let API_KEY = "K2O45BgzWeaeHQUueqOSeVCa95d2nckyadRYC8IL"

    public static func requestPictureOfTheDay(date: Date, quality: Bool) -> URL? {
        var request = URLComponentsFactory.create(queryType: .pictureOfTheDay)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "date", value: DateFactory.parseToString(date: date)),
            URLQueryItem(name: "hd", value: String(quality))
        ]
        return request.url
    }
    
    public static func requestSingleAsteroidData(asteroidID: Int) -> URL? {
        var request = URLComponentsFactory.create(queryType: .asteroidsData)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "asteroidID", value: String(asteroidID))
        ]
        return request.url
    }
    
    public static func requestMarsRoverPhotos(page: Int, sol: Int, camera: String) -> URL? {
        var request = URLComponentsFactory.create(queryType: .marsRoverPhotos)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "sol", value: String(sol)),
            URLQueryItem(name: "camera", value: camera)
        ]
        return request.url
    }
    
    public static func requestAsteroidsStats() -> URL? {
        var request = URLComponentsFactory.create(queryType: .asteroidsStats)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY)
        ]
        return request.url
    }
    
    public static func requestAsteroidsData(page: Int, size: Int) -> URL? {
        var request = URLComponentsFactory.create(queryType: .asteroidsData)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "size", value: String(size))
        ]
        return request.url
    }
    
    public static func requestClosestAsteroids(startDate: Date, endDate: Date) -> URL? {
        var request = URLComponentsFactory.create(queryType: .closestAsteroids)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "startDate", value: DateFactory.parseToString(date: startDate)),
            URLQueryItem(name: "endDate", value: DateFactory.parseToString(date: startDate))
        ]
        return request.url
    }
}
