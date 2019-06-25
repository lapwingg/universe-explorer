//
//  Created by Czajka, Kamil
//

import UIKit

protocol ImageDownloadService {
    func runDownload(link: String, completion: @escaping (UIImage?) -> Void)
}
