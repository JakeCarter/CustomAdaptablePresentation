//
//  OtherViewController.swift
//  CustomAdaptablePresentation
//
//  Created by Jake Carter on 8/10/15.
//  Copyright © 2015 Jake Carter. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController {
    
    @IBOutlet weak var embeddedView: UIView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    var isCurrentlyHalfHeight: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
    }

    @IBAction func dismissButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func configureForPopover() {
        self.isCurrentlyHalfHeight = false
        
        self.topConstraint.constant = 0
    }
    
    func configureForHalfHeight() {
        self.isCurrentlyHalfHeight = true
        
        guard let presentingSize = self.presentingViewController?.view.bounds.size else {
            // Unknown presentingSize.
            return
        }
        
        self.configureHalfHeightForSize(presentingSize)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (context) -> Void in
            if (self.isCurrentlyHalfHeight) {
                self.configureHalfHeightForSize(size)
            }
            }, completion: nil)
    }
    
    
    private func configureHalfHeightForSize(size: CGSize) {
        let presentingHeight = size.height
        let desiredHeight = fmin(presentingHeight * 0.65, 370)
        
        let topPadding = (presentingHeight - desiredHeight)
        
        self.topConstraint.constant = topPadding
    }

}
