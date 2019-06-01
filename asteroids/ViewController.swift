//
//  ViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/1/19.
//

import UIKit

// TO STRUCT
struct NASA: Codable {
    let date: String
    let explanation: String
    let hdurl: String
    let media_type: String
    let service_version: String
    let title: String
    let url: String
}

class ViewController: UIViewController {
    @IBOutlet weak var resultField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func startDownload() {
        // REQUEST FACTORY?
        var requestBuilder = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        requestBuilder.queryItems = [
            URLQueryItem(name: "api_key", value: "K2O45BgzWeaeHQUueqOSeVCa95d2nckyadRYC8IL"),
            URLQueryItem(name: "date", value: "2019-05-16"),
            URLQueryItem(name: "hd", value: "true")
        ]
        guard let requestURL = requestBuilder.url else {
            fatalError("UNABLE TO GET URL FOR \(requestBuilder)")
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        // PROVIDER CLASS?
        let downloadData = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                fatalError("ERROR! + \(error)")
            }
            // 429 TOO MANY RESPONSE !!!
            guard let httpStatus = response as? HTTPURLResponse, 200...299 ~= httpStatus.statusCode else {
                fatalError("statusCode should be 200 - 299")
            }
            guard let data = data else {
                fatalError("NO DATA")
            }
            // DECODER CLASS?
            let json = try? JSONDecoder().decode(NASA.self, from: data)
            DispatchQueue.main.async {
                self.resultField.text = "\(json?.date)\n\(json?.explanation)\n\(json?.hdurl)\n\(json?.media_type)\n\(json?.service_version)\n\(json?.title)\n\(json?.url)"
            }
        }
        downloadData.resume()
    }
    // PRESENTER?
    @IBAction func downloadButton(_ sender: Any) {
        startDownload()
    }
    
}

