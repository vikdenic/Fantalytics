//
//  Contest.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/7/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class Contest: PFObject, PFSubclassing {

    override class func initialize()
    {
        self.registerSubclass()
    }

    class func parseClassName() -> String {
        return "Contest"
    }

    @NSManaged var name: String
}