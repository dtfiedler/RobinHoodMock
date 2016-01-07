//
//  SearchTableViewController.swift
//  Pods
//
//  Created by Dylan Fiedler on 1/6/16.
//
//

import UIKit

class SearchTableViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 250, 20))
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: "dismiss:")
        
        searchBar.barStyle = UIBarStyle.Default
        searchBar.backgroundColor = UIColor.whiteColor()
        searchBar.tintColor = UIColor.darkGrayColor()
        searchBar.delegate = self
        searchBar.hidden = false
        searchBar.becomeFirstResponder()
        
        let searchNavBarButton = UIBarButtonItem(customView: searchBar)
        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        searchNavBarButton.tintColor = UIColor.clearColor()
        searchBar.barStyle = UIBarStyle.Default
        self.navigationItem.setLeftBarButtonItems([leftBarButton, space, searchNavBarButton, space], animated: false)
        
        searchBar.placeholder = ""
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.tableView.layoutMargins = UIEdgeInsetsZero
        
        tableView.backgroundColor = UIColor.clearColor()
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        tableView.backgroundView = blurEffectView
        
        //if inside a popover
        if let popover = navigationController?.popoverPresentationController {
            popover.backgroundColor = UIColor.clearColor()
        }
        
        //if you want translucent vibrant table view separator lines
        tableView.separatorEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
    
    }
    
    
    @IBAction func dismiss(sender: AnyObject) {
        self.searchBar.endEditing(true)
        self.searchBar.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.searchBar.endEditing(true)
        self.searchBar.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    
     func scrollViewDidScroll(scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
        self.searchBar.endEditing(true)
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
