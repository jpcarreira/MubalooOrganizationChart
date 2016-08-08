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

            self.title = String((teamData?.teamName)! + " Team")

        }
    }

    var teamWithoutLeader: [MOCTeamMember]? {

        return teamData?.getTeamWithoutLeader()
    }

    let simpleTransitionDelegate = JCSimpleTransitioningDelegate()

    override func viewDidLoad() {

        super.viewDidLoad()

        // when the app first launches, the data fetch from the server is probably still running in another thread
        // meaning teamData is likely nil and we won't have data to populate this VC
        // therefore we register to listen for this notification in order to reload the table view once the data
        // is received from the server

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MOCTeamMembersTableViewController.dataSourceUpdated), name: MOCMubalooDataSource.mubalooDataSuccessfullyUpdatedNotificationName, object: nil)

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

            if let teamLead = teamLead {

                cell.teamLeaderName?.text = teamLead.getTeamMemberFullName()

                cell.teamLeaderImageView.kf_setImageWithURL(NSURL(string: (teamLead.profileImageUrl)!))

                cell.teamLeaderRole?.text = teamLead.getTeamMemberRole()

            }

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

extension MOCTeamMembersTableViewController {

    func dataSourceUpdated() {

        // with the data successfully received from the server we can know use the first team to populate this VC 
        // we check for teamData being nil because this only happens when app is launched for the first time and

        // if we reach this VC by navigating from the masterVC (MOCTeamsTableVC) teamData is never nil and thus 
        // we don't fill this VC is data from the first team in case the data source gets updated (by calling it
        // explicatally somewhere else)

        if teamData == nil {

            teamData = MOCMubalooDataSource.singleton.teamAtIndex(0)

            self.tableView.reloadData()

        }
    }
}
