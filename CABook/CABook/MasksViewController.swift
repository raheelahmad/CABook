//
//  MasksViewController.swift
//  CABook
//
//  Created by Raheel Ahmad on 7/9/14.
//  Copyright (c) 2014 Sakun Labs. All rights reserved.
//

import UIKit
import QuartzCore

@objc(MasksViewController) class MasksViewController: UIViewController {
    @IBOutlet var tajView: UIImageView
    
    convenience init() {
        self.init(nibName: "MasksViewController", bundle: nil)
    }

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let maskLayer = CALayer()
        let maskImage = UIImage(named: "blob")
        maskLayer.bounds = CGRect(x: 0, y: 0, width: maskImage.size.width, height: maskImage.size.height)
        maskLayer.position = CGPoint(x: CGRectGetMidX(tajView.bounds), y: CGRectGetMidY(tajView.bounds))
        maskLayer.contents = maskImage.CGImage
        
        println(maskLayer.bounds)
        
        tajView.layer.mask = maskLayer
    }
}
