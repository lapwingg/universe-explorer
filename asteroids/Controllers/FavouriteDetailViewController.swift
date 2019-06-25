//
//  Created by Czajka, Kamil
//

import UIKit

internal class FavouriteDetailViewController: UIViewController {
    @IBOutlet weak var presentedImage: UIImageView!
    internal var favouriteTableData: FavouriteTable? {
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
