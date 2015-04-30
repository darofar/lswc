//
//  ViewController.swift
//  MediaNaranja
//
//  Created by Javier De La Rubia on 29/4/15.
//  Copyright (c) 2015 Javier De La Rubia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var birthDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "birthToMeet") {
            let destinationVC = segue.destinationViewController as! MeetViewController;
            destinationVC.birthDate = birthDatePicker.date;
        }
    }

}

