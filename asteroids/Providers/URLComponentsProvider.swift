//
//  Created by Czajka, Kamil
//

import Foundation

protocol URLComponentsProvider {
    func get(queryType: QueryType) -> URLComponents
}
