//
//  SelectPlayerCollectionViewCell.swift
//  Fantalytics
//
//  Created by Vik Denic on 1/4/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

class SelectPlayerTableViewCell: UITableViewCell {

    @IBOutlet var playerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var gameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!

    var player : Player? {
        didSet {
            setUpCell()
        }
    }

    func setUpCell() {
        nameLabel.text = player!.firstName + " " + player!.lastName
    }
}
