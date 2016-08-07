//
//  MOCTeamMemberDetailViewController.swift
//  MubalooOrganizationChart
//
//  Created by João Carreira on 07/08/16.
//  Copyright © 2016 João Carreira. All rights reserved.
//

import UIKit

class MOCTeamMemberDetailViewController: UIViewController {

    static let viewControllerIdentifier = "TeamMemberDetail"

    @IBOutlet weak var teamMemberImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var roleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dismissButtonIsPressed(sender: UIButton) {

        dismissViewControllerAnimated(true, completion: nil)

    }
}
