//
//  ActorsTableViewController.swift
//  Actor
//
//  Created by Javier De La Rubia on 26/5/15.
//  Copyright (c) 2015 Javier De La Rubia. All rights reserved.
//

import UIKit

private let SEARCH_HISTORY_FILE = "busquedas.plist"

class ActorsTableViewController: UITableViewController {
    
    var search_history: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        //retrieve local history of search terms
        loadSearchHistory()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return search_history.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Search Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let actor = search_history[indexPath.row]
        cell.textLabel?.text = actor;
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Selecciona un actor"
    }
    
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "LSWC 2014/2015"
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            
            if editingStyle == .Delete {
                // Delete the row from the data source
                search_history.removeAtIndex(indexPath.row)
                saveSearchHistory()
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
            } else if editingStyle == .Insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
    }
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        let aux = search_history[fromIndexPath.row]
        
        search_history.removeAtIndex(fromIndexPath.row)
        search_history.insert(aux, atIndex: toIndexPath.row)
        
        saveSearchHistory()
    }
   
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    
    @IBAction func actorWasEdited(segue: UIStoryboardSegue) {
        
        if let source = segue.sourceViewController
            as? AddActorTableViewController {
                if let ip = tableView.indexPathForSelectedRow() {
                    search_history[ip.row] = source.name!
                    tableView.reloadRowsAtIndexPaths([ip], withRowAnimation: .Automatic)
                    saveSearchHistory()
                }
                tableView.reloadData();
                saveSearchHistory()
        }
    }
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Search for Actor" {
            if let aptvc = segue.destinationViewController as? ActorPreviewTableViewController {
                if let row = tableView.indexPathForCell(sender as! UITableViewCell)?.row {
                    aptvc.actorSearchTerm  = search_history[row]
                }
            }
            
        } else if segue.identifier == "Add Search Item" {
            
            search_history.insert("", atIndex: 0)
            let ip = NSIndexPath(forRow: 0, inSection: 0)
            tableView.insertRowsAtIndexPaths([ip], withRowAnimation: UITableViewRowAnimation.Right)
            tableView.selectRowAtIndexPath(ip, animated: true, scrollPosition: .Top)
            /*
            tableView.scrollToRowAtIndexPath(ip, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            */
            
            if let aatvc = segue.destinationViewController as? AddActorTableViewController {
                aatvc.name = ""
            }
            
        } else if segue.identifier == "Edit Search Item" {
            
            if let aatvc = segue.destinationViewController as? AddActorTableViewController {
                if let ip = tableView.indexPathForCell(sender as! UITableViewCell) {
                    tableView.selectRowAtIndexPath(ip, animated: true, scrollPosition: .Top)
                    aatvc.name = search_history[ip.row]
                }
            }
        }
        
    }
    
    
    // MARK: Persistencia
    
    private func getSavedSearchsPath() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)[0] as! String
        return path.stringByAppendingPathComponent(SEARCH_HISTORY_FILE)
    }
    
    private func loadSearchHistory() {
        let path = getSavedSearchsPath()
        if let search_items = NSArray(contentsOfFile: path) as? [String] {
            self.search_history = search_items
        } else {
            self.search_history = ["Harrison", "Pitt", "Jolie", "Peter", "Portman", "Leonardo"]
        }
    }
    
    private func saveSearchHistory() {
        let path = getSavedSearchsPath()
        (search_history as NSArray).writeToFile(path, atomically: true)
    }
    
}