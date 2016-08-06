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

    var ceoData: MOCTeamMember?
    var mubalooTeams: [MOCTeam]?

    static let singleton = MOCMubalooDataSource()

    private override init() {

        print("MOCMubalooDataSource: init")

        mubalooTeams = Array()
        super.init()

    }

    func loadData() {

        // TODO: remove
        JCNetworkWrapper.get(NSURL(string: url)!, headers: nil, parameters: nil) { (json, error) in

            if error == nil {

                print("MOCMubalooDataSource: data fetch OK")

                if let mubalooData = json as? [AnyObject] {

                    for mubalooEntry in mubalooData {

                        print(mubalooEntry)

                        guard let teamData = MOCTeam(json: mubalooEntry as! Dictionary<String, AnyObject>) else {

                            print("MOCMubalooDataSource: error getting team data")

                            return
                        }

                        // if we're able to parse the teamData object then we have a team and add it to our data source object
                        if let _ = teamData.teamName {

                            self.mubalooTeams?.append(teamData)

                        } else {

                            // if it's not a team then we try to parse the ceo data and we add it to our data source object

                            guard let teamMemberData = MOCTeamMember(json: mubalooEntry as! Dictionary<String, AnyObject>) else {

                                print("MOCMubalooDataSource: error getting ceo data")
                                
                                return
                            }
                            
                            if let _ = teamMemberData.role {
                                
                                self.ceoData = teamMemberData
                            }
                        }
                    }
                }
            } else {

                print("MOCMubalooDataSource: data fetch error")

            }
        }
    }
}
