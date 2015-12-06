//
//  User.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/6/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class User: PFUser {

    override class func initialize()
    {
        self.registerSubclass()
    }

    ///Creates a new user
    class func registerNewUser(username : String!, password : String!, completed:(result : Bool!, error : NSError!) -> Void)
    {
        let newUser = User()
        newUser.username = username.lowercaseString
        newUser.password = password.lowercaseString

        newUser.signUpInBackgroundWithBlock { (succeeded, signUpError) -> Void in
            if signUpError != nil {
                completed(result: false, error: signUpError)
            }
            else {
                completed(result: true, error: nil)
            }
        }
    }

    ///Logs in a user
    class func loginUser(username : String!, password : String!, completed:(result : Bool!, error : NSError!) -> Void)
    {
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, loginError) -> Void in

            if loginError != nil {
                completed(result: false, error: loginError)
            }
            else {
                completed(result: true, error: nil)
            }
        }
    }
}
