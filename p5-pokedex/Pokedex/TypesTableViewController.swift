//
//  TypesTableViewController.swift
//  Pokedex
//
//  Created by Javier De La Rubia on 15/5/15.
//  Copyright (c) 2015 UPM. All rights reserved.
//

import UIKit

class TypesTableViewController: UITableViewController {
    
    lazy var pokedexModel = PokedexModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedexModel.types.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Type Cell", forIndexPath: indexPath) as! UITableViewCell
        let type = pokedexModel.types[indexPath.row]
        cell.textLabel!.text = type.name
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tipos"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show Type" {
            let tvc = segue.destinationViewController  as! RacesTableViewController
            if let ip = tableView.indexPathForCell(sender! as! UITableViewCell) {
                let type = pokedexModel.types[ip.row]
                tvc.type = type
                tvc.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}
