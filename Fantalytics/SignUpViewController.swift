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
            showAlert(SignUpError.EmptyFields.message, message: nil, viewController: self)
        } catch SignUpError.InvalidUsernameLength {
            showAlert(SignUpError.InvalidUsernameLength.message, message: nil, viewController: self)
        } catch SignUpError.InvalidPasswordLength {
            showAlert(SignUpError.InvalidPasswordLength.message, message: nil, viewController: self)
        } catch SignUpError.InvalidUsernameCharacters {
            showAlert(SignUpError.InvalidUsernameCharacters.message, message: nil, viewController: self)
        } catch {
            showAlert("Oops", message: SignUpError.Other.message, viewController: self)
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