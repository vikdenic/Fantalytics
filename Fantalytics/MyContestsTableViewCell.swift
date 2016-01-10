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

    var entriesCount: NSNumber? {
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
        self.entryFeeLabel.text = "Entry: $\(entry.contest.entryFee)"
        self.dateLabel.text = entry.contest.timeSlot.startDate.toAbbrevString()
        self.gameKindLabel.text = entry.contest.gameKind.name
        self.contestKindLabel.text = entry.contest.contestKind.name

        if let someEntriesCount = entriesCount {
            self.placeLabel.text = "nth / \(someEntriesCount)"
        }
    }
}
