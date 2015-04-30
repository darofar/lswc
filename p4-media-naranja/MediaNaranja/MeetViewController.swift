//
//  MeetViewController.swift
//  MediaNaranja
//
//  Created by Javier De La Rubia on 29/4/15.
//  Copyright (c) 2015 Javier De La Rubia. All rights reserved.
//

import UIKit

class MeetViewController: UIViewController {
    
    var birthDate : NSDate = NSDate();
    
    @IBOutlet var meetDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meetDate.minimumDate = birthDate;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "meetToDeath") {
            println(birthDate.timeIntervalSince1970 + 2*(meetDate.date.timeIntervalSince1970-birthDate.timeIntervalSince1970));
            let destinationVC = segue.destinationViewController as! DeathViewController;
            destinationVC.deathDate = NSDate(timeIntervalSince1970: birthDate.timeIntervalSince1970 + 2*(meetDate.date.timeIntervalSince1970-birthDate.timeIntervalSince1970));
        }
    }
    
}