//
//  NASADownloader.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/4/19.
//

import Foundation

internal class NASADownloadService : DataDownloadService {
    private var urlFactory: URLFactory!
    private var dateFactory: DateFactory!
    private var urlSessionValidator: URLSessionValidator!
    private let DATE = (YEAR: 2019, MONTH: 06, DAY: 06)
    
    init() {
        urlFactory = URLFactoryImpl()
        dateFactory = DateFactoryImpl()
        urlSessionValidator = URLSessionValidatorImpl()
    }
    
    internal func runDownload(queryType: QueryType, completion: @escaping (Data) -> Void) {
        let requestURL = getRequestURL(queryType)

        DispatchQueue.global(qos: .userInteractive).async {
            _ = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                self.urlSessionValidator.validate(error: error)
                _ = self.urlSessionValidator.validate(urlReponse: response)
                let data = self.urlSessionValidator.validate(data: data)
                DispatchQueue.main.async {
                    completion(data)
                }
            }.resume()
        }
    }
    
    private func getRequestURL(_ queryType: QueryType) -> URL {
        let date = dateFactory.create(year: DATE.YEAR, month: DATE.MONTH, day: DATE.DAY)
        return urlFactory.createRequest(queryType: queryType, date: date)
    }
}
