//
//  MOCTeamMembersTableViewController.swift
//  MubalooOrganizationChart
//
//  Created by João Carreira on 06/08/16.
//  Copyright © 2016 João Carreira. All rights reserved.
//

import UIKit
import Kingfisher

class MOCTeamMembersTableViewController: UITableViewController {

    var teamData: MOCTeam? {

        didSet {

            self.tableView.reloadData()

        }
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        if teamData == nil {

            teamData = MOCMubalooDataSource.singleton.teamAtIndex(0)
        }

        tableView.registerNib(UINib(nibName: "MOCTeamMemberTableViewCell", bundle: nil), forCellReuseIdentifier: MOCTeamMemberTableViewCell.cellIdentifier)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return teamData?.teamMembers?.count ?? 0

    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(MOCTeamMemberTableViewCell.cellIdentifier, forIndexPath: indexPath) as! MOCTeamMemberTableViewCell

        let teamMember = teamData?.teamMemberAtIndex(indexPath.row)
        
        cell.nameLabel?.text = teamMember?.getTeamMemberFullName()
        cell.roleLabel?.text = teamMember?.getTeamMemberRole()
        cell.teamMemberImageView.kf_setImageWithURL(NSURL(string: (teamMember?.profileImageUrl)!))

        return cell

    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return 88.0

    }
}

extension MOCTeamMembersTableViewController: MOCTeamSelectionDelegate {

    func teamSelected(team: MOCTeam) {

        teamData = team
    }
}
