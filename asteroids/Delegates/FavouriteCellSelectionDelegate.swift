//
//  FavouriteCellSelectionDelegate.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/23/19.
//

import Foundation

protocol FavouriteCellSelectionDelegate: class {
    func cellSelected(_ newData: FavouriteTable?)
    func reload()
}
