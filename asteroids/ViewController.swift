//
//  ViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/1/19.
//

import UIKit

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
            do {
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
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                    fatalError("CONVERSION ERROR")
                }
                print(json)
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }
        task.resume()
    }
    
    @IBAction func downloadButton(_ sender: Any) {
        startDownload()
    }
    
}

