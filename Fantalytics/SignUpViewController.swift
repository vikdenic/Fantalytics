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
            print("empty fields")
        } catch SignUpError.InvalidUsernameCharacters {
            print("invalid username characters")
        } catch SignUpError.InvalidUsernameLength {
            print("invalid username length")
        } catch SignUpError.InvalidPasswordLength {
            print("invalid password length")
        } catch {
            print("something went wrong")
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