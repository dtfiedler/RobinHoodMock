//
//  TestViewController.swift
//  RobinHoodMock
//
//  Created by Dylan Fiedler on 1/7/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit
import BEMSimpleLineGraph

class TestViewController: UIViewController, UIScrollViewDelegate{

    let WIDTH: CGFloat = 247
    let HEIGHT: CGFloat = 360
    var current = ""
    
    @IBOutlet var scrollview: UIScrollView!
    
    let data: [Double] = [4, 6, 8, 10, 12, 11, 8, 6, 9, 14, 12, 7, 5, 3, 2, 1, 1, 2, 4, 5, 8, 9, 10, 5, 6, 4, 3,1.0,2.0,3.0,2.0,0.0,1.0,2.0,3.0,2.0,3,5,6,3,4,2,5,7,8,11,15,15,16,17,18,15,13,12,14,14,15,17,18,19, 20, 17, 22, 21, 20, 22, 19, 14, 12, 13, 11, 15, 17, 18]
    
    var machineNames: [String] = []
    var graphData: [[Double]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollview.delegate = self
        self.scrollview.pagingEnabled = true
        self.scrollview.directionalLockEnabled = true
        var number = 0
        var frame: CGFloat = 0
        for var i = 0; i < 5; i++ {
            let graphView = GraphScrollView(data: graphData[i])
            let value = graphData[i].last
            graphView?.topLabel.text = "\(value!)%"
            scrollview.addSubview(graphView!)
            graphView!.frame = CGRect(x: graphView!.frame.width * CGFloat(i), y: 0, width: self.view.frame.width, height: self.view.frame.height)
            number = i
            frame = (graphView?.frame.width)!
            graphView?.percentChange()
            graphView?.segmentControl.selectedSegmentIndex = 2
            graphView?.timeLabel.text = "PAST 3M"
        }
        
        scrollview.contentSize = CGSizeMake(CGFloat(frame) * CGFloat(number + 1), self.view.frame.height * 10)
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(18.0, weight: UIFontWeightLight), NSForegroundColorAttributeName: UIColor.blackColor()]
        
        var indexOfPage = Int(self.scrollview.contentOffset.x / self.scrollview.frame.size.width)
        self.navigationItem.title = machineNames[indexOfPage]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var indexOfPage = Int(self.scrollview.contentOffset.x / self.scrollview.frame.size.width)
        self.navigationItem.title = machineNames[indexOfPage]
    }

}
