//
//  SelectLineupViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 1/2/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

class SelectLineupViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var players : [Player]?  {
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SelectLineupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellPlayerSelection) as! SelectPlayerTableViewCell

        if let somePlayers = players {
            cell.player = somePlayers[indexPath.row]
        }
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let somePlayers = players {
            return somePlayers.count
        }
        return 0
    }
}

