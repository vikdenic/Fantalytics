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

    @NSManaged var homeTeam: Team
    @NSManaged var awayTeam: Team

    class func queryWithIncludes () -> PFQuery! {
        let query  = Game.query()
        query?.includeKey("homeTeam")
        query?.includeKey("awayTeam")
        return query
    }

    /**
     Retrieves all Games that are valid for a given TimeSlot

     - parameter timeSlot:  the timeSlot for which you want games for
     - parameter completed: the block to execture, providing the array of games
     */
    class func getAllGames(forTimeSlot timeSlot: TimeSlot, completed:(games: [Game]?, error: NSError!) -> Void) {
        let query = Game.queryWithIncludes()
        query.whereKey("date", greaterThanOrEqualTo: timeSlot.startDate)

        query!.findObjectsInBackgroundWithBlock { (objects, error) -> Void in

            guard let games = objects as! [Game]! else {
                completed(games: nil, error: error)
                return
            }

            var validGames = [Game]()
            for game in games where NSCalendar.currentCalendar().isDate(game.date, equalToDate: timeSlot.startDate, toUnitGranularity: .Day) {
                validGames.append(game)
            }
            print(validGames)
            completed(games: validGames, error: nil)
        }
    }
}