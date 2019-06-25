//
//  Created by Czajka, Kamil
//

import UIKit

protocol UIViewControllerFactory {
    func create(name: String) -> UIViewController
}
