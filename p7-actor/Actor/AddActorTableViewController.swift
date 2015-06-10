//
//  AddActorTableViewController.swift
//  Actor
//
//  Created by Javier De La Rubia on 26/5/15.
//  Copyright (c) 2015 Javier De La Rubia. All rights reserved.
//

import UIKit

class AddActorTableViewController: UITableViewController {
    
    var name : String!
    
    @IBOutlet var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = name
        nameTextField.becomeFirstResponder()
    }
    
    
    // MARK: - Navigation
    
    @IBAction func savePressed(sender: UITextField) {
        performSegueWithIdentifier("Save Search Item", sender: nameTextField)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Save Search Item" {
            self.name = nameTextField.text
        }
        /**
        * if segue.identifier == "Cancel Edition" {
        *   //no hacer nada
        * }
        */
    }
}
