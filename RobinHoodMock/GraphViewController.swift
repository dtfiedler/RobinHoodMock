//
//  GraphViewController.swift
//  
//
//  Created by Dylan Fiedler on 12/28/15.
//
//

import UIKit
import BEMSimpleLineGraph
import HMSegmentedControl

class GraphViewController: UIViewController, BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource, YSSegmentedControlDelegate {

    @IBOutlet var content: UIView!
    
    @IBOutlet var graphView: BEMSimpleLineGraphView!
    
    @IBOutlet var current: UIView!
    @IBOutlet weak var change: UILabel!
    @IBOutlet weak var pastTime: UILabel!
    @IBOutlet weak var segmentControl: HMSegmentedControl!
    @IBOutlet weak var currentLabel: UILabel!
    
    let turquoise = UIColor(red: 37/255, green: 217/255, blue: 151/255, alpha: 1)
    let red = UIColor(red: 242/255, green: 69/255, blue: 53/255, alpha: 1)
    var data: [Double] = []
    let month = ["Jan", "", "Feb", "", "March", "", "April", "", "May", "", "June", "", "July","", "Aug","", "Sept","", "Oct", "","Nov","", "Dec", ""]
    
    var currentValue: Double!
    var relativeChange: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)

        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(18.0, weight: UIFontWeightUltraLight), NSForegroundColorAttributeName: UIColor.blackColor()]

        //percentChange = 50.0 as! Double
        self.graphView.delegate = self
        self.graphView.dataSource = self
        self.segmentControl.sectionTitles = ["1D", "1M", "3M", "6M", "1YR"]
        self.segmentControl.tintColor = UIColor.blueColor()
        self.segmentControl.selectionIndicatorHeight = 1.0
        self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
        self.segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe
        self.segmentControl.selectionIndicatorColor = turquoise
        self.segmentControl.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
        self.segmentControl.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(14, weight: UIFontWeightUltraLight)]
        
        //self.segmentControler.tintColor = UIColor.clearColor()
        self.graphView.enableBezierCurve = true
        self.graphView.enableBottomReferenceAxisFrameLine = false
        self.graphView.enableLeftReferenceAxisFrameLine = false
        self.graphView.enableYAxisLabel = false
        self.graphView.enableReferenceYAxisLines = true
        self.graphView.averageLine.enableAverageLine = true
        self.graphView.averageLine.dashPattern = NSArray(array: [3]) as [AnyObject]
            
        self.graphView.averageLine.color = UIColor.lightGrayColor()
        self.graphView.averageLine.width = 0.5
        self.graphView.averageLine.alpha = 0.5
        self.graphView.backgroundColor = UIColor.clearColor()
        self.graphView.colorTop = UIColor.clearColor()
        self.graphView.colorBottom = UIColor.clearColor()
        self.graphView.clipsToBounds = true
        self.graphView.animationGraphStyle = .None
        self.graphView.enablePopUpReport = true
        self.graphView.colorPoint = turquoise
        self.graphView.colorReferenceLines = UIColor.blueColor()
        self.graphView.colorXaxisLabel = UIColor.lightGrayColor()
        self.graphView.colorYaxisLabel = UIColor.lightGrayColor()
        self.graphView.colorLine = turquoise
        self.graphView.enableTouchReport = true
        pastTime.text = "TODAY"
        self.segmentControl.selectedSegmentIndex = 0
        self.currentLabel.alpha = 0
        self.change.text = "\(change) (\(relativeChange)%)"
        //var change = percentChange()
       // self.change.text = "\(change)%"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.currentLabel.text = data[data.count - 1].description
        self.currentLabel.alpha = 1
        
        currentValue = data[data.count - 1]
        percentChange()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        switch (self.segmentControl.selectedSegmentIndex){
        case 0: return 3
        case 1: return 5
        case 2: return 8
        case 3: return 15
        case 4: return 20
        default: return 10
        }
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        if (data.isEmpty){
            return 0
        } else {
            var relative = 0
            switch(self.segmentControl.selectedSegmentIndex){
            case 0:
                relative = data.count - 3
                break
            case 1:
                relative = data.count - 5
                break
            case 2:
                relative = data.count - 8
                break
            case 3:
                relative = data.count - 15
                break
            case 4:
                relative = data.count - 20
                break
            default:
                break
            }

            let lastindex = data.count - 1
            let value = data[relative + index]
            return CGFloat(value)
        }
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String {
        if (self.segmentControl.selectedSegmentIndex == 0){
            return ""
        }
        if index > 12 {
            return month[index - 12]
        } else {
            return month[index]
        }
    }
    
    func numberOfGapsBetweenLabelsOnLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        switch(self.segmentControl.selectedSegmentIndex){
        case 0: return 5
        default: return 1
        }
    }
    
    @IBAction func segmentControlDidChange(sender: AnyObject) {
        self.graphView.reloadGraph()
        
        //calculate percent change
        switch (self.segmentControl.selectedSegmentIndex){
        case 0:
            self.pastTime.text = "TODAY"
            break
        case 1:
            self.pastTime.text = "PAST  MONTH"
            break
        case 2:
            self.pastTime.text = "PAST 3M"
            break
        case 3:
            self.pastTime.text = "PAST 6M"
            break
        case 4:
            self.pastTime.text = "PAST YEAR"
            break
        default:
            self.pastTime.text = ""
            break
        }
        
        percentChange()
        
    
    }
    
    func percentChange() {
        var relative = 0.0
        var helper = 0
        switch(self.segmentControl.selectedSegmentIndex){
        case 0:
            relative = data[data.count - 3]
            helper = data.count - 3
            break
        case 1:
            relative = data[data.count - 5]
            helper = data.count - 5
            break
        case 2:
            relative = data[data.count - 8]
            helper = data.count - 8
            break
        case 3:
            relative = data[data.count - 15]
            helper = data.count - 15
            break
        case 4:
            relative = data[data.count - 20]
            helper = data.count - 20
            break
        default:
            break
        }

        let current = data[data.count - 1]
        var change = (current - relative)
        let relativeChange = (change / relative) * 100.0
        let myString = String.localizedStringWithFormat("%.2f", relativeChange)
        if (change > 0){
            self.change.text = "+\(change) (\(myString)%)"
            self.change.textColor = turquoise
        } else {
            self.change.text = "\(change) (\(myString)%)"
            self.change.textColor = red
        }
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, didTouchGraphWithClosestIndex index: Int) {
        var relative = 0.0
        var helper = 0
        switch(self.segmentControl.selectedSegmentIndex){
        case 0:
            relative = data[data.count - 3]
            helper = data.count - 3
            break
        case 1:
            relative = data[data.count - 5]
            helper = data.count - 5
            break
        case 2:
            relative = data[data.count - 8]
            helper = data.count - 8
            break
        case 3:
            relative = data[data.count - 15]
            helper = data.count - 15
            break
        case 4:
            relative = data[data.count - 20]
            helper = data.count - 20
            break
        default:
            break
        }
        self.currentLabel.text = "\(data[helper + index])"

        let current = data[helper + index]
        var change = (current - relative)
        let relativeChange = (change / relative) * 100.0
        let myString = String.localizedStringWithFormat("%.2f", relativeChange)
        if (change > 0){
            self.change.text = "+\(change) (\(myString)%)"
            self.change.textColor = turquoise
        } else {
            self.change.text = "\(change) (\(myString)%)"
            self.change.textColor = red
        }
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, didReleaseTouchFromGraphWithClosestIndex index: CGFloat) {
        self.currentLabel.text = "\(data[data.count - 1])"
    }
    
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //Changing Status Bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        //LightContent
        return UIStatusBarStyle.Default
        
        //Default
        //return UIStatusBarStyle.Default
        
    }

}
