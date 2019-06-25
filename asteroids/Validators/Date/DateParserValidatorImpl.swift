//
//  Created by Czajka, Kamil
//

import Foundation

internal class DateParserValidatorImpl : DateParserValidator {
    internal func validate(_ dateInString: String) -> String {
        if dateInString.isEmpty {
            fatalError("EMPTY DATE IN STRING")
        }
        return dateInString
    }
}
