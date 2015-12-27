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

    @NSManaged var startTime: NSDate!

    convenience init(date: NSDate) {
        self.init()
        self.startTime = date
    }

    class func getCurrentTimeSlots(completed:(timeSlots : [TimeSlot]?, error : NSError!) -> Void) {

        let query = TimeSlot.query()
        query?.whereKey("startTime", greaterThan: NSDate())

        query!.findObjectsInBackgroundWithBlock { (objects, error) -> Void in

            guard let timeSlots = objects as! [TimeSlot]! else {
                completed(timeSlots: nil, error: error)
                return
            }
            completed(timeSlots: timeSlots, error: nil)
        }
    }

    class func getEarliestTimeSlotForToday(completed:(timeSlot : TimeSlot?, error : NSError!) -> Void) {
        ProBballManager.getGamesForDate(NSDate()) { (games) -> Void in

            if let someGames = games {
                for game in someGames {
                    let dateString =  game["date"].string
                    let timeSlot = TimeSlot(date: (dateString?.toDate(forTimeZone: kTimeZoneEastern))!)
                    print(timeSlot.startTime)
                    timeSlot.saveInBackground()
                }
            }
        }
    }

    class func getAllTimeSlots(completed:(timeSlots : [TimeSlot]?, error : NSError!) -> Void) {

        let query = TimeSlot.query()

        query!.findObjectsInBackgroundWithBlock { (objects, error) -> Void in

            guard let timeSlots = objects as! [TimeSlot]! else {
                completed(timeSlots: nil, error: error)
                return
            }
            completed(timeSlots: timeSlots, error: nil)
        }
    }
}