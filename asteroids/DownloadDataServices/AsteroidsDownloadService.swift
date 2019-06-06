//
//  AsteroidsDownloadService.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/6/19.
//

import Foundation

internal class AsteroidsDownloadService : DataDownloadService {
    internal func runDownload(completion: @escaping (Data) -> Void) {
        let requestURL = getRequestURL()
        
        DispatchQueue.global(qos: .userInteractive).async {
            _ = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                if let error = error {
                    fatalError("ERROR! + \(error)")
                }
                // 429 TOO MANY RESPONSE !!!
                guard let httpStatus = response as? HTTPURLResponse, 200...299 ~= httpStatus.statusCode else {
                    fatalError("statusCode should be 200 - 299")
                }
                
                guard let data = data else {
                    fatalError("NO DATA PICTURE OF THE DAY")
                }
                
                DispatchQueue.main.async {
                    completion(data)
                }
                }.resume()
        }
    }
    
    private func getRequestURL() -> URL {
        let date = DateFactory.create(year: 2019, month: 06, day: 04)
        guard let requestURL = URLFactory.requestClosestAsteroids(date: date) else {
            fatalError("UNABLE TO GET URL CLOSEST ASTEROIDS")
        }
        return requestURL
    }
}
