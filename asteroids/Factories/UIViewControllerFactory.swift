//
//  ControllerFactory.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/12/19.
//

import UIKit

protocol UIViewControllerFactory {
    func create(name: String) -> UIViewController
}
