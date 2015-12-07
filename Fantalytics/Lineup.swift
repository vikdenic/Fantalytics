//
//  Lineup.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/7/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class Lineup: PFObject, PFSubclassing {

    override class func initialize()
    {
        self.registerSubclass()
    }

    class func parseClassName() -> String {
        return "Lineup"
    }

    @NSManaged var players: PFRelation
}

//    func relationExample() {
//        let player1 = Player()
//        let player2 = Player()
//        let lineup = Lineup()
//
//        player1.firstName = "Jimmy"
//        player1.lastName = "Butler"
//
//        player2.firstName = "Paul"
//        player2.lastName = "George"
//
//        player1.saveInBackgroundWithBlock { (succeeded, error) -> Void in
//            if error != nil {
//
//            } else {
//                let relation = lineup.relationForKey("players")
//                relation.addObject(player1)
//                lineup.saveInBackground()
//            }
//        }
//
//        player2.saveInBackgroundWithBlock { (succeeded, error) -> Void in
//            if error != nil {
//
//            } else {
//                let relation = lineup.relationForKey("players")
//                relation.addObject(player2)
//                lineup.saveInBackground()
//            }
//        }
//    }