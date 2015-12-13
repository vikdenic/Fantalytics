//
//  MyContestsTableViewCell.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/13/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

class MyContestsTableViewCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contestKindLabel: UILabel!
    @IBOutlet var gameKindLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var wonLabel: UILabel!
    @IBOutlet var entryAmountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
