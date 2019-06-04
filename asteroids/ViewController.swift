//
//  ViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/1/19.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultField: UITextView!
    private var downloader: DataDownloadService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloader = NASADownloadService()
    }

    private func startDownload() {
        var json = downloader?.startDownload()
        
        DispatchQueue.main.async {
            print("ADADADAD")
            self.resultField.text = "\(json?.date)\n\(json?.explanation)\n\(json?.hdurl)\n\(json?.media_type)\n\(json?.service_version)\n\(json?.title)\n\(json?.url)"
        }
    }
    
    // PRESENTER?
    @IBAction func downloadButton(_ sender: Any) {
        startDownload()
    }
}

