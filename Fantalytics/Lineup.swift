//
//  Lineup.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/7/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class Lineup: PFObject, PFSubclassing {

    override class func initialize() {
        self.registerSubclass()
    }

    class func parseClassName() -> String {
        return "Lineup"
    }

    @NSManaged var players: PFRelation
    @NSManaged var totalScore: NSNumber?

    class func saveExampleLineup() {

        let player1 = Player()
        let player2 = Player()
        let player3 = Player()
        let player4 = Player()
        let player5 = Player()
        let lineup = Lineup()

        player1.firstName = "Damian"
        player1.lastName = "Lillard"

        player2.firstName = "Klay"
        player2.lastName = "Thompson"

        player3.firstName = "Kawhi"
        player3.lastName = "Leonard"

        player4.firstName = "Chris"
        player4.lastName = "Bosh"

        player5.firstName = "Andre"
        player5.lastName = "Drummond"

        let playersArray = [player1, player2, player3, player4, player5]

        for player in playersArray {
            player.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                if error != nil {
                    print(error)
                } else {
                    let relation = lineup.relationForKey("players")
                    relation.addObject(player)
                    lineup.saveInBackground()
                }
            }
        }
    }

    func getAllPlayers(completed:(players : [Player]?, error : NSError!) -> Void) {
        let relation = self.players
        let query = relation.query()
        query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in

            guard var players = objects as! [Player]! else {
                completed(players: nil, error: error)
                return
            }
            players.sortInPlace({ $0.position.toPositionNumber() < $1.position.toPositionNumber()})
            completed(players: players, error: nil)
        })
    }
}