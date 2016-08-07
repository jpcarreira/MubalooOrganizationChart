//
//  MOCTeam.swift
//  MubalooOrganizationChart
//
//  Created by Joao Carreira on 05/08/16.
//  Copyright © 2016 João Carreira. All rights reserved.
//

import Foundation
import Gloss

struct MOCTeam: Decodable {

    let teamName: String?
    
    let teamMembers: [MOCTeamMember]?

    init?(json: JSON) {

        teamName = "teamName" <~~ json

        teamMembers = "members" <~~ json

    }

    func teamMemberAtIndex(index: Int) -> MOCTeamMember? {

        return teamMembers?[index]
        
    }
}
