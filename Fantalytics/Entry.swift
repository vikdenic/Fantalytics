//
//  Entry.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/7/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class Entry: PFObject, PFSubclassing {

    override class func initialize()
    {
        self.registerSubclass()
    }

    class func parseClassName() -> String {
        return "Entry"
    }

    @NSManaged var user: User
    @NSManaged var contest: Contest
    @NSManaged var lineup: Lineup
}