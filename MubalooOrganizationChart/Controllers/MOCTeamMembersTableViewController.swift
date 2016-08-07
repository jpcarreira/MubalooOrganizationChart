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

    let simpleTransitionDelegate = JCSimpleTransitioningDelegate()

    override func viewDidLoad() {

        super.viewDidLoad()

        if teamData == nil {

            teamData = MOCMubalooDataSource.singleton.teamAtIndex(0)
        }

        tableView.registerNib(UINib(nibName: "MOCTeamMemberTableViewCell", bundle: nil), forCellReuseIdentifier: MOCTeamMemberTableViewCell.cellIdentifier)

        tableView.registerNib(UINib(nibName: "MOCTeamLeaderTableViewCell", bundle: nil), forCellReuseIdentifier: MOCTeamLeaderTableViewCell.cellIdentifier)
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

            let cell = tableView.dequeueReusableCellWithIdentifier(MOCTeamLeaderTableViewCell.cellIdentifier, forIndexPath: indexPath) as! MOCTeamLeaderTableViewCell

            let teamLead = teamData?.getTeamLeader()

            cell.teamLeaderName?.text = teamLead?.getTeamMemberFullName()
            cell.teamLeaderImageView.kf_setImageWithURL(NSURL(string: (teamLead?.profileImageUrl)!))

            return cell

        } else {

            let cell = tableView.dequeueReusableCellWithIdentifier(MOCTeamMemberTableViewCell.cellIdentifier, forIndexPath: indexPath) as! MOCTeamMemberTableViewCell

            let teamMember = teamWithoutLeader?[indexPath.row]

            if let teamMember = teamMember {

                cell.nameLabel?.text = teamMember.getTeamMemberFullName()
            
                cell.teamMemberImageView.kf_setImageWithURL(NSURL(string: (teamMember.profileImageUrl)!))

            }

            return cell

        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        if indexPath.section == 0 {

            return 196

        } else {

            return 88.0

        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        transitioningDelegate = simpleTransitionDelegate

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let teamMemberDetailViewController = storyboard.instantiateViewControllerWithIdentifier(MOCTeamMemberDetailViewController.viewControllerIdentifier) as! MOCTeamMemberDetailViewController

        _ = teamMemberDetailViewController.view

        teamMemberDetailViewController.transitioningDelegate = simpleTransitionDelegate

        teamMemberDetailViewController.modalPresentationStyle = UIModalPresentationStyle.Custom

        let teamMember: MOCTeamMember?

        if indexPath.section == 0 {

            teamMember = teamData?.getTeamLeader()

        } else {

            teamMember = teamWithoutLeader?[indexPath.row]

        }

        if let teamMember = teamMember {

            teamMemberDetailViewController.nameLabel.text = teamMember.getTeamMemberFullName()

            teamMemberDetailViewController.roleLabel.text = teamMember.getTeamMemberRole()

            teamMemberDetailViewController.teamMemberImageView.kf_setImageWithURL(NSURL(string: (teamMember.profileImageUrl)!))

        }

        presentViewController(teamMemberDetailViewController, animated: true, completion: nil)
    }
}

extension MOCTeamMembersTableViewController: MOCTeamSelectionDelegate {

    func teamSelected(team: MOCTeam) {

        teamData = team
    }
}
