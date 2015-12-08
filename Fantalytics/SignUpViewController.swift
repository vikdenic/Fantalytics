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
        do {
            try User.registerNewUser(usernameTextField.text, password: passwordTextField.text, completed: { (error) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        } catch SignUpError.EmptyFields {
            showAlert("Please enter a username and password", message: nil, viewController: self)
        } catch SignUpError.InvalidUsernameCharacters {
            showAlert("Usernames may only contain letters, numbers, and underscores", message: nil, viewController: self)
        } catch SignUpError.InvalidUsernameLength {
            showAlert("Username can contain between 3 and 15 characters", message: nil, viewController: self)
        } catch SignUpError.InvalidPasswordLength {
            showAlert("Password must be at least 7 characters long", message: nil, viewController: self)
        } catch {
            showAlert("Oops", message: "Something went wrong. Try again", viewController: self)
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