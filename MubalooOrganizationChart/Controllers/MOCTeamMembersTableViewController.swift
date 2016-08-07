//
//  MOCTeamMembersTableViewController.swift
//  MubalooOrganizationChart
//
//  Created by João Carreira on 06/08/16.
//  Copyright © 2016 João Carreira. All rights reserved.
//

import UIKit

class MOCTeamMembersTableViewController: UITableViewController {

    var teamData: MOCTeam? {

        didSet {

            self.tableView.reloadData()

        }
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        // TODO: test only
        teamData = MOCMubalooDataSource.singleton.teamAtIndex(0)
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return teamData?.teamMembers?.count ?? 0

    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("TeamMemberCell", forIndexPath: indexPath)

        let teamMember = teamData?.teamMemberAtIndex(indexPath.row)
        
        cell.textLabel?.text = teamMember?.getTeamMemberFullName()

        return cell

    }
}
