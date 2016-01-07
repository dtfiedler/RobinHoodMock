//
//  ProfileTableViewController.swift
//  RobinHoodMock
//
//  Created by Dylan Fiedler on 12/28/15.
//  Copyright © 2015 xor. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Account"
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(18.0, weight: UIFontWeightUltraLight), NSForegroundColorAttributeName: UIColor.blackColor()]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch(section){
        case 0:
            return 4
        case 1:
            return 3
        case 2:
            return 1
        case 3:
            return 2
        case 4:
            return 1
        default:
            return 1
        }
    }

    @IBAction func exit(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        switch (indexPath.section){
        case 0:
            switch(indexPath.row){
            case 0:
                cell.textLabel!.text = "John Smith"
                break;
            case 1:
                cell.textLabel!.text = "1232467890"
                break
            case 2:
                cell.textLabel!.text = "Waukesha Hospital"
                break
            case 3:
                cell.textLabel!.text = "CT/MR/USL"
                break
            default:
                break
            }
            break
        case 1:
            if (indexPath.row == 0) {
                cell.textLabel!.text = "Update Email"
            } else if (indexPath.row == 1){
                cell.textLabel!.text = "Reset Password"
            } else {
                cell.textLabel!.text = "Log Out"
            }
            break;
        case 2:
            if (indexPath.row == 0) {
                cell.textLabel!.text = "Configure Notifications"
            } else {
                 cell.textLabel!.text = "Section 3"
            }
            break;
        case 3:
            if (indexPath.row == 0) {
                cell.textLabel!.text = "Help Center"
            } else {
                cell.textLabel!.text = "Contact Support"
            }
            break;
        case 4:
            cell.textLabel!.text = "Touch ID and Pin"
        default:
            break
        }
        
        cell.textLabel!.font = UIFont.systemFontOfSize(12, weight: UIFontWeightLight)

        
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CustomHeaderCell
        
        switch (section) {
        case 0:
            headerCell.headerLabel.text = "PROFILE";
            //return sectionHeaderView
        case 1:
            headerCell.headerLabel.text = "ACCOUNT SETTINGS";
            //return sectionHeaderView
        case 2:
            headerCell.headerLabel.text = "NOTIFICATION SETTINGS";
            //return sectionHeaderView
        case 3:
            headerCell.headerLabel.text = "SUPPORT";
            //return sectionHeaderView
        default:
            headerCell.headerLabel.text = "SECURITY SETTINGS";
        }
        
        return headerCell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
