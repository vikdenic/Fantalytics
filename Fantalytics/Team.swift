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

    @NSManaged var teamId: NSNumber
    @NSManaged var abbrevName: String
    @NSManaged var cityName: String
    @NSManaged var teamName: String

    class func queryWithIncludes () -> PFQuery! {
        let query  = Team.query()
        return query
    }
}