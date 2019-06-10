//
//  PageView2Controller.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import UIKit

class PageView2Controller: UIViewController {
    @IBOutlet weak var textView2: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DUPA")
       
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(_:)), name: .dataTap, object: nil)
        NotificationCenter.default.post(name: .dataNoTap, object: PageViewController.self)
        // Do any additional setup after loading the view.
    }
    
    @objc func updateUI(_ notification: NSNotification) {
        print("Page2")
        let p = notification.userInfo?["picture"] as? PictureOfTheDay
        if p == nil {
            textView2.text = "Page2"
        } else {
            textView2.text = "\(p?.date)\n\n\n\(p?.title)\n\n\(p?.explanation)"
        }
    }
}
