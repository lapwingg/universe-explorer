//
//  Created by Czajka, Kamil
//

import Foundation

internal class URLQueryItemProviderImpl : URLQueryItemProvider {
    private var dateParser: DateParser!
    private let API_KEY = "K2O45BgzWeaeHQUueqOSeVCa95d2nckyadRYC8IL"
    private let PARAMETER_NAME = "api_key"
    
    init() {
        dateParser = DateParserImpl()
    }
    
    internal func getAuthenticationItem() -> URLQueryItem {
        return URLQueryItem(name: PARAMETER_NAME, value: API_KEY)
    }
    
    internal func get(queryType: QueryType, date: Date) -> URLQueryItem {
        return URLQueryItem(name: queryType.associatedData.parameterName, value: dateParser.parseToString(date: date))
    }
}
