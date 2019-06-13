//
//  DateDownloader.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/4/19.
//

import Foundation

protocol DataDownloadService {
    func runDownload(date: Date, queryType: QueryType, completion: @escaping (Data) -> Void)
}
