//
//  ImageDownloadService.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/12/19.
//

import UIKit

protocol ImageDownloadService {
    func runDownload(link: String, completion: @escaping (UIImage?) -> Void)
}
