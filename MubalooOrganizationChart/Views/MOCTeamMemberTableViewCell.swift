//
//  MOCTeamMemberTableViewCell.swift
//  MubalooOrganizationChart
//
//  Created by Joao Carreira on 07/08/16.
//  Copyright © 2016 João Carreira. All rights reserved.
//

import UIKit

class MOCTeamMemberTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var roleLabel: UILabel!

    static let cellIdentifier = "TeamMemberCell"

    override func awakeFromNib() {

        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {

        super.setSelected(selected, animated: animated)

    }
}
