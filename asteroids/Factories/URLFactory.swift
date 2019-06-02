//
//  URLFactory.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/1/19.
//

import Foundation

public class URLFactory {
    private static let API_KEY = "K2O45BgzWeaeHQUueqOSeVCa95d2nckyadRYC8IL"

    public static func requestPictureOfTheDay(date: Date, quality: Bool) -> URL? {
        var request = URLComponentsFactory.create(queryType: .pictureOfTheDay)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
         //   URLQueryItem(name: "date", value: String(date)),
     //       URLQueryItem(name: "hd", value: String(quality))
        ]
        return request.url
    }
    
    public static func requestSingleAsteroidData(asteroidID: Int) -> URL? {
        var request = URLComponentsFactory.create(queryType: .asteroidsData)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY)
   //         URLQueryItem(name: "asteroidID", value: asteroidID)
        ]
        return request.url
    }
    
    public static func requestMarsRoverPhotos(page: Int, sol: Int, camera: String) -> URL? {
        var request = URLComponentsFactory.create(queryType: .marsRoverPhotos)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
//            URLQueryItem(name: "page", value: page),
//            URLQueryItem(name: "sol", value: sol),
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
//            URLQueryItem(name: "page", value: page),
//            URLQueryItem(name: "size", value: size)
        ]
        return request.url
    }
    
    public static func requestClosestAsteroids(startDate: Date, endDate: Date) -> URL? {
        var request = URLComponentsFactory.create(queryType: .closestAsteroids)
        request.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
//            URLQueryItem(name: "startDate", value: startDate),
//            URLQueryItem(name: "endDate", value: endDate)
        ]
        return request.url
    }
}
