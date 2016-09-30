//
//  DismissableViewController.swift
//  custom-viewcontroller-transitions
//
//  Created by Joshua Alvarado on 9/22/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import UIKit

class DismissableViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "View Controller"
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
