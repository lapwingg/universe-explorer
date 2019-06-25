//
//  Created by Czajka, Kamil
//

import Foundation

extension FavouriteDetailViewController: FavouriteCellSelectionDelegate {
    internal func cellSelected(_ newData: FavouriteTable?) {
        favouriteTableData = newData
    }
    
    internal func reload() {
        presentedImage.image = nil
        loadViewIfNeeded()
    }
}
