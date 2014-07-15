//
//  InfoViewController.swift
//  CABook
//
//  Created by Raheel Ahmad on 7/14/14.
//  Copyright (c) 2014 Sakun Labs. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    var info: String?
    
    @IBOutlet var textView: UITextView
    convenience init(info: String) {
        self.init()
        self.info = info
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.text = info
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension InfoViewController {
    @IBAction func done(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
