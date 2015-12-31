//
//  TimeSlotTableViewCell.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/26/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

class TimeSlotTableViewCell: UITableViewCell {

    @IBOutlet var dayAndTimeLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!

    var timeSlot : TimeSlot? {
        didSet {
            setUpCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpCell() {
        if let someTimeSlot = timeSlot {
            
            self.dayAndTimeLabel.text = someTimeSlot.startDate.toDayAndTimeZString()
//            self.summaryLabel.text = someGameKind.startTime
        }
    }
}
