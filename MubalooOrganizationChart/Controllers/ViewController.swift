//
//  ViewController.swift
//  MubalooOrganizationChart
//
//  Created by João Carreira on 05/08/16.
//  Copyright © 2016 João Carreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // TODO: remove
        let url = "http://developers.mub.lu/resources/team.json"
        JCNetworkWrapper.get(NSURL(string: url)!, headers: nil, parameters: nil) { (json, error) in
            print(json)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
