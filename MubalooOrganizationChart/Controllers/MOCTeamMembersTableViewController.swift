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

    var teamWithoutLeader: [MOCTeamMember]? {

        return teamData?.getTeamWithoutLeader()
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        if teamData == nil {

            teamData = MOCMubalooDataSource.singleton.teamAtIndex(0)
        }

        tableView.registerNib(UINib(nibName: "MOCTeamMemberTableViewCell", bundle: nil), forCellReuseIdentifier: MOCTeamMemberTableViewCell.cellIdentifier)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 2

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {

            return 1

        } else {

            return teamWithoutLeader?.count ?? 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if indexPath.section == 0 {

            let cell = tableView.dequeueReusableCellWithIdentifier(MOCTeamMemberTableViewCell.cellIdentifier, forIndexPath: indexPath) as! MOCTeamMemberTableViewCell

            let teamLead = teamData?.getTeamLeader()

            cell.nameLabel?.text = teamLead?.getTeamMemberFullName()
            cell.roleLabel?.text = teamLead?.getTeamMemberRole()
            cell.teamMemberImageView.kf_setImageWithURL(NSURL(string: (teamLead?.profileImageUrl)!))

            return cell

        } else {

            let cell = tableView.dequeueReusableCellWithIdentifier(MOCTeamMemberTableViewCell.cellIdentifier, forIndexPath: indexPath) as! MOCTeamMemberTableViewCell

            let teamMember = teamWithoutLeader?[indexPath.row]

            if let teamMember = teamMember {

                cell.nameLabel?.text = teamMember.getTeamMemberFullName()
                cell.roleLabel?.text = teamMember.getTeamMemberRole()
                cell.teamMemberImageView.kf_setImageWithURL(NSURL(string: (teamMember.profileImageUrl)!))

            }

            return cell

        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        if indexPath.section == 0 {

            return 176

        } else {

            return 88.0

        }
    }
}

extension MOCTeamMembersTableViewController: MOCTeamSelectionDelegate {

    func teamSelected(team: MOCTeam) {

        teamData = team
    }
}
