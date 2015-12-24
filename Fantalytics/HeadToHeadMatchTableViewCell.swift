//
//  HeadToHeadMatchTableViewCell.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/15/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

class HeadToHeadMatchTableViewCell: UITableViewCell {

    var player1: Player! {
        didSet {
            setUpCell()
        }
    }

    var player2: Player? {
        didSet {
            setUpCell()
        }
    }

    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var nameLabel1: UILabel!
    @IBOutlet var nameLabel2: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpCell() {
        self.nameLabel1.text = player1.firstName + " " + player1.lastName

        if let somePlayer2 = player2 {
            self.nameLabel2.text = somePlayer2.firstName + " " + somePlayer2.lastName
        }
    }
}
