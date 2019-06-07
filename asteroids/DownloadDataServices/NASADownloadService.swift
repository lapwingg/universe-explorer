//
//  NASADownloader.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/4/19.
//

import Foundation

internal class NASADownloadService : DataDownloadService {
    internal func runDownload(queryType: QueryType, completion: @escaping (Data) -> Void) {
        let requestURL = getRequestURL(queryType)
        
        // Validator !
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
    
    private func getRequestURL(_ queryType: QueryType) -> URL {
        let date = DateFactory.create(year: 2019, month: 06, day: 06)
        guard let requestURL = URLFactory.createRequest(queryType: queryType, date: date) else {
            fatalError("UNABLE TO GET URL")
        }
        return requestURL
    }
}
