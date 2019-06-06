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
        var request = URLComponentsProvider.get(queryType: .pictureOfTheDay)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "date", value: DateParser.parseToString(date: date)),
            URLQueryItem(name: "hd", value: String(quality))
        ]
        return request.url
    }
    
    public static func requestSingleAsteroidData(asteroidID: Int) -> URL? {
        var request = URLComponentsProvider.get(queryType: .asteroidsData)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "asteroidID", value: String(asteroidID))
        ]
        return request.url
    }
    
    public static func requestMarsRoverPhotos(date: Date) -> URL? {
        var request = URLComponentsProvider.get(queryType: .marsRoverPhotos)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "earth_date", value: DateParser.parseToString(date: date))
        ]
        return request.url
    }
    
    public static func requestAsteroidsStats() -> URL? {
        var request = URLComponentsProvider.get(queryType: .asteroidsStats)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY)
        ]
        return request.url
    }
    
    public static func requestAsteroidsData(page: Int, size: Int) -> URL? {
        var request = URLComponentsProvider.get(queryType: .asteroidsData)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "size", value: String(size))
        ]
        return request.url
    }
    
    public static func requestClosestAsteroids(startDate: Date, endDate: Date) -> URL? {
        var request = URLComponentsProvider.get(queryType: .closestAsteroids)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "startDate", value: DateParser.parseToString(date: startDate)),
            URLQueryItem(name: "endDate", value: DateParser.parseToString(date: endDate))
        ]
        return request.url
    }
}
