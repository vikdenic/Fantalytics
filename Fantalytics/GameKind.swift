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

enum GameType {
    case MarathonMan
    case SmartCat

    var parseObject : GameKind {
        switch self {
        case .MarathonMan: return GameKind(withoutDataWithObjectId: "wZuUgXOYVw");
        case .SmartCat: return GameKind(withoutDataWithObjectId: "2TaeS5emup");
        }
    }
}