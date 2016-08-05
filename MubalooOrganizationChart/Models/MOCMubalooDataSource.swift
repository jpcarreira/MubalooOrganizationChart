//
//  MOCMubalooDataSource.swift
//  MubalooOrganizationChart
//
//  Created by João Carreira on 05/08/16.
//  Copyright © 2016 João Carreira. All rights reserved.
//

import Foundation

final class MOCMubalooDataSource: NSObject {

    let url = "http://developers.mub.lu/resources/team.json"
    let ceoData: [MOCTeamMember]?
    let teamData: [MOCTeam]?

    static let singleton = MOCMubalooDataSource()

    private override init() {
        ceoData = nil
        teamData = nil
        super.init()
        print("MOCMubalooDataSource: init")
    }

    func test() {

        // TODO: remove
        JCNetworkWrapper.get(NSURL(string: url)!, headers: nil, parameters: nil) { (json, error) in

            if let mubalooData = json as? [AnyObject] {

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
