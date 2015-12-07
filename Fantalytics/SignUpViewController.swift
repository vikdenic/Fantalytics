//
//  ViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 11/21/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onSignUpButtonTapped(sender: UIButton) {
        User.registerNewUser(usernameTextField.text, password: passwordTextField.text) { (error) -> Void in
            if error != nil {
                showAlertWithError(error, forVC: self)
            } else {
                print("signed in")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
}

class LoginViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onLoginButtonTapped(sender: UIButton) {
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) { (user, error) -> Void in
            if error != nil {
                showAlertWithError(error, forVC: self)
            } else {
                print("logged in")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
}