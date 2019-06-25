//
//  Created by Czajka, Kamil
//

import Foundation

internal class URLComponentsValidatorImpl : URLComponentsValidator {
    internal func validate(_ urlComponents: URLComponents?) -> URLComponents {
        guard let validURLComponents = urlComponents else {
            fatalError("INVALID URL COMPONENTS OBJECT \(String(describing: urlComponents))")
        }
        return validURLComponents
    }
}
