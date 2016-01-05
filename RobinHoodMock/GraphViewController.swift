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
    
    var data: [Double] = []
    let month = ["Jan", "", "Feb", "", "March", "", "April", "", "May", "", "June", "", "July","", "Aug","", "Sept","", "Oct", "","Nov","", "Dec", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        //percentChange = 50.0 as! Double
        self.graphView.delegate = self
        self.graphView.dataSource = self
        self.segmentControl.sectionTitles = ["1W", "1M", "3M", "6M", "1YR"]
        self.segmentControl.tintColor = UIColor.blueColor()
        self.segmentControl.selectionIndicatorHeight = 1.0
        self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
        self.segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe
        self.segmentControl.selectionIndicatorColor = UIColor.blueColor()
        self.segmentControl.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
        self.segmentControl.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(14)]
        
        //self.segmentControler.tintColor = UIColor.clearColor()
        self.graphView.enableBezierCurve = true
        self.graphView.enableBottomReferenceAxisFrameLine = false
        self.graphView.enableLeftReferenceAxisFrameLine = false
        self.graphView.enableYAxisLabel = false
        self.graphView.backgroundColor = UIColor.clearColor()
        self.graphView.colorTop = UIColor.clearColor()
        self.graphView.colorBottom = UIColor.clearColor()
        self.graphView.clipsToBounds = true
        self.graphView.animationGraphStyle = .None
        self.graphView.enablePopUpReport = true
        self.graphView.colorPoint = UIColor.blueColor()
        self.graphView.colorReferenceLines = UIColor.blueColor()
        self.graphView.colorXaxisLabel = UIColor.lightGrayColor()
        self.graphView.colorYaxisLabel = UIColor.lightGrayColor()
        self.graphView.colorLine = UIColor.blueColor()
        self.graphView.enableTouchReport = true
        pastTime.text = "PAST YEAR"
        self.currentLabel.alpha = 0
        //var change = percentChange()
       // self.change.text = "\(change)%"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.currentLabel.text = data[data.count - 1].description
        self.currentLabel.alpha = 1
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
            self.pastTime.text = "PAST WEEK"
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
        var change = percentChange()
        self.change.text = "\(change)%"
        self.currentLabel.text = "\(data[data.count - 1])"
    }
    
    func percentChange() -> Double! {
        var current = data[data.count - 1]
        var relative = data[data.count - 1]
        switch(self.segmentControl.selectedSegmentIndex){
        case 0:
            relative = data[data.count - 3]
            break
        case 1:
            relative = data[data.count - 5]
            break
        case 2:
            relative = data[data.count - 8]
            break
        case 3:
            relative = data[data.count - 15]
            break
        case 4:
            relative = data[data.count - 20]
            break
        default:
            break
        }
        var change = (current - relative)
        change = (Double)(change / relative)
        change = change * 100.0
        return change
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, didTouchGraphWithClosestIndex index: Int) {
        self.currentLabel.text = "\(data[data.count - 1 - index])"
        var relative = 0.0
        switch(self.segmentControl.selectedSegmentIndex){
        case 0:
            relative = data[data.count - 3]
            break
        case 1:
            relative = data[data.count - 5]
            break
        case 2:
            relative = data[data.count - 8]
            break
        case 3:
            relative = data[data.count - 15]
            break
        case 4:
            relative = data[data.count - 20]
            break
        default:
            break
        }
        var current = data[data.count - 1 - index]
        var change = (relative - current)/relative
        change = change * -100.0
        change = (round(change*100)) / 100.0;
        self.change.text = "\(change) %"
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, didReleaseTouchFromGraphWithClosestIndex index: CGFloat) {
        self.currentLabel.text = "\(data[data.count - 1])"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
