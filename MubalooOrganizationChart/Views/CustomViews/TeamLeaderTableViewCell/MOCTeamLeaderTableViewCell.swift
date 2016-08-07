//
//  MOCTeamLeaderTableViewCell.swift
//  MubalooOrganizationChart
//
//  Created by João Carreira on 07/08/16.
//  Copyright © 2016 João Carreira. All rights reserved.
//

import UIKit

class MOCTeamLeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var teamLeaderImageView: UIImageView!

    @IBOutlet weak var teamLeaderName: UILabel!

    static let cellIdentifier = "TeamLeaderCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
