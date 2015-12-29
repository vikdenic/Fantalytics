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

    class func getAllGamesForToday(completed:(games : [Game]?, error : NSError!) -> Void) {

        let query = Game.query()
        query?.whereKey("date", greaterThan: NSDate())

        query!.findObjectsInBackgroundWithBlock { (objects, error) -> Void in

            guard let games = objects as! [Game]! else {
                completed(games: nil, error: error)
                return
            }
            completed(games: games, error: nil)
        }
    }
}