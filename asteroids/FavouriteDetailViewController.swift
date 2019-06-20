//
//  FavouriteDetailViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/20/19.
//

import UIKit

class FavouriteDetailViewController: UIViewController {
    @IBOutlet weak var presentedImage: UIImageView!
    var dbModel: DatabaseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presentedImage.image = dbModel?.picture
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
