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

        ProBballManager.getPlayersForTeam(NBATeam.GoldenState) { (teams) -> Void in
            //
        }
    }
}

