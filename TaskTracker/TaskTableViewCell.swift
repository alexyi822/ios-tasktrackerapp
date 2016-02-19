//
//  TaskTableViewCell.swift
//  TaskTracker
//
//  Created by Alex Yi on 2/18/16.
//  Copyright © 2016 Alex Yi. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priorityView: UIView!

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
