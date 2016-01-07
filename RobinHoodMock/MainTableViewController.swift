//
//  MainTableViewController.swift
//  RobinHoodMock
//
//  Created by Dylan Fiedler on 12/17/15.
//  Copyright © 2015 xor. All rights reserved.
//

import UIKit
import BEMSimpleLineGraph
import HMSegmentedControl
import ZGNavigationBarTitle

class MainTableViewController: UITableViewController, UINavigationControllerDelegate, BEMSimpleLineGraphDelegate,BEMSimpleLineGraphDataSource, UISearchBarDelegate {

    var graphView: UIView?;

    
    @IBOutlet weak var segmentControl: HMSegmentedControl!
    
    @IBOutlet var table: UITableView!
    let turquoise = UIColor(red: 37/255, green: 217/255, blue: 151/255, alpha: 1)
    let red = UIColor(red: 242/255, green: 69/255, blue: 53/255, alpha: 1)
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 250, 20))

    var data: [Double] = []

    
    let machineNames = ["ALLIANCE 776", "MERA09876", "CT08745","ALLIANCE 776", "MERA09876", "CT08745","ALLIANCE 776", "MERA09876", "CT08745", "MERA09876"]
    var nextTitle: String?
    var selectIndexPath: NSIndexPath?
    var titleView: UIView?
    var graphData: [[Double]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(12.0, weight: UIFontWeightUltraLight), NSForegroundColorAttributeName: UIColor.blackColor()]
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator = false
        
        for var i = 0; i <= 50; i++ {
            data.append(Double(arc4random_uniform(UInt32(50.0) * 2)))
        }
        
        let titleLabel = UILabel(frame: CGRectMake(0, -5, 0, 0)) //x, y, width, height where y is to offset from the view center
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        titleLabel.text = "Aurora Health"
        titleLabel.sizeToFit()
        
        //Create a label for the Subtitle
        // x, y, width, height where x is set to be half the size of the title (100/4 = 25%) as it starts all the way left.
        let subtitleLabel = UILabel(frame: CGRectMake(titleLabel.frame.size.width / 4, 18, 0, 0))
        subtitleLabel.backgroundColor = UIColor.clearColor()
        subtitleLabel.textColor = UIColor.lightGrayColor()
        subtitleLabel.font = UIFont.systemFontOfSize(12, weight: UIFontWeightLight)
        subtitleLabel.text = "West Allis, WI"
        subtitleLabel.sizeToFit()
        
        /*Create a view and add titleLabel and subtitleLabel as subviews setting
        * its width to the bigger of both
        * this will crash the program if subtitle is bigger then title
        */
        let titleView = UIView(frame: CGRectMake(0, 0, max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), 30))
        
        // Center title or subtitle on screen (depending on which is larger)
        if titleLabel.frame.width >= subtitleLabel.frame.width {
            var adjustment = subtitleLabel.frame
            adjustment.origin.x = titleView.frame.origin.x + (titleView.frame.width/2) - (subtitleLabel.frame.width/2)
            subtitleLabel.frame = adjustment
        } else {
            var adjustment = titleLabel.frame
            adjustment.origin.x = titleView.frame.origin.x + (titleView.frame.width/2) - (titleLabel.frame.width/2)
            titleLabel.frame = adjustment
        }
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        self.navigationItem.titleView = titleView

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        self.searchBar.endEditing(true)
        self.searchBar.resignFirstResponder()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == 0){
            return 1
        } else {
        return 10
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell", forIndexPath: indexPath) as! MainHeaderViewCell
            cell.firstSlider.showCount = false
            cell.firstSlider.backgroundColor = UIColor.whiteColor()
            cell.firstSlider.barBackgroundColor = UIColor.whiteColor()
            cell.firstSlider.yAxisLabels = ["CT", "MR", "USL"]
            cell.firstSlider.maxXValue = 100
            cell.firstSlider.labelTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(14.0, weight: UIFontWeightUltraLight), NSForegroundColorAttributeName: UIColor.blackColor()]
            cell.firstSlider.xValues = [90, 70, 100]
            cell.firstSlider.countTextAttributes = cell.firstSlider.labelTextAttributes
            cell.firstSlider.barFillColor = turquoise
        
            cell.segmentControl.sectionTitles = ["1D", "1M", "3M", "6M", "1YR"]
            cell.segmentControl.tintColor = UIColor.blueColor()
            cell.segmentControl.selectionIndicatorHeight = 1.0
            cell.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
            cell.segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe
            cell.segmentControl.selectionIndicatorColor = turquoise
            cell.segmentControl.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
            cell.segmentControl.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(14, weight: UIFontWeightUltraLight)]
            cell.segmentControl.enabled = true
            cell.segmentControl.becomeFirstResponder()
            
            
        }
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
        cell.lineGraph.animationGraphStyle = .None
        cell.lineGraph.averageLine.enableAverageLine = true
        cell.lineGraph.averageLine.dashPattern = NSArray(array: [3]) as [AnyObject]
        cell.lineGraph.averageLine.color = UIColor.lightGrayColor()
        cell.lineGraph.averageLine.width = 0.5
        cell.lineGraph.averageLine.alpha = 0.5
        cell.lineGraph.sizeToFit()
        
        cell.statLabel.layer.borderColor = turquoise.CGColor
        cell.statLabel.clipsToBounds = true
        cell.statLabel.layer.borderWidth = 2.0
        cell.statLabel.layer.cornerRadius = 8.0
        cell.backgroundColor = cell.contentView.backgroundColor
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
            cell.lineGraph.reloadGraph()
        } else {
            let randomValue = Int(arc4random_uniform(UInt32(40)))
            cell.statLabel.text = "\(Float(random + randomValue))%"
            cell.statLabel.layer.borderColor = UIColor(red: 242/255, green: 69/255, blue: 53/255, alpha: 1).CGColor
            cell.statLabel.clipsToBounds = true
            cell.statLabel.layer.borderWidth = 2.0
            cell.statLabel.layer.cornerRadius = 8.0
            cell.statLabel.layer.backgroundColor = UIColor(red: 242/255, green: 69/255, blue: 53/255, alpha: 1).CGColor
            cell.lineGraph.colorLine = red
            cell.lineGraph.reloadGraph()
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section != 0){
        selectIndexPath = indexPath
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! SystemTableViewCell
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let imageViewController = mainStoryboard.instantiateViewControllerWithIdentifier("GraphViewController")
        nextTitle = cell.systemID.text
        graphView = imageViewController.view
        self.performSegueWithIdentifier("graph", sender: self)
        }
    }
    
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        return 20
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        if (index == 0){
            graphData.append([])
        }
        
        let index = Int(arc4random_uniform(UInt32(data.count)))
        graphData[graphData.count - 1].append(data[index])

        return CGFloat(data[index])
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String {
        return ""
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
    }
    
    @IBAction func profile (sender: UIBarButtonItem){
        print("button pressed")
        self.performSegueWithIdentifier("profile", sender: self)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0){
            return self.view.frame.height * 0.5
        }
       return 90
    }
    
    @IBAction func segmentedControlValueChanged(sender: AnyObject) {
        //calculate percent change
        
        print("selection made")
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
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }*/

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "graph"){
            let dvc = segue.destinationViewController as! UINavigationController
            let graphViewController = dvc.viewControllers.first as! TestViewController
            let current: Double = data[data.count - 1]
            graphViewController.current = current.description
            graphViewController.machineNames = machineNames
            graphViewController.graphData = graphData
        }
    }

    
    //Changing Status Bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        //LightContent
        return UIStatusBarStyle.Default
        
        //Default
        //return UIStatusBarStyle.Default
        
    }
    
    func addTitleAndSubtitleToNavigationBar (title: String, subtitle: String) {
        var label = UILabel(frame: CGRectMake(10.0, 0.0, 50.0, 40.0))
        label.font = UIFont.boldSystemFontOfSize(14.0)
        label.numberOfLines = 2
        label.text = "Aurora Health\nWest Allis, Wi"
        label.textColor = UIColor.blackColor()
        label.sizeToFit()
        label.textAlignment = NSTextAlignment.Center
        self.titleView = label
    }


}

