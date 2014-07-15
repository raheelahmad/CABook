//
//  FlatteningViewController.swift
//  CABook
//
//  Created by Raheel Ahmad on 7/14/14.
//  Copyright (c) 2014 Sakun Labs. All rights reserved.
//

import UIKit
import QuartzCore

@objc(FlatteningViewController) class FlatteningViewController: UIViewController {
    
    enum Axis: Int {
        case Z = 0
        case X
    }

    @IBOutlet var outerView: UIView
    @IBOutlet var innerView: UIView
    @IBOutlet var `switch`: UISegmentedControl
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyRotation(nil)
    }
    
    @IBAction func showInfo(sender: AnyObject) {
        let info = "Applying an opposite transform to nested layers \"corrects\" them for rotations in X or Y axis. For 3D rotations (in Z axis) however, the correction doesn't apply. As the layer's sublayers are flattened, so the sublayer rotation doesn't have the cancelling effect."
        let infoVC = InfoViewController(info: info)
        presentViewController(infoVC, animated: true, completion: nil)
    }

    @IBAction func applyRotation(sender: AnyObject?) {
        switch Axis.fromRaw(`switch`.selectedSegmentIndex) as Axis {
        case Axis.Z:
        outerView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 0, 1)
        innerView.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_4), 0, 0, 1)
        case .X:
        outerView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_4), 1, 0, 1)
        innerView.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_4), 1, 0, 1)
        default:
            break
        }
        
    }
}
