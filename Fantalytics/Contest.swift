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

    @NSManaged var entryFee: NSNumber
    @NSManaged var prizeAmount: NSNumber

    @NSManaged var creator: User!

    @NSManaged var timeSlot: TimeSlot!
    @NSManaged var contestKind: ContestKind!
    @NSManaged var gameKind: GameKind!

    @NSManaged var isPrivate: Bool
    @NSManaged var findsOpponent: Bool

    @NSManaged var winners: [AnyObject]?
    @NSManaged var invites: [AnyObject]?

    class func queryWithIncludes () -> PFQuery! {
        let query  = Contest.query()
        query?.includeKey("contestKind")
        query?.includeKey("gameKind")
        query?.includeKey("winners")
        query?.includeKey("timeSlot")

        return query
    }

    convenience init(creator : User, gameKind : GameKind, contestKind : ContestKind, timeSlot: TimeSlot!, entryFee : NSNumber, prizeAmount : NSNumber, isPrivate : Bool, findsOpponent : Bool, invites : [User]?) {
        self.init()
        self.creator = creator
        self.gameKind = gameKind
        self.contestKind = contestKind
        self.timeSlot = timeSlot

        self.entryFee = entryFee
        self.prizeAmount = prizeAmount

        self.isPrivate = isPrivate
        self.findsOpponent = findsOpponent

        if let someInvites = invites {
            self.invites = someInvites
        }
    }

    /**
     Finds TimeSlot objects that have yet to begin

     - parameter completed: The block to exectute, providing the array of of TimeSlot objects
     */
    class func getTimeSlots(timeSlot : TimeSlot, gameKind : GameKind, contestKind : ContestKind, completed:(contests : [Contest]?, error : NSError!) -> Void) {

        let query = Contest.queryWithIncludes()
        query?.whereKey("timeSlot", equalTo: timeSlot)
        query?.whereKey("gameKind", equalTo: gameKind)
        query?.whereKey("contestKind", equalTo: contestKind)
        query?.addAscendingOrder("createdAt")

        query!.findObjectsInBackgroundWithBlock { (objects, error) -> Void in

            guard let contests = objects as! [Contest]! else {
                completed(contests: nil, error: error)
                return
            }
            completed(contests: contests, error: nil)
        }
    }
}