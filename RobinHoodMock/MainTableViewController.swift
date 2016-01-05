//
//  MainTableViewController.swift
//  RobinHoodMock
//
//  Created by Dylan Fiedler on 12/17/15.
//  Copyright © 2015 xor. All rights reserved.
//

import UIKit
import BEMSimpleLineGraph

class MainTableViewController: UITableViewController, UINavigationControllerDelegate, BEMSimpleLineGraphDelegate,BEMSimpleLineGraphDataSource, UISearchBarDelegate {

    var graphView: UIView?;
    
    @IBOutlet var table: UITableView!
    let turquoise = UIColor(red: 37/255, green: 217/255, blue: 151/255, alpha: 1)
    let red = UIColor(red: 242/255, green: 69/255, blue: 53/255, alpha: 1)
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 250, 20))

    let data = [4, 6, 8, 10, 12, 11, 8, 6, 9, 14, 12, 7, 5, 3, 2, 1, 1, 2, 4, 5, 8, 9, 10, 5, 6, 4, 3,1.0,2.0,3.0,2.0,0.0,1.0,2.0,3.0,2.0,3,5,6,3,4,2,5,7,8,11,15,15,16,17,18,15,13,12,14,14,15,17,18,19, 20, 17, 22, 21, 20, 22, 19, 14, 12, 13, 11, 15, 17, 18]
    let machineNames = ["ALLIANCE 776", "MERA09876", "CT08745","ALLIANCE 776", "MERA09876", "CT08745","ALLIANCE 776", "MERA09876", "CT08745", "MERA09876"]
    var nextTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "profile:")
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "person"), style: .Plain, target: self, action: "profile:")
        
        searchBar.barStyle = UIBarStyle.Default
        searchBar.backgroundColor = UIColor.clearColor()
        searchBar.tintColor = turquoise
        searchBar.delegate = self
        let searchNavBarButton = UIBarButtonItem(customView: searchBar)
        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        searchNavBarButton.tintColor = UIColor.darkGrayColor()
        self.navigationItem.setLeftBarButtonItems([leftBarButton, space, searchNavBarButton, space, rightBarButton], animated: false)
        
        searchBar.placeholder = "Search"
        
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        self.searchBar.endEditing(true)
        self.searchBar.resignFirstResponder()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SystemTableViewCell
        
        var change: Double = 0.0;
        change = Double ((data.count - 1) - (data.count - 2)) / Double(data.count - 2) * 100
        change = round(change)
        
        cell.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.5)
        cell.systemID.text = machineNames[indexPath.row]
        cell.category.text = "MR/CT"
        cell.lineGraph.delegate = self
        cell.lineGraph.dataSource = self
        cell.lineGraph.enableBezierCurve = true
        cell.lineGraph.enableBottomReferenceAxisFrameLine = false
        cell.lineGraph.enableLeftReferenceAxisFrameLine = false
        cell.lineGraph.backgroundColor = UIColor.clearColor()
        cell.lineGraph.colorTop = UIColor.clearColor()
        cell.lineGraph.colorBottom = UIColor.clearColor()
        cell.lineGraph.clipsToBounds = true
        cell.lineGraph.animationGraphEntranceTime = 0.5
        
        cell.statLabel.layer.borderColor = turquoise.CGColor
        cell.statLabel.clipsToBounds = true
        cell.statLabel.layer.borderWidth = 2.0
        cell.statLabel.layer.cornerRadius = 8.0
        cell.backgroundColor = cell.contentView.backgroundColor
        //on selection, keep background color turquoise (layer is unaffected on selection)
        cell.statLabel.backgroundColor = UIColor.clearColor()
        
        
        let random = Int(arc4random_uniform(UInt32(100.0)))
        
        if random > 60 {
            let randomValue = Int(arc4random_uniform(UInt32(10)))
            cell.statLabel.text = "\(Float(100 - randomValue))%"
            cell.statLabel.layer.borderColor = turquoise.CGColor
            cell.statLabel.clipsToBounds = true
            cell.statLabel.layer.borderWidth = 2.0
            cell.statLabel.layer.cornerRadius = 8.0
            cell.statLabel.layer.backgroundColor = turquoise.CGColor
            cell.lineGraph.colorLine = turquoise
        } else {
            let randomValue = Int(arc4random_uniform(UInt32(40)))
            cell.statLabel.text = "\(Float(random + randomValue))%"
            cell.statLabel.layer.borderColor = UIColor(red: 242/255, green: 69/255, blue: 53/255, alpha: 1).CGColor
            cell.statLabel.clipsToBounds = true
            cell.statLabel.layer.borderWidth = 2.0
            cell.statLabel.layer.cornerRadius = 8.0
            cell.statLabel.layer.backgroundColor = UIColor(red: 242/255, green: 69/255, blue: 53/255, alpha: 1).CGColor
            cell.lineGraph.colorLine = red
        }


        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        // present view controller
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! SystemTableViewCell
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let imageViewController = mainStoryboard.instantiateViewControllerWithIdentifier("GraphViewController")
        nextTitle = cell.systemID.text
        graphView = imageViewController.view
        //self.navigationController?.pushViewController(imageViewController, animated: true)
        self.performSegueWithIdentifier("graph", sender: self)
    }
    
    
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        return 10
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        let index = Int(arc4random_uniform(UInt32(data.count)))
        return CGFloat(data[index])
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String {
        return ""
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
    }
    
    func profile (sender: UIBarButtonItem){
        print("button pressed")
        self.performSegueWithIdentifier("profile", sender: self)
    }
    
//    func lineGraphDidBeginLoading(graph: BEMSimpleLineGraphView) {
//        //
//    }
//    
//    func lineGraphDidFinishLoading(graph: BEMSimpleLineGraphView) {
//        //
//    }
//    
//    func lineGraphDidFinishDrawing(graph: BEMSimpleLineGraphView) {
//        //
//    }
//    
//    func lineGraph(graph: BEMSimpleLineGraphView, alwaysDisplayPopUpAtIndex index: CGFloat) -> Bool {
//        //
//    }
//    
//    func lineGraph(graph: BEMSimpleLineGraphView, didReleaseTouchFromGraphWithClosestIndex index: CGFloat) {
//        //
//    }
//
//    func lineGraph(graph: BEMSimpleLineGraphView, didTouchGraphWithClosestIndex index: Int) {
//        //
//    }
//    
//    func lineGraph(graph: BEMSimpleLineGraphView, modifyPopupView popupView: UIView, forIndex index: UInt) {
//        //
//    }
    
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier != "profile"){
        let dvc = segue.destinationViewController as! UINavigationController
        let graphViewController = dvc.viewControllers.first as! GraphViewController
        graphViewController.data = data
        let current: Double = data[data.count - 1]
        graphViewController.title = nextTitle
        }
    }

    
    //Changing Status Bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        //LightContent
        return UIStatusBarStyle.LightContent
        
        //Default
        //return UIStatusBarStyle.Default
        
    }

}
