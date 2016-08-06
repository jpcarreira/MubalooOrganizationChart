//
//  MOCTeamsTableViewController.swift
//  MubalooOrganizationChart
//
//  Created by João Carreira on 06/08/16.
//  Copyright © 2016 João Carreira. All rights reserved.
//

import UIKit

class MOCTeamsTableViewController: UITableViewController {

    // a reference to our data source
    private var mubalooDataSource: MOCMubalooDataSource

    required init?(coder aDecoder: NSCoder) {

        mubalooDataSource = MOCMubalooDataSource.singleton

        super.init(coder: aDecoder)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return mubalooDataSource.numberOfTeams() ?? 0

    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("TeamCell", forIndexPath: indexPath)

        cell.textLabel?.text = mubalooDataSource.teamNameAtIndex(indexPath.row)

        return cell

    }
}
