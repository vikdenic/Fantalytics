//
//  Entry.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/7/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class Entry: PFObject, PFSubclassing {

    override class func initialize() {
        self.registerSubclass()
    }

    class func parseClassName() -> String {
        return "Entry"
    }

    @NSManaged var user: User
    @NSManaged var contest: Contest
    @NSManaged var lineup: Lineup?

    @NSManaged var contestKind: ContestKind!
    @NSManaged var gameKind: GameKind!

    class func queryWithIncludes () -> PFQuery! {
        let query  = Entry.query()
        query?.includeKey("user")
        query?.includeKey("contestKind")
        query?.includeKey("gameKind")
        query?.includeKey("contest")
        query?.includeKey("lineup")

        return query
    }

    class func getAllEntriesForCurrentUser(completed:(entries : [Entry]?, error : NSError!) -> Void) {

        let query = Entry.queryWithIncludes()
        query.whereKey("user", equalTo: User.currentUser()!)

        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in

            guard let entries = objects as! [Entry]! else {
                completed(entries: nil, error: error)
                return
            }
            completed(entries: entries, error: nil)
        }
    }

    class func getAllEntriesForContest(contest : Contest, completed:(entries : [Entry]?, error : NSError!) -> Void) {
        let query = Entry.queryWithIncludes()
        query.whereKey("contest", equalTo: contest)

        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in

            guard let entries = objects as! [Entry]! else {
                completed(entries: nil, error: error)
                return
            }
            completed(entries: entries, error: nil)
        }
    }

    class func getH2HOpponentEntryForEntry(entry : Entry, completed:(entry : Entry?, error : NSError!) -> Void) {
        let query = PFQuery(className: "Entry")
        query.whereKey("contest", equalTo: entry.contest)
        query.whereKey("user", notEqualTo: User.currentUser()!)
        query.includeKey("user")
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            guard let someEntry = object as? Entry! else {
                completed(entry: nil, error: error)
                return
            }
            completed(entry: someEntry, error: nil)
        }
    }
}