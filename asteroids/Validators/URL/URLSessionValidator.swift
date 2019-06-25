//
//  Created by Czajka, Kamil
//

import Foundation

protocol URLSessionValidator {
    func validate(error: Error?)
    func validate(urlReponse: URLResponse?) -> URLResponse
    func validate(data: Data?) -> Data
}
