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

    @NSManaged var entriesCount: NSNumber
    @NSManaged var maxEntries: NSNumber

    @NSManaged var creator: User!

    @NSManaged var timeSlot: TimeSlot!
    @NSManaged var contestKind: ContestKind!
    @NSManaged var gameKind: GameKind!

    @NSManaged var isPrivate: Bool
    @NSManaged var findsOpponent: Bool

    @NSManaged var winners: [AnyObject]?
    @NSManaged var invites: [AnyObject]?

    @NSManaged var isFilled: Bool

    class func queryWithIncludes () -> PFQuery! {
        let query  = Contest.query()
        query?.includeKey("contestKind")
        query?.includeKey("gameKind")
        query?.includeKey("winners")
        query?.includeKey("timeSlot")

        return query
    }

    /**
     Conviently instantiates a Contest with the specified paramaters

     - parameter creator:       a pointer to the User who created the Contest
     - parameter gameKind:      a pointer to the kind of Game the Contest is (i.e. Marathon Man)
     - parameter contestKind:   a pointer to the kind of Contest the Contest is (i.e. Head-to-Head)
     - parameter timeSlot:      a pointer to the TimeSlot for which the contest will take place
     - parameter entryFee:      the entry fee amount required to join the Contest
     - parameter prizeAmount:   the prize fee amount required to join the Contest
     - parameter isPrivate:     whether or not the Contest is private. If private, it will be invite-only
     - parameter findsOpponent: whether or not the app will automatically find an opponent for the contest if no invitees accept
     - parameter invites:       an array of Users who are invited to the Contest

     */
    convenience init(creator : User, gameKind : GameKind, contestKind : ContestKind, timeSlot: TimeSlot!, entryFee : NSNumber, prizeAmount : NSNumber, isPrivate : Bool, findsOpponent : Bool, invites : [User]?, maxEntries : NSNumber) {
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

        self.maxEntries = maxEntries
        self.entriesCount = 0
        self.isFilled = false
    }

    /**
     Finds Contests for the provided parameters

     - parameter completed: The block to exectute, providing the array of of Contest objects
     */
    class func getContests(timeSlot : TimeSlot, gameKind : GameKind, contestKind : ContestKind, completed:(contests : [Contest]?, error : NSError!) -> Void) {

        let query = Contest.queryWithIncludes()
        query?.whereKey("timeSlot", equalTo: timeSlot)
        query?.whereKey("gameKind", equalTo: gameKind)
        query?.whereKey("contestKind", equalTo: contestKind)
        query?.whereKey("isFilled", equalTo: false)
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