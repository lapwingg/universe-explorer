//
//  Created by Czajka, Kamil
//

import Foundation
 
internal class URLFactoryImpl : URLFactory {
    private var urlComponentsProvider: URLComponentsProvider!
    private var urlQueryItemProvider: URLQueryItemProvider!
    private var urlValidator: URLValidator!
    
    init() {
        urlComponentsProvider = URLComponentsProviderImpl()
        urlQueryItemProvider = URLQueryItemProviderImpl()
        urlValidator = URLValidatorImpl()
    }
    
    internal func createRequest(queryType: QueryType, date: Date) -> URL {
        var request = urlComponentsProvider.get(queryType: queryType)
        request.queryItems = [
            urlQueryItemProvider.getAuthenticationItem(),
            urlQueryItemProvider.get(queryType: queryType, date: date)
        ]
        return urlValidator.validate(request.url)
    }
    
    internal func createRequest(link: String) -> URL {
        let url = URL(string: link)
        return urlValidator.validate(url)
    }
}
