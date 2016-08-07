//
//  MOCTeamsTableViewController.swift
//  MubalooOrganizationChart
//
//  Created by João Carreira on 06/08/16.
//  Copyright © 2016 João Carreira. All rights reserved.
//

import UIKit

/**
 *  protocol to establish communication between the masterVC (this) and the detailVC (TeamMembersTableVC)
 */
protocol MOCTeamSelectionDelegate: class {

    func teamSelected(team: MOCTeam)

}

class MOCTeamsTableViewController: UITableViewController {

    // a reference to our data source
    private var mubalooDataSource: MOCMubalooDataSource

    weak var delegate: MOCTeamSelectionDelegate?

    required init?(coder aDecoder: NSCoder) {

        mubalooDataSource = MOCMubalooDataSource.singleton

        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: "MOCTeamLeaderTableViewCell", bundle: nil), forCellReuseIdentifier: MOCTeamLeaderTableViewCell.cellIdentifier)

    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 2

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {

            return 1

        } else {

            return mubalooDataSource.numberOfTeams() ?? 0

        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if indexPath.section == 0 {

            let cell = tableView.dequeueReusableCellWithIdentifier(MOCTeamLeaderTableViewCell.cellIdentifier, forIndexPath: indexPath) as! MOCTeamLeaderTableViewCell

            let ceo = mubalooDataSource.getCeoData()

            if let ceo = ceo {

                cell.teamLeaderName?.text = ceo.getTeamMemberFullName()

                cell.teamLeaderImageView?.kf_setImageWithURL(NSURL(string: ceo.profileImageUrl!))

                cell.teamLeaderRole?.text = ceo.getTeamMemberRole()
                
            }

            return cell

        } else {

            let cell = tableView.dequeueReusableCellWithIdentifier("TeamCell", forIndexPath: indexPath)

            cell.textLabel?.text = mubalooDataSource.teamNameAtIndex(indexPath.row)

            return cell

        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let team = mubalooDataSource.teamAtIndex(indexPath.row)

        if let team = team {

            delegate?.teamSelected(team)

        } else {

            // TODO

        }

        // this allows the splitVC to work on iPhones
        if let teamMembersTableViewController = delegate as? MOCTeamMembersTableViewController {

            splitViewController?.showDetailViewController(teamMembersTableViewController.navigationController!, sender: nil)

        }

        UIView.animateWithDuration(0.3) {

            self.splitViewController?.preferredDisplayMode = .PrimaryHidden

        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        if indexPath.section == 0 {

            return 196

        } else {

            return 88.0
            
        }
    }
}
