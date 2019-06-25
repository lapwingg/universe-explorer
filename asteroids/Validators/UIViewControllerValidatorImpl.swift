//
//  Created by Czajka, Kamil
//

import UIKit

internal class UIViewControllerValidatorImpl : UIViewControllerValidator {
    func validate(_ uiViewController: UIViewController?) -> UIViewController {
        guard let validViewController = uiViewController else {
            fatalError("CONTROLLER DOES NOT EXIST")
        }
        return validViewController
    }
}

