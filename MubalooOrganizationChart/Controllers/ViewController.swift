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

            if let mubalooData = json as? [AnyObject] {

                print(mubalooData)

                for mubalooEntry in mubalooData {

                    guard let teamData = MOCTeam(json: mubalooEntry as! Dictionary<String, AnyObject>) else {

                        print("Error getting team data")
                        return
                    }

                    print(teamData)
                }
            }
        }
    }
}
