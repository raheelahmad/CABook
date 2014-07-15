//
//  SublayerTransformViewController.swift
//  CABook
//
//  Created by Raheel Ahmad on 7/13/14.
//  Copyright (c) 2014 Sakun Labs. All rights reserved.
//

import UIKit
import QuartzCore

@objc(SublayerTransformViewController) class SublayerTransformViewController: UIViewController {

    @IBOutlet strong var taj1: UIImageView!
    @IBOutlet strong var taj2: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        applyTransform()
    }
    
    func applyTransform() {
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/500.0
        view.layer.sublayerTransform = transform
        
        taj1.layer.transform = CATransform3DRotate(transform, -CGFloat(M_PI_4), 0, 1, 0)
        taj2.layer.transform = CATransform3DRotate(transform, CGFloat(M_PI_4), 0, 1, 0)
    }

}
