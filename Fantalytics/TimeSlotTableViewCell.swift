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

    var game : Game? {
        didSet {
            setUpCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpCell() {
        if let someGame = game {
            self.dayAndTimeLabel.text = someGame.date.toLocalString()
//            self.summaryLabel.text = someGameKind.startTime
        }
    }
}
