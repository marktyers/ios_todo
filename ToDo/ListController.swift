//
//  ListController.swift
//  ToDo
//
//  Created by Mark Tyers on 11/07/2014.
//  Copyright (c) 2014 Coventry University. All rights reserved.
//

import UIKit

class ListController: UITableViewController {
    
    var items:[String] = ["Bread", "Butter"]
    var savedItems:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var newItem: UITextField
    
    @IBAction func showDialog(sender: UIBarButtonItem) {
        NSLog("showDialog")
        var alert:UIAlertController
        alert = UIAlertController(title: "New Item", message: "Type item below", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.Default, handler: itemAdded))
        alert.addTextFieldWithConfigurationHandler(addTextField)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func addTextField(textField: UITextField!){
        NSLog("addTextField")
        self.newItem = textField
    }
    
    func itemAdded(alert: UIAlertAction!){
        NSLog("item name: %@", self.newItem.text)
        let item:String = self.newItem.text
        let itemLength:Int = countElements(item)
        if itemLength > 0 {
            
            self.items.append(self.newItem.text)
            self.savedItems.setObject(items, forKey: "savedList")
            self.savedItems.synchronize()
        }
        NSLog("%@", self.items)
        self.tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("viewDidLoad")
        self.items = self.savedItems.arrayForKey("savedList") as [String]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        let table:UITableView = self.tableView
        let cell:UITableViewCell = table.cellForRowAtIndexPath(indexPath)
        
        if cell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            cell.accessoryType = UITableViewCellAccessoryType.None
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShoppingItem", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = self.items[indexPath.row]
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        if editingStyle == .Delete {
            self.items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

}
