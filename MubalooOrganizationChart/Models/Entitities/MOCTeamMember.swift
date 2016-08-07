//
//  MOCTeamMember.swift
//  MubalooOrganizationChart
//
//  Created by Joao Carreira on 05/08/16.
//  Copyright © 2016 João Carreira. All rights reserved.
//

import Foundation
import Gloss

struct MOCTeamMember: Decodable {

    let teamMemberId: String?

    let firstName: String?

    let lastName: String?

    let role: String?

    let profileImageUrl: String?

    let isTeamLead: Bool?

    init?(json: JSON) {

        teamMemberId = "id" <~~ json

        firstName = "firstName" <~~ json

        lastName = "lastName" <~~ json

        role = "role" <~~ json

        profileImageUrl = "profileImageURL" <~~ json

        isTeamLead = "teamLead" <~~ json
        
    }

    func getTeamMemberFullName() -> String {

        return firstName! + " " + lastName!

    }

    func getTeamMemberRole() -> String {

        return role!
    }
}
