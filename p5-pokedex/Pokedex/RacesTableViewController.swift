//
//  RacesTableViewController.swift
//  Pokedex
//
//  Created by Santiago Pavón on 1/12/14.
//  Copyright (c) 2014 UPM. All rights reserved.
//

import UIKit

class RacesTableViewController: UITableViewController {
    
    lazy var pokedexModel = PokedexModel()
    var type: Type?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = type!.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return type!.races.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Race Cell", forIndexPath: indexPath) as! UITableViewCell
        let race = type!.races[indexPath.row]
        cell.imageView!.image = UIImage(named: race.icon)
        cell.textLabel!.text = race.name
        cell.detailTextLabel?.text = race.code
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return type!.name
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show Race" {
            let wvc = (segue.destinationViewController as! UINavigationController).topViewController as! WebViewController
            if let ip = tableView.indexPathForCell(sender! as! UITableViewCell) {
                wvc.race = type!.races[ip.row]
                wvc.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                wvc.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}