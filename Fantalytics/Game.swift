//
//  Game.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/28/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class Game: PFObject, PFSubclassing {

    override class func initialize() {
        self.registerSubclass()
    }

    class func parseClassName() -> String {
        return "Game"
    }

    @NSManaged var date: NSDate
}