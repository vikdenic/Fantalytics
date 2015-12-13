//
//  ContestKind.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/13/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class ContestKind: PFObject, PFSubclassing {

    override class func initialize() {
        self.registerSubclass()
    }

    class func parseClassName() -> String {
        return "ContestKind"
    }

    @NSManaged var name: String
}

enum ContestType {
    case HeadToHead
    case Pool

    var parseObject : ContestKind {
        switch self {
        case .HeadToHead: return ContestKind(withoutDataWithObjectId: "kIjN1WbMis");
        case .Pool: return ContestKind(withoutDataWithObjectId: "TLsqXoEbRm");
        }
    }
}