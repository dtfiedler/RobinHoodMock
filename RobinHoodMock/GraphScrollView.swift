//
//  GraphScrollView.swift
//  RobinHoodMock
//
//  Created by Dylan Fiedler on 1/7/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit
import BEMSimpleLineGraph
import HMSegmentedControl

class GraphScrollView: UIView, BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource {
    
    var turquoise = UIColor(red: 37/255, green: 217/255, blue: 151/255, alpha: 1)
    var topLabel = UILabel(frame: CGRect(x: 208, y: 80, width: 185, height: 88))
    var changeLabel = UILabel(frame: CGRect(x: 208, y: 159, width: 88, height: 21))
    var timeLabel = UILabel (frame: CGRect(x: 304, y: 159, width: 88, height: 21))
    var graph = BEMSimpleLineGraphView(frame: CGRect(x: 20, y: 125, width: 320, height: 371))
    var segmentControl = HMSegmentedControl(frame: CGRect(x: 20, y: 500, width: 350, height: 24))
    let red = UIColor(red: 242/255, green: 69/255, blue: 53/255, alpha: 1)
    
    var data: [Double] = []


    init() {
        super.init(frame: CGRectZero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("init decoder")
        super.init(coder: aDecoder)
        setup()
    }
    
    init?(data: [Double]){
        super.init(frame: CGRectZero)
        self.data = data
        setup()
    }
    
    
    func setup(){
        self.frame = UIScreen.mainScreen().bounds
        self.clipsToBounds = true
        
        //labels
        topLabel.font = UIFont.systemFontOfSize(50, weight: UIFontWeightThin)
        topLabel.text = "Top Label"
        topLabel.clipsToBounds = true
        
        changeLabel.font = UIFont.systemFontOfSize(12, weight: UIFontWeightLight)
        changeLabel.text = "Change Label"
        changeLabel.clipsToBounds = true
        
        timeLabel.font = UIFont.systemFontOfSize(12, weight: UIFontWeightLight)
        timeLabel.alpha = 0.5
        timeLabel.text = ""
        timeLabel.clipsToBounds = true
        
        //graph
        graph.delegate = self
        graph.dataSource = self
        graph.enableBezierCurve = true
        graph.enableBottomReferenceAxisFrameLine = false
        graph.enableLeftReferenceAxisFrameLine = false
        graph.enableYAxisLabel = false
        graph.enableReferenceYAxisLines = true
        graph.averageLine.enableAverageLine = true
        graph.averageLine.dashPattern = NSArray(array: [3]) as [AnyObject]
        graph.averageLine.color = UIColor.lightGrayColor()
        graph.averageLine.width = 0.5
        graph.averageLine.alpha = 0.5
        graph.backgroundColor = UIColor.clearColor()
        graph.colorTop = UIColor.clearColor()
        graph.colorBottom = UIColor.clearColor()
        graph.clipsToBounds = true
        graph.animationGraphStyle = .None
        graph.enablePopUpReport = true
        graph.colorPoint = turquoise
        graph.colorReferenceLines = UIColor.blueColor()
        graph.colorXaxisLabel = UIColor.lightGrayColor()
        graph.colorYaxisLabel = UIColor.lightGrayColor()
        graph.colorLine = turquoise
        graph.enableTouchReport = true
        graph.sizeToFit()
        
        
        //segment control
        segmentControl.sectionTitles = ["1D", "1M", "3M", "6M", "1YR"]
        segmentControl.tintColor = UIColor.blueColor()
        segmentControl.selectionIndicatorHeight = 1.0
        segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
        segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe
        segmentControl.selectionIndicatorColor = turquoise
        segmentControl.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(14, weight: UIFontWeightUltraLight)]
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: "selectedIndexDidChange:", forControlEvents: UIControlEvents.ValueChanged)
        
        addSubview(topLabel)
        addSubview(changeLabel)
        addSubview(timeLabel)
        addSubview(graph)
        addSubview(segmentControl)
        
