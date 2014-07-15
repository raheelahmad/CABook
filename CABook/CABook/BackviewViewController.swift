//
//  BackviewViewController.swift
//  CABook
//
//  Created by Raheel Ahmad on 7/13/14.
//  Copyright (c) 2014 Sakun Labs. All rights reserved.
//

import UIKit
import QuartzCore

@objc(BackviewViewController) class BackviewViewController: UIViewController {

    @IBOutlet strong var tajView: UIImageView!
    
    var timer: NSTimer?
    var tickCount = 0
    
    @IBAction func switchDoubleSidedness(sender: UISwitch) {
        tajView.layer.doubleSided = sender.on
    }
    
    @IBAction func showInfo(sender: AnyObject) {
        let info = "The doubleSided property controls whether the layer's back view (when rotated by 180° on its x or y axis) is a mirror of its front contents or not."
        let infoVC = InfoViewController(info: info)
        presentViewController(infoVC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tajView.layer.borderColor = UIColor.darkGrayColor().CGColor
        tajView.layer.borderWidth = 1.0
        animate()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer!.invalidate()
    }
    
    func animate() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "tick", userInfo: nil, repeats: true)
        tickCount = 0
        tick()
    }
    
    func tick() {
        if tickCount > 360 {
            tickCount = 0
        }
        let angle = Double(tickCount) * M_PI / 180
        var transform = CATransform3DIdentity
        transform.m34 = -1/500.0
        transform = CATransform3DRotate(transform, CGFloat(angle), 0, 1, 0)
        tajView.layer.transform = transform
        
        tickCount++
    }
}
