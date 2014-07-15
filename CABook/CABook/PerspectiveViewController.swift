//
//  PerspectiveViewController.swift
//  CABook
//
//  Created by Raheel Ahmad on 7/13/14.
//  Copyright (c) 2014 Sakun Labs. All rights reserved.
//

import UIKit
import QuartzCore

@objc(PerspectiveViewController) class PerspectiveViewController: UIViewController {

    @IBOutlet strong var tajWidthConstraint: NSLayoutConstraint!
    @IBOutlet strong var tajHeightConstraint: NSLayoutConstraint!
    @IBOutlet var tajView: UIImageView
    @IBOutlet var slider: UISlider
    var hConstraints: [NSLayoutConstraint] = []
    var wConstraints: [NSLayoutConstraint] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        addInfoButton()
    }

    @IBAction func sliderValueChanged(sender: AnyObject) {
        view.removeConstraint(tajWidthConstraint)
        view.removeConstraint(tajHeightConstraint)
        
        let fraction = slider.value
        let value = 500.0 + fraction * (1000 - 500)
        
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/value
        transform = CATransform3DRotate(transform, CGFloat(M_PI_4), 0, 1, 0)
        
        tajView.layer.transform = transform
    }
    
    func addInfoButton() {
        let view = self.view
        
        let w = view.bounds.size.width
        let h = view.bounds.size.height
        let button = UIButton.buttonWithType(.InfoDark) as UIButton
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.addTarget(self, action: "showInfo", forControlEvents: .TouchUpInside)
        view.addSubview(button)
        
        let vd = [ "view": view, "button": button ]
        let md = [ "width": 24, "spacing": 10 ]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[button(width)]-spacing-|", options: nil, metrics: md, views: vd))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[button(width)]-spacing-|", options: nil, metrics: md, views: vd))
    }
    
    func showInfo() {
        let vc = UIViewController()
        let w = view.bounds.size.width
        let h = view.bounds.size.height
        vc.view.frame = CGRect(x: 0, y: h - 140, width: w, height: 140)
        vc.view.backgroundColor = UIColor.redColor()
        self.presentViewController(vc, animated: true, completion: nil)
    }
}
