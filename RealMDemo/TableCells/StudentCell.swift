//
//  StudentCell.swift
//  RealMDemo
//
//  Created by Harendra Sharma on 10/04/20.
//  Copyright © 2020 Harendra Sharma. All rights reserved.
//

import UIKit

class StudentCell: UITableViewCell {

    @IBOutlet var TFName: UILabel!
    @IBOutlet var TFStandard: UILabel!
    @IBOutlet var TFAge: UILabel!
    @IBOutlet var TFAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
