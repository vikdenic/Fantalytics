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
}