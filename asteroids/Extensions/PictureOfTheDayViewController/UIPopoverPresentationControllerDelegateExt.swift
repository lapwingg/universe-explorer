//
//  PictureOt.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/11/19.
//

import UIKit

extension PictureOfTheDayViewController: UIPopoverPresentationControllerDelegate {
    internal func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    internal func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return adaptivePresentationStyle(for: controller)
    }
}
