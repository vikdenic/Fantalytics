//
//  User.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/6/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

enum SignUpError: ErrorType {
    case EmptyFields
    case InvalidPasswordLength
    case InvalidUsernameLength
    case InvalidUsernameCharacters
}

import Parse

class User: PFUser {

    override class func initialize()
    {
        self.registerSubclass()
    }

    ///Creates a new user
    class func registerNewUser(username : String!, password : String!, completed:(error : NSError!) -> Void) throws
    {
        guard username.characters.count > 0 || password.characters.count > 0 else {
            throw SignUpError.EmptyFields
        }
        guard username.characters.count >= 3 && username.characters.count <= 15 else {
            throw SignUpError.InvalidUsernameLength
        }
        guard username.containsValidCharacters() else {
            throw SignUpError.InvalidUsernameCharacters
        }
        guard password.characters.count >= 7 else {
            throw SignUpError.InvalidPasswordLength
        }

        let newUser = User()
        newUser.username = username.lowercaseString
        newUser.password = password.lowercaseString

        newUser.signUpInBackgroundWithBlock { (succeeded, signUpError) -> Void in
            completed(error: signUpError)
        }
    }
}