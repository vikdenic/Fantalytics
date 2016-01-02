//
//  SettingsMenuViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/6/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit
import Eureka

class SettingsMenuViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpForm()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.translucent = false
    }

    //Using Eureka form builder library
    func setUpForm() {
        form =

            Section()

                <<< LabelRow(User.currentUser()?.username) {
                    $0.title = $0.tag
                }

            +++ Section("")

                <<< LabelRow("Add Funds") {
                    $0.title = $0.tag
                    $0.value = "$100"
                }

                <<< LabelRow("Withdraw") {
                    $0.title = $0.tag
                }

                <<< LabelRow("Transaction History") {
                    $0.title = $0.tag
                }

            +++ Section("")

                <<< LabelRow("Friends") {
                    $0.title = $0.tag
                }

            +++ Section("")

                <<< LabelRow("Rules") {
                    $0.title = $0.tag
                }

                <<< LabelRow("Support") {
                    $0.title = $0.tag
                }

            +++ Section("")

                <<< LabelRow("Log Out") {
                    $0.title = $0.tag
                }.onCellSelection { cell, row in
                    self.logOutAndPresentLogin()
                }
    }

    func logOutAndPresentLogin(){

        let alert = UIAlertController(title: "Log Out?", message: nil, preferredStyle: .Alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)

        let okayAction = UIAlertAction(title: "Log Out", style: .Default) { (action) -> Void in
            User.logOutInBackgroundWithBlock { (error) -> Void in
                if error != nil {
                    print(error)
                } else {
                    self.handleLogout()
                }
            }
        }

        alert.addAction(okayAction)
        alert.addAction(cancelAction)

        presentViewController(alert, animated: true, completion: nil)
    }

    func handleLogout(){
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
