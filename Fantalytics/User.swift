//
//  User.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/6/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

enum SignUpError: ErrorType {
    case EmptyFields
    case InvalidUsernameLength
    case InvalidPasswordLength
    case InvalidUsernameCharacters
    case Other

    var message : String {
        switch self {
        case .EmptyFields: return "Please enter a username and password"
        case .InvalidUsernameLength: return "Username can contain between 3 and 15 characters"
        case .InvalidPasswordLength: return "Password must be at least 7 characters long"
        case .InvalidUsernameCharacters: return "Usernames may only contain letters, numbers, and underscores"
        default: return "Something went wrong. Try again"
        }
    }
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
        guard password.characters.count >= 7 else {
            throw SignUpError.InvalidPasswordLength
        }
        guard username.containsValidCharacters() else {
            throw SignUpError.InvalidUsernameCharacters
        }

        let newUser = User()
        newUser.username = username.lowercaseString
        newUser.password = password.lowercaseString

        newUser.signUpInBackgroundWithBlock { (succeeded, signUpError) -> Void in
            completed(error: signUpError)
        }
    }
}