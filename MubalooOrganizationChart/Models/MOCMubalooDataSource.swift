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

    private var ceoData: MOCTeamMember?
    private var mubalooTeams: [MOCTeam]?

    static let mubalooDataSuccessfullyUpdatedNotificationName = "MubalooDataSuccessfullyUpdatedNotificationName"

    static let singleton = MOCMubalooDataSource()

    private override init() {

        print("MOCMubalooDataSource: init")

        super.init()

        mubalooTeams = Array()
        
    }

    func reloadDataSourceDataWithForceReload(forceReload: Bool, completionHandler: Bool -> Void) {

        if forceReload || ceoData == nil || mubalooTeams == nil {

            if Reachability.isConnectedToNetwork() {

                getMubalooData({ success in

                    if success {

                        print("MOCMubalooDataSource: data reload OK")

                        dispatch_async(dispatch_get_main_queue(), { 

                            NSNotificationCenter.defaultCenter().postNotificationName(MOCMubalooDataSource.mubalooDataSuccessfullyUpdatedNotificationName, object: nil)

                        })

                        completionHandler(true)

                    } else {

                        print("MOCMubalooDataSource: data reload NOK")

                        completionHandler(false)
                        
                    }
                })
                
            } else {
                
                print("MOCMubalooDataSource: data reload NOK due to no internet connection")

                completionHandler(false)
                
            }

        } else {

            print("MOCMubalooDataSource: no need to reload, data already cached")

            completionHandler(true)

        }
    }

    func numberOfTeams() -> Int? {

        return mubalooTeams?.count

    }

    func teamNameAtIndex(index: Int) -> String? {

        if let mubalooTeam = mubalooTeams?[index] {

            return mubalooTeam.teamName

        }

        return nil

    }

    func teamAtIndex(index: Int) -> MOCTeam? {

        return mubalooTeams?[index]
        
    }

    func getCeoData() -> MOCTeamMember? {

        return ceoData

    }

    private func getMubalooData(completionHandler: Bool -> Void) {

        JCNetworkWrapper.get(NSURL(string: url)!, headers: nil, parameters: nil) { (json, error) in

            if error == nil {

                print("MOCMubalooDataSource: data fetch OK")

                if let mubalooData = json as? [AnyObject] {

                    for mubalooEntry in mubalooData {

                        guard let teamData = MOCTeam(json: mubalooEntry as! Dictionary<String, AnyObject>) else {

                            print("MOCMubalooDataSource: error getting team data")

                            completionHandler(false)

                            return
                        }

                        // if we're able to parse the teamData object then we have a team and add it to our data source object

                        if let _ = teamData.teamName {

                            self.mubalooTeams?.append(teamData)

                        } else {

                            // if it's not a team then we try to parse the ceo data and we add it to our data source object

                            guard let teamMemberData = MOCTeamMember(json: mubalooEntry as! Dictionary<String, AnyObject>) else {

                                print("MOCMubalooDataSource: error getting ceo data")

                                completionHandler(false)
                                
                                return
                            }
                            
                            if let _ = teamMemberData.role {
                                
                                self.ceoData = teamMemberData
                            }
                        }
                    }

                    completionHandler(true)

                }

            } else {

                print("MOCMubalooDataSource: data fetch error")

                completionHandler(false)
            }
        }
    }
}
