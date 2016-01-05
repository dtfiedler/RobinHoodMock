//
//  SystemTableViewCell.swift
//  RobinHoodMock
//
//  Created by Dylan Fiedler on 12/17/15.
//  Copyright © 2015 xor. All rights reserved.
//

import UIKit
import BEMSimpleLineGraph

class SystemTableViewCell: UITableViewCell {

    @IBOutlet weak var systemID: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var lineGraph: BEMSimpleLineGraphView!
    @IBOutlet weak var statLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
