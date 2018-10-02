//
//  ListEventTableViewCell.swift
//  sportsEvents
//
//  Created by Mario Acero on 9/30/18.
//  Copyright © 2018 MarioAcero. All rights reserved.
//

import UIKit

class ListEventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
