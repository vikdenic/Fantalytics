//
//  Contest.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/7/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class Contest: PFObject, PFSubclassing {

    override class func initialize() {
        self.registerSubclass()
    }

    class func parseClassName() -> String {
        return "Contest"
    }

    @NSManaged var name: String!
    @NSManaged var startDate: NSDate!
    @NSManaged var maxEntries: NSNumber!
    @NSManaged var minEntries: NSNumber!
    @NSManaged var entryFee: NSNumber!
    @NSManaged var prizeAmount: NSNumber!

    @NSManaged var contestKind: ContestKind!
    @NSManaged var gameKind: GameKind!

    @NSManaged var winners: [AnyObject]?
}