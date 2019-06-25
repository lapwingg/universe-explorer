//
//  Created by Czajka, Kamil
//

import UIKit

internal class FavouriteTable {
    internal var url: String
    internal var name: String
    internal var picture: UIImage
    
    init(url: String, name: String, picture: UIImage) {
        self.url = url
        self.name = name
        self.picture = picture
    }
}
