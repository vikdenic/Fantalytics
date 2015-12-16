//
//  LobbyViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/6/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkForUser()
    }

    func checkForUser() {
        if User.currentUser() == nil {
            performSegueWithIdentifier(kSegueLobbyToRegister, sender: self)
        }
    }
}
