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
        // REQUEST FACTORY?
        // DATE VALIDATOR ?
        guard let requestURL = URLFactory.requestPictureOfTheDay(date: DateFactory.create(year: 2018, month: 08, day: 16), quality: true) else {
            fatalError("UNABLE TO GET URL")
        }
        print(requestURL)
        // PROVIDER CLASS?
        let downloadData = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let error = error {
                fatalError("ERROR! + \(error)")
            }
            // 429 TOO MANY RESPONSE !!!
    
            guard let httpStatus = response as? HTTPURLResponse, 200...299 ~= httpStatus.statusCode else {
                fatalError("statusCode should be 200 - 299")
            }
            print(httpStatus.statusCode)
            guard let data = data else {
                fatalError("NO DATA")
            }
            // DECODER CLASS?
            // DON'T KNOW IF IT'S JSON XDDD
            // ADAPTER :D 
//            do {
//                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
//                    // Print out dictionary
//                    print(convertedJsonIntoDict)
//                }
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
            let json = try? JSONDecoder().decode(PictureOfTheDay.self, from: data)

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

