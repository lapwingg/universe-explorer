//
//  UIViewControllerValidator.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/12/19.
//

import UIKit

protocol UIViewControllerValidator {
    func validate(_ uiViewController: UIViewController?) -> UIViewController
}
