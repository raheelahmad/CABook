//
//  ClockViewController.swift
//  CABook
//
//  Created by Raheel Ahmad on 7/5/14.
//  Copyright (c) 2014 Sakun Labs. All rights reserved.
//

import UIKit
import QuartzCore

@objc(ClockViewController) class ClockViewController: UIViewController {
    @IBOutlet var clockView: UIImageView
    @IBOutlet var hourView: UIImageView
    @IBOutlet var minuteView: UIImageView
    @IBOutlet var secondsView: UIImageView
    
    var timer: NSTimer?
    
    func tick() {
        let cal = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let comps = cal.components((.HourCalendarUnit | .MinuteCalendarUnit | .SecondCalendarUnit), fromDate: NSDate())
        let hoursAngle = (CDouble(comps.hour) / 24.0) * M_PI * 2
        let minutesAngle = (CDouble(comps.minute) / 60.0) * M_PI * 2
        let secondsAngle = (CDouble(comps.second) / 60.0) * M_PI * 2
        
        println("\(comps.hour):\(comps.minute):\(comps.second)")
        
        hourView.transform = CGAffineTransformMakeRotation(CGFloat(hoursAngle))
        minuteView.transform = CGAffineTransformMakeRotation(CGFloat(minutesAngle))
        secondsView.transform = CGAffineTransformMakeRotation(CGFloat(secondsAngle))
    }
    
    convenience init() {
        self.init(nibName: "ClockViewController", bundle: nil)
    }

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        for view in [hourView, minuteView, secondsView] {
            view.alpha = 0.8
            view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        }
    }
    
    func setupTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "tick", userInfo: nil, repeats: true)
        tick()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupTimer()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        if timer { timer!.invalidate() }
    }
    
}
