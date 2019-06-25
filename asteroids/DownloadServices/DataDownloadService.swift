//
//  Created by Czajka, Kamil
//

import Foundation

protocol DataDownloadService {
    func runDownload(date: Date, queryType: QueryType, completion: @escaping (Data) -> Void)
}
