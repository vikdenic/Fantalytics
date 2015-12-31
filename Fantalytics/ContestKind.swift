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

/// An enum type used in conjunction with the ContestKind class
enum ContestType {
    case HeadToHead
    case Pool

    /// Returns an instance of a specific ContestKind object, which already exists on Parse.
    /// To access data on the object, fetch() will need to be called.
    var parseObjectId : String {
        switch self {
        case .HeadToHead: return ContestKind(withoutDataWithObjectId: "kIjN1WbMis").objectId!;
        case .Pool: return ContestKind(withoutDataWithObjectId: "TLsqXoEbRm").objectId!;
        }
    }

    /// Returns an instance of a specific ContestKind object, which already exists on Parse.
    /// To access data on the object, fetch() will need to be called.
    var parseObject : ContestKind {
        switch self {
        case .HeadToHead: return ContestKind(withoutDataWithObjectId: "kIjN1WbMis");
        case .Pool: return ContestKind(withoutDataWithObjectId: "TLsqXoEbRm")
        }
    }
}