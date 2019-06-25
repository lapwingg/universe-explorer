//
//  Created by Czajka, Kamil
//

import Foundation

internal class URLSessionValidatorImpl : URLSessionValidator {
    func validate(error: Error?) {
        if let error = error {
            fatalError("ERROR! + \(error)")
        }
    }
    
    func validate(urlReponse: URLResponse?) -> URLResponse {
        guard let httpStatus = urlReponse as? HTTPURLResponse, 200...299 ~= httpStatus.statusCode else {
            fatalError("statusCode should be 200 - 299")
        }
        return httpStatus
    }
    
    func validate(data: Data?) -> Data {
        guard let validData = data else {
            fatalError("NO DATA")
        }
        return validData
    }
}
