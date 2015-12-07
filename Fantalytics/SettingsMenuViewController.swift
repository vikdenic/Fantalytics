//
//  SettingsMenuViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/6/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

class SettingsMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onLogoutButtonTapped(sender: UIButton) {
        User.logOutInBackgroundWithBlock { (error) -> Void in
            if error != nil {
                print(error)
            } else {
                self.performSegueWithIdentifier(kSegueLogoutToRegister, sender: self)
                self.navigationController?.popToRootViewControllerAnimated(false)
            }
        }
    }
}
