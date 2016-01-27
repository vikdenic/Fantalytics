//
//  Player.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/7/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class Player: PFObject, PFSubclassing {

    override class func initialize() {
        self.registerSubclass()
    }

    class func parseClassName() -> String {
        return "Player"
    }

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var position: String
    @NSManaged var playerId: NSNumber
    @NSManaged var teamId: NSNumber
    @NSManaged var team: Team

    class func queryWithIncludes () -> PFQuery! {
        let query  = Player.query()
        query?.includeKey("team")
        return query
    }

    /**
     Retrieves all Players who have games within the specified TimeSlot

     - parameter completed: the block to execture, providing the array of players
     */
    class func getAllPlayers(timeSlot : TimeSlot, completed:(players : [Player]?, error : NSError!) -> Void) {

        Game.getAllGames(forTimeSlot: timeSlot) { (games, error) -> Void in
            var teams = [Team]()
            for game in games! {
                teams.append(game.homeTeam)
                teams.append(game.awayTeam)
            }

            let playerQuery = Player.queryWithIncludes()
            playerQuery.whereKey("team", containedIn: teams)

            playerQuery.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                guard let players = objects as! [Player]! else {
                    completed(players: nil, error: error)
                    return
                }
                completed(players: players, error: nil)
            })
        }
    }
}