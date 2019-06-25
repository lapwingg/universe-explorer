//
//  Created by Czajka, Kamil
//

import Foundation

internal class DateParserImpl : DateParser {
    private var dateFormatter: DateFormatter!
    private var dateParserValidator: DateParserValidator!
    private let DEFAULT_FORMAT = "yyyy-MM-dd"
    
    init() {
        dateFormatter = DateFormatter()
        dateParserValidator = DateParserValidatorImpl()
        setDefaultFormat()
    }
    
    internal func parseToString(date: Date) -> String {
        let dateInString = dateFormatter.string(from: date)
        return dateParserValidator.validate(dateInString)
    }
    
    internal func parseToString(date: Date, format: String) -> String {
        dateFormatter.dateFormat = format
        return parseToString(date: date)
    }
    
    private func setDefaultFormat() {
        dateFormatter.dateFormat = DEFAULT_FORMAT
    }
}
