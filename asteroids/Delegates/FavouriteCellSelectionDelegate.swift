//
//  Created by Czajka, Kamil
//

import Foundation

protocol FavouriteCellSelectionDelegate: class {
    func cellSelected(_ newData: FavouriteTable?)
    func reload()
}
