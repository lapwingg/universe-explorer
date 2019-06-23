//
//  FavouriteCellSelectionDelegateImpl.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/23/19.
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
