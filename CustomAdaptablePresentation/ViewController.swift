//
//  ViewController.swift
//  CustomAdaptablePresentation
//
//  Created by Jake Carter on 8/10/15.
//  Copyright © 2015 Jake Carter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    
    @IBAction func buttonTapped(sender: UIBarButtonItem) {
        let ovc = OtherViewController()
        ovc.modalPresentationStyle = .Popover
        ovc.popoverPresentationController?.barButtonItem = sender
        ovc.popoverPresentationController?.delegate = self
        
        self.presentViewController(ovc, animated: true, completion: nil)
    }
    
    // MARK: UIAdaptivePresentationControllerDelegate
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        if (traitCollection.horizontalSizeClass == .Regular) {
            return .Popover
        }
        else {
            return .OverFullScreen
        }
    }
    
    func presentationController(presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
        let ovc = presentationController.presentedViewController as! OtherViewController
        
        if (style == .None) {
            ovc.configureForPopover()
        }
        else {
            assert(style == .OverFullScreen, "Expected .OverFullScreen.")
            ovc.configureForHalfHeight()
        }
    }
}

