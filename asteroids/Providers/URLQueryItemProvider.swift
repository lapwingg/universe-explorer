//
//  Created by Czajka, Kamil
//

import Foundation

protocol URLQueryItemProvider {
    func getAuthenticationItem() -> URLQueryItem
    func get(queryType: QueryType, date: Date) -> URLQueryItem
}
