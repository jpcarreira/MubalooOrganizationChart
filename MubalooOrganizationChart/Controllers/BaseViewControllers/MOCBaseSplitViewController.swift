//
//  MOCBaseSplitViewController.swift
//  MubalooOrganizationChart
//
//  Created by Joao Carreira on 07/08/16.
//  Copyright © 2016 João Carreira. All rights reserved.
//

// http://stackoverflow.com/questions/25875618/uisplitviewcontroller-in-portrait-on-iphone-shows-detail-vc-instead-of-master

import UIKit

class MOCBaseSplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {

        super.viewDidLoad()

        self.delegate = self
        
    }

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {

        return true

    }
}
