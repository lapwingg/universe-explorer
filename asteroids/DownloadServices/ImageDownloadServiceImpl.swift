//
//  Created by Czajka, Kamil
//

import UIKit

internal class ImageDownloadServiceImpl : ImageDownloadService {
    private var urlFactory: URLFactory!
    private var urlSessionValidator: URLSessionValidator!
    
    init() {
        urlFactory = URLFactoryImpl()
        urlSessionValidator = URLSessionValidatorImpl()
    }
    
    internal func runDownload(link: String, completion: @escaping (UIImage?) -> Void) {
        let requestURL = urlFactory.createRequest(link: link)
        
        DispatchQueue.global(qos: .background).async {
            _ = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                self.urlSessionValidator.validate(error: error)
                _ = self.urlSessionValidator.validate(urlReponse: response)
                let data = self.urlSessionValidator.validate(data: data)
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            }.resume()
        }
    }
}
