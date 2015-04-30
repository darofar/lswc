//
//  DeathViewController.swift
//  MediaNaranja
//
//  Created by Javier De La Rubia on 29/4/15.
//  Copyright (c) 2015 Javier De La Rubia. All rights reserved.
//

import UIKit

class DeathViewController: UIViewController {
    
    var deathDate : NSDate = NSDate();
    
    
    @IBOutlet var deathLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var dateFormatter = NSDateFormatter();
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle;
        deathLabel.text = dateFormatter.stringFromDate(deathDate);
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if NSDate().timeIntervalSince1970 > deathDate.timeIntervalSince1970 {
            var alert = UIAlertController(title: "Ups..", message: "Deberías ir al médico", preferredStyle: UIAlertControllerStyle.Alert);
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
    