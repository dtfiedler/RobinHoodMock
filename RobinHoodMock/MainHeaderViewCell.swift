//
//  MainHeaderViewCell.swift
//  RobinHoodMock
//
//  Created by Dylan Fiedler on 1/6/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit
import SCRSidewaysBarGraph
import HMSegmentedControl

class MainHeaderViewCell: UITableViewCell {

    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var firstSlider: SCRSidewaysBarGraph!
    @IBOutlet weak var segmentControl: HMSegmentedControl!
    @IBOutlet weak var secondSlider: SCRSidewaysBarGraph!
    @IBOutlet weak var thirdSlider: SCRSidewaysBarGraph!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func segmentControlDidChange(sender: AnyObject) {
        
        //calculate percent change
        print("segment control")

    }

}
