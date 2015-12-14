//
//  GameKind.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/13/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class GameKind: PFObject, PFSubclassing {

    override class func initialize() {
        self.registerSubclass()
    }

    class func parseClassName() -> String {
        return "GameKind"
    }

    @NSManaged var name: String
}

/// An enum type used in conjunction with the GameKind class
enum GameType {
    case MarathonMan
    case SmartCat

    /// Returns an instance of a specific GameType object, which already exists on Parse.
    /// To access data on the object, fetch() will need to be called
    var parseObjectId : String {
        switch self {
        case .MarathonMan: return GameKind(withoutDataWithObjectId: "wZuUgXOYVw").objectId!;
        case .SmartCat: return GameKind(withoutDataWithObjectId: "2TaeS5emup").objectId!;
        }
    }
}