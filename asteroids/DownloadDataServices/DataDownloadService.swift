//
//  DateDownloader.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/4/19.
//

import Foundation

protocol DataDownloadService {
    func runDownload(queryType: QueryType, completion: @escaping (Data) -> Void)
}
