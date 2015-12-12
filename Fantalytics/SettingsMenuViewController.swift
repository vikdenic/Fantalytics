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

    func setUpForm() {
        form =

            Section()

                <<< ButtonRow("username") {
                    $0.title = $0.tag
                    $0.presentationMode = .SegueName(segueName: "RowsExampleViewControllerSegue", completionCallback: nil)
                }

            +++ Section("")

                <<< ButtonRow("Add Funds") {
                    $0.title = $0.tag
                    $0.presentationMode = .SegueName(segueName: "RowsExampleViewControllerSegue", completionCallback: nil)
                }

                <<< ButtonRow("Withdraw") {
                    $0.title = $0.tag
                    $0.presentationMode = .SegueName(segueName: "RowsExampleViewControllerSegue", completionCallback: nil)
                }

                <<< ButtonRow("Transaction History") {
                    $0.title = $0.tag
                    $0.presentationMode = .SegueName(segueName: "RowsExampleViewControllerSegue", completionCallback: nil)
                }

            +++ Section("")

                <<< ButtonRow("Friends") {
                    $0.title = $0.tag
                    $0.presentationMode = .SegueName(segueName: "RowsExampleViewControllerSegue", completionCallback: nil)
                }

            +++ Section("")

                <<< ButtonRow("Rules") {
                    $0.title = $0.tag
                    $0.presentationMode = .SegueName(segueName: "RowsExampleViewControllerSegue", completionCallback: nil)
                }

                <<< ButtonRow("Support") {
                    $0.title = $0.tag
                    $0.presentationMode = .SegueName(segueName: "RowsExampleViewControllerSegue", completionCallback: nil)
                }

            +++ Section("")

                <<< ButtonRow("Log Out") {
                    $0.title = $0.tag
                    $0.presentationMode = .SegueName(segueName: "RowsExampleViewControllerSegue", completionCallback: nil)
                }.onCellSelection { cell, row in
                    self.logOutAndPresentLogin()
                }
    }

    func logOutAndPresentLogin(){
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

class EurekaLogoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageView = UIImageView(image: UIImage(named: "Eureka"))
        imageView.frame = CGRect(x: 0, y: 0, width: 320, height: 130)
        imageView.autoresizingMask = .FlexibleWidth
        self.frame = CGRect(x: 0, y: 0, width: 320, height: 130)
        imageView.contentMode = .ScaleAspectFit
        self.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
