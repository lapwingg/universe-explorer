//
//  ViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/1/19.
//

import UIKit

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
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=K2O45BgzWeaeHQUueqOSeVCa95d2nckyadRYC8IL") else {
            fatalError("Invalid URL!")
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                fatalError("ERROR! + \(error)")
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    fatalError("ERROR -> STATUS")
            }
            guard let data = data else {
                fatalError("NO DATA")
            }
            let json = try? JSONDecoder().decode(NASA.self, from: data)
            DispatchQueue.main.async {
                self.resultField.text = "\(json?.date)\n\(json?.explanation)\n\(json?.hdurl)\n\(json?.media_type)\n\(json?.service_version)\n\(json?.title)\n\(json?.url)"
            }
        }
        task.resume()
    }
    
    @IBAction func downloadButton(_ sender: Any) {
        startDownload()
    }
    
}

