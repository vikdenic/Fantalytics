//
//  TimeSlot.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/26/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Foundation
import Parse
import SwiftyJSON

class TimeSlot: PFObject, PFSubclassing {

    override class func initialize() {
        self.registerSubclass()
    }

    class func parseClassName() -> String {
        return "TimeSlot"
    }

    @NSManaged var startDate: NSDate!
    @NSManaged var isFirst: Bool

    convenience init(date: NSDate) {
        self.init()
        self.startDate = date
    }

    /**
     Finds TimeSlot objects that have yet to begin

     - parameter completed: The block to exectute, providing the array of of TimeSlot objects
     */
    class func getCurrentTimeSlots(completed:(timeSlots : [TimeSlot]?, error : NSError!) -> Void) {

        let query = TimeSlot.query()
        query?.whereKey("startDate", greaterThan: NSDate())
        query?.addAscendingOrder("startDate")

        query!.findObjectsInBackgroundWithBlock { (objects, error) -> Void in

            guard let timeSlots = objects as! [TimeSlot]! else {
                completed(timeSlots: nil, error: error)
                return
            }
            completed(timeSlots: timeSlots, error: nil)
        }
    }

    /**
     Returns a String of representing the slate of games (i.e. Today - All Games, Today - 7:30PM CST, Tomorrow - All Games, etc)

     - returns: a String representing the TimeSlot
     */
    func toTitleDisplayString() -> String {
        let dateFormatter = NSDateFormatter()
        var displayString = ""

        if self.startDate.isToday() {
            displayString = "Today - "
        } else if self.startDate.isTomorrow() {
            displayString = "Tomorrow - "
        } else {
            dateFormatter.dateFormat = "EEEE - "
            displayString = dateFormatter.stringFromDate(self.startDate)
        }

        dateFormatter.dateFormat = "h:mma z"
        return displayString + dateFormatter.stringFromDate(self.startDate)
    }

    /**
     Returns a String of representing a description for that slate of games (i.e. Contests including all of tomorrow's NBA games, etc)

     - returns:  a String of representing a description for that slate of games
     */
    func toSummaryDisplayString() -> String {
        if self.startDate.isToday() && self.isFirst {
            return "Contests including all of today's NBA games"
        } else if self.startDate.isTomorrow() && self.isFirst {
            return "Contests including all of tomorrow's NBA games"
        } else {
            return "Contests for today's NBA games starting at \(self.startDate.toSimpleTimeString()) and later"
        }
    }
}