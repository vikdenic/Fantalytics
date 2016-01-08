//
//  MyContestsTableViewCell.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/13/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

class MyContestsTableViewCell: UITableViewCell {

    var entry: Entry! {
        didSet {
            setUpCell()
        }
    }

    var timeSlot: TimeSlot? {
        didSet {
            setUpCell()
        }
    }

    var contest: Contest? {
        didSet {
            setUpCell()
        }
    }

    var gameKind: GameKind? {
        didSet {
            setUpCell()
        }
    }

    var contestKind: ContestKind? {
        didSet {
            setUpCell()
        }
    }

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contestKindLabel: UILabel!
    @IBOutlet var gameKindLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var wonLabel: UILabel!
    @IBOutlet var entryFeeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpCell() {

        if let someContest = contest {
            self.entryFeeLabel.text = "Entry: $\(someContest.entryFee)"
        }

        if let someTimeSlot = timeSlot {
            self.dateLabel.text = someTimeSlot.startDate.toAbbrevString()
        }

        if let someGameKind = gameKind {
            self.gameKindLabel.text = someGameKind.name
        }

        if let someContestKind = contestKind {
            self.contestKindLabel.text = someContestKind.name
        }
    }
}
