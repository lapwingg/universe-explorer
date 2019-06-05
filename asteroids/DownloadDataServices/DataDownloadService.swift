//
//  DateDownloader.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/4/19.
//

import Foundation

protocol DataDownloadService {
    func runDownload(completion: @escaping (Data) -> Void)
}
