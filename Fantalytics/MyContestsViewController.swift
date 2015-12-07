//
//  MyContestsViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/6/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class MyContestsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let query = PFQuery(className: "Entry")
        query.whereKey("user", equalTo: User.currentUser()!)

        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in

            guard let entries = objects as! [Entry]! else {
                showAlertWithError(error, forVC: self)
                return
            }

            for entry in entries {
                let lineup = entry.lineup
                let relation = lineup.players
                let query2 = relation.query()
                query2?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in

                    guard let players = objects as! [Player]! else {
                        showAlertWithError(error, forVC: self)
                        return
                    }
                    print(players)
                })
            }
        }
    }
}
