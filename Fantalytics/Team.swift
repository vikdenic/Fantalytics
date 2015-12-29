//
//  Team.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/28/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class Team: PFObject, PFSubclassing {

    override class func initialize() {
        self.registerSubclass()
    }

    class func parseClassName() -> String {
        return "Team"
    }

    @NSManaged var teamId: String
    @NSManaged var abbrevName: String
}