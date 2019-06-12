//
//  UIViewControllerValidatorImpl.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/12/19.
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

