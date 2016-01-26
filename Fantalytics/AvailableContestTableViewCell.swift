//
//  AvailableContestTableViewCell.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/26/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

class AvailableContestTableViewCell: UITableViewCell {

    @IBOutlet var versusLabel: UILabel!
    @IBOutlet var entryAmountLabel: UILabel!
    @IBOutlet var prizeAmountLabel: UILabel!

    var contest : Contest? {
        didSet {
            setUpCell()
        }
    }

    func setUpCell() {
        contest?.creator.fetchIfNeededInBackgroundWithBlock({ (object, error) -> Void in
            let creator = object as! User
            self.versusLabel.text = "vs \(creator.username!)"
        })
        entryAmountLabel.text = "Entry: $\(contest!.entryFee)"
        prizeAmountLabel.text = "Prize: $\(contest!.prizeAmount)"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
