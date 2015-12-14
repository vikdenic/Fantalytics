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

        var charSet = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_")
        charSet = charSet.invertedSet

        let range = (self as NSString).rangeOfCharacterFromSet(charSet)

        if range.location != NSNotFound {
            return false
        }

        return true
    }
}


extension NSDate {
    /**
     - returns: a String representation of the date in MM-dd-yyyy format (ex: 12/02/90)
     */
    func toMonthDayYearAbbrevString() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yy"
        return dateFormatter.stringFromDate(self)
    }
}
