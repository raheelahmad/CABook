//
//  GroupOpacityViewController.swift
//  CABook
//
//  Created by Raheel Ahmad on 7/12/14.
//  Copyright (c) 2014 Sakun Labs. All rights reserved.
//

import UIKit

@objc(GroupOpacityViewController) class GroupOpacityViewController: UIViewController {

    @IBOutlet var topButton: UIButton
    @IBOutlet var bottomButton: UIButton
    
    convenience init() {
        self.init(nibName: "GroupOpacityViewController", bundle: nil)
    }

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    func setupButtons() {
        for btn in [ topButton, bottomButton ] {
            let w = btn.bounds.width
            let h = btn.bounds.height
            let someLabel = UILabel(frame: CGRectMake(0, h/2 - 10, w, 20))
            someLabel.text = "Button Label"
            someLabel.backgroundColor = UIColor.whiteColor()
            someLabel.textAlignment = .Center
            btn.addSubview(someLabel)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        topButton.layer.opacity = 0.5
        
        bottomButton.layer.shouldRasterize = true
        bottomButton.layer.rasterizationScale = UIScreen.mainScreen().scale
        bottomButton.layer.opacity = 0.5
    }

}
