//
//  ViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 11/21/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ProBballManager.getGamesForDate("2015-12-04", season: "2015") { (games) -> Void in
            guard let someGames = games else {
                //handle no games
                print("Games came back nil")
                return
            }
            print(someGames)
        }
    }
}

