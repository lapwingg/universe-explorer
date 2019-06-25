//
//  Created by Czajka, Kamil
//

import UIKit

internal class UIViewControllerFactoryImpl : UIViewControllerFactory {
    private let STORYBOARD_NAME = "Main"
    
    func create(name: String) -> UIViewController {
        return UIStoryboard(name: STORYBOARD_NAME, bundle: nil).instantiateViewController(withIdentifier: name)
    }
}
