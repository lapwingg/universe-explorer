//
//  Created by Czajka, Kamil
//

import Foundation

protocol DateFactory {
    func create(year: Int, month: Int, day: Int) -> Date
}