        self.autoresizesSubviews = true
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: topLabel, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 20)
        let centerConstraint = NSLayoutConstraint(item: topLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let changeVertical = NSLayoutConstraint(item: changeLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: -5)
        let changeHorizontal = NSLayoutConstraint(item: changeLabel, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: topLabel, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1, constant: 20)
        let timeVertical = NSLayoutConstraint(item: timeLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 5)
        let timeHorizontal = NSLayoutConstraint(item: timeLabel, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: topLabel, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1, constant: 20)
        let graphCenter = NSLayoutConstraint(item: graph, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let graphVertical = NSLayoutConstraint(item: graph, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: changeLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 20)
        let segmentCenter = NSLayoutConstraint(item: segmentControl, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let segmentVertical = NSLayoutConstraint(item: segmentControl, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: graph, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 20)
        let graphVertical1 = NSLayoutConstraint(item: graph, attribute: NSLayoutAttribute.LeadingMargin, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 10)
        let graphVertical2 = NSLayoutConstraint(item: graph, attribute: NSLayoutAttribute.TrailingMargin, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 10)
        
        
        self.addConstraint(topConstraint)
        self.addConstraint(centerConstraint)
        self.addConstraint(segmentCenter)
        self.addConstraint(changeVertical)
        self.addConstraint(changeHorizontal)
        self.addConstraint(timeVertical)
        self.addConstraint(timeHorizontal)
        self.addConstraint(segmentVertical)
        self.addConstraint(graphCenter)
        self.addConstraint(graphVertical1)
        self.addConstraint(graphVertical2)
        self.addConstraint(graphVertical)
        
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
            
            let value = data[relative + index]
            return CGFloat(value)
        }
        
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String {
        return ""
    }
    
    func numberOfGapsBetweenLabelsOnLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        switch(self.segmentControl.selectedSegmentIndex){
        case 0: return 5
        default: return 1
        }
    }
    
    func selectedIndexDidChange(sender: AnyObject) {
        self.graph.reloadGraph()
        
        //calculate percent change
        switch (self.segmentControl.selectedSegmentIndex){
        case 0:
            self.timeLabel.text = "TODAY"
            break
        case 1:
            self.timeLabel.text = "PAST  MONTH"
            break
        case 2:
            self.timeLabel.text = "PAST 3M"
            break
        case 3:
            self.timeLabel.text = "PAST 6M"
            break
        case 4:
            self.timeLabel.text = "PAST YEAR"
            break
        default:
            self.timeLabel.text = ""
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
        self.changeLabel.text = ""
        let change = (current - relative)
        let relativeChange = (change / relative) * 100.0
        let myString = String.localizedStringWithFormat("%.2f", relativeChange)
        if (change >= 0){
            //self.changeLabel.text = "+\(change) (\(myString)%)"
            self.changeLabel.text = "+\(change)%"
            self.changeLabel.textColor = turquoise
        } else {
            //self.changeLabel.text = "\(change) (\(myString)%)"
            self.changeLabel.text = "\(change)%"
            self.changeLabel.textColor = red
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
        self.topLabel.text = "\(data[helper + index])%"
        
        let current = data[helper + index]
        let change = (current - relative)
        let relativeChange = (change / relative) * 100.0
        let myString = String.localizedStringWithFormat("%.2f", relativeChange)
        if (change >= 0){
            //self.changeLabel.text = "+\(change) (\(myString)%)"
            self.changeLabel.text = "+\(change)%"
            self.changeLabel.textColor = turquoise
        } else {
            //self.changeLabel.text = "\(change) (\(myString)%)"
            self.changeLabel.text = "\(change)%"
            self.changeLabel.textColor = red
        }
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, didReleaseTouchFromGraphWithClosestIndex index: CGFloat) {
        self.topLabel.text = "\(data[data.count - 1])%"
    }
}
