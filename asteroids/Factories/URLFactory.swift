//
//  Created by Czajka, Kamil
//

import Foundation

protocol URLFactory {
    func createRequest(queryType: QueryType, date: Date) -> URL
    func createRequest(link: String) -> URL
}
