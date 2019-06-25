//
//  Created by Czajka, Kamil
//

import UIKit

protocol DatabaseHandler {
    func connect()
    func insert(url eUrl: String, name eName: String, image: UIImage)
    func delete(whereUrl: String)
    func read() -> [FavouriteTable]
    func update(whereUrl: String, toName: String)
    func contain(url eUrl: String) -> Bool
}
