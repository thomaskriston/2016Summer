//
//  ViewController.swift
//  PokumanGo
//
//  Created by Thomas Kriston  on 7/26/16.
//  Copyright © 2016 ForwardSwift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func askPermission(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.manager.requestWhenInUseAuthorization()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

