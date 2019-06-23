//
//  FavouriteDetailViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/20/19.
//

import UIKit

class FavouriteDetailViewController: UIViewController {
    @IBOutlet weak var presentedImage: UIImageView!
    var favouriteTableData: FavouriteTable? {
        didSet {
            if favouriteTableData != nil {
                presentedImage.image = favouriteTableData?.picture
                loadViewIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadViewIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presentedImage.image = nil
    }
}
