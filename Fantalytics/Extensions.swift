//
//  Extensions.swift
//  Fantalytics
//
//  Created by Vik Denic on 11/21/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Foundation

extension String {
    func trimCharactersFromEnd(trimLength : Int) -> String {
        let index1 = self.endIndex.advancedBy(trimLength * -1)
        return self.substringToIndex(index1)
    }

    /**
     - returns: a Bool value representing whether or not the String only contains allowed characters (alphanumerics and underscores)
     */
    func containsValidCharacters() -> Bool {

        var charSet = NSCharacterSet(charactersInString: kPermittedCharacters)
        charSet = charSet.invertedSet

        let range = (self as NSString).rangeOfCharacterFromSet(charSet)

        if range.location != NSNotFound {
            return false
        }

        return true
    }

    /**
     Returns an NSDate object from a String in the format yyyy-MM-dd HH:mm:ss (i.e. "2015-12-25 17:00:00")

     - parameter timeZoneAbbrev: abbreviation of the timeZone to set the date to (i.e. "EST")

     - returns: An NSDate instance based on the String instance
     */
    func toDate(forTimeZone timeZoneAbbrev : String) -> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let est = NSTimeZone(abbreviation: timeZoneAbbrev) //date data from API is in EST
        formatter.timeZone = est
        return formatter.dateFromString(self)! //.dateByAddingTimeInterval(-3600*6)
    }
}

extension NSDate {
    /**
     - returns: a String representation of the date in local timezone in MM-dd-yyyy format (ex: 12/02/90)
     */
    func toAbbrevString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd-yy"
        let localTZ = NSTimeZone.localTimeZone()
        formatter.timeZone = localTZ
        return formatter.stringFromDate(self)
    }

    /**
     - returns: a String representation of the date acc. to local timezone in MM-dd-yyyy format (ex: 12/02/90)
     */
    func toLocalString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yy hh:mm a"
        let localTZ = NSTimeZone.localTimeZone()
        formatter.timeZone = localTZ
        return formatter.stringFromDate(self)
    }


    /**
     Returns a String object from a date, formatted to EST and in the format of yyyy-MM-dd (i.e. "2015-12-25")

     - parameter string: The NSDate to return the String from

     - returns: A String instance based on the provided NSDate
     */
    func toStringForAPI() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let est = NSTimeZone(abbreviation: "EST")
        formatter.timeZone = est
        return formatter.stringFromDate(self)
    }
}

extension NSNumber {
    /**
     - returns: A String representation of the number rounded to two decimal places
     */
    func roundToTwoPlaces() -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.roundingMode = .RoundUp
        formatter.positiveFormat = "0.00"
        return formatter.stringFromNumber(self)!
    }
    /**
     - returns: A String abbreviation of the basketball position (i.e. 1 returns "PG", 3 returns "SF", etc)
     */
    func stringAbbrev() -> String {
        switch self {
        case 1: return "PG"
        case 2: return "SG"
        case 3: return "SF"
        case 4: return "PF"
        case 5: return "C"
        default: return "P"
        }
    }
}