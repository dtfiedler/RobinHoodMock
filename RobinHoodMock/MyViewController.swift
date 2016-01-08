//
//  MyViewController.swift
//  RobinHoodMock
//
//  Created by Dylan Fiedler on 1/7/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit
import JWStackedBarChart

class MyViewController: UIViewController {

    @IBOutlet weak var stackedBar: JWStackedBarChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Horizontal
//        JWStackedBarChart *horizontalStackedBar = [[JWStackedBarChart alloc] initWithFrame:CGRectMake(20, 40, 200, 40) IsVertical:NO];
//        [self.view addSubview:horizontalStackedBar];
//        
//        horizontalStackedBar.attributesDic = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:15]};
//        
//        horizontalStackedBar.segmentsArray = @[[JWBarSegment barSegmentWithValue:20 Color:[UIColor blueColor]], [JWBarSegment barSegmentWithValue:30 Color:[UIColor greenColor]], [JWBarSegment barSegmentWithValue:50 Color:[UIColor redColor]]];
//        [horizontalStackedBar beginDrawing];
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
