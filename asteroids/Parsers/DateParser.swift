//
//  Created by Czajka, Kamil
//

import Foundation

protocol DateParser {
    func parseToString(date: Date) -> String
    func parseToString(date: Date, format: String) -> String
}
