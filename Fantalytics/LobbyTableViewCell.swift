//
//  LobbyTableViewCell.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/25/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

class LobbyTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    var gameKind: GameKind! {
        didSet {
            setUpCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpCell() {
        if let someGameKind = gameKind {
            self.nameLabel.text = someGameKind.name
            self.descriptionLabel.text = someGameKind.summary
        }
    }
}
