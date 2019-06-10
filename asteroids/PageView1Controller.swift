//
//  PageView1Controller.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import UIKit

class PageView1Controller: UIViewController {
    @IBOutlet weak var textView1: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(_:)), name: .dataTap, object: nil)
        NotificationCenter.default.post(name: .dataNoTap, object: PageViewController.self)
        // Do any additional setup after loading the view.
    }
    
    @objc func updateUI(_ notification: NSNotification) {
        print("Page1")

        let p = notification.userInfo?["picture"] as? PictureOfTheDay
        if p == nil {
            textView1.text = "Page1"
        } else {
            textView1.text = "\(p?.date)\n\n\n\(p?.url)"
        }
    }
    
}
