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

    class func queryWithIncludes () -> PFQuery! {
        let query  = Entry.query()
        query?.includeKey("user")
        query?.includeKey("contest")
        query?.includeKey("contest.timeSlot")
        query?.includeKey("lineup")

        return query
    }

    convenience init(user : User, contest : Contest) {
        self.init()
        self.user = user
        self.contest = contest
    }

    /**
     Retrieves all Entry objects for the current user.

     - parameter completed: the block to execture, providing the array of entries
     */
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

    /**
     Retrieves all Entry objects for the specified Contest

     - parameter contest:   The Contest for which to retrieve all entries for
     - parameter completed: the block to execute, providing the array of entries
     */
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

    /**
     Retrieves the other Entry from the same Contest

     - parameter completed: the block to execute, provigin the opponent's Entry
     */
    func getH2HOpponentEntry(completed:(entry : Entry?, error : NSError!) -> Void) {
        let query = Entry.queryWithIncludes()
        query.whereKey("contest", equalTo: self.contest)
        query.whereKey("user", notEqualTo: User.currentUser()!)
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            guard let someEntry = object as? Entry! else {
                completed(entry: nil, error: error)
                return
            }
            completed(entry: someEntry, error: nil)
        }
    }
}