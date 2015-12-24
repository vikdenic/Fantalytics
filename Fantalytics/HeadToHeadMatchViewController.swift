//
//  MarathonH2HMatchViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/15/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit
import Parse

class HeadToHeadMatchViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var contestant1NameLabel: UILabel!
    @IBOutlet var contestant2NameLabel: UILabel!
    @IBOutlet var contestant1ScoreLabel: UILabel!
    @IBOutlet var contestant2ScoreLabel: UILabel!

    var entry1 : Entry!

    var players1 : [Player]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    var players2 : [Player]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableHeaderView?.layer.borderWidth = 1.0
        self.tableView.tableHeaderView?.layer.borderColor = UIColor.lightGrayColor().CGColor

        self.contestant1NameLabel.text = entry1.user.username

        if let someScore = entry1.lineup?.totalScore {
            self.contestant1ScoreLabel.text = someScore.roundToTwoPlaces()
        }

        entry1.lineup?.getAllPlayers({ (players, error) -> Void in
            self.players1 = players
        })

        Entry.getH2HOpponentEntryForEntry(entry1) { (entry, error) -> Void in
            guard let someEntry2 = entry else {
                return
            }
            self.contestant2NameLabel.text = someEntry2.user.username

            if let someScore = someEntry2.lineup?.totalScore {
                self.contestant2ScoreLabel.text = someScore.roundToTwoPlaces()
            }

            someEntry2.lineup?.getAllPlayers({ (players, error) -> Void in
                self.players2 = players
            })
        }
    }
}

extension HeadToHeadMatchViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: TV DS
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellH2HMatch) as! HeadToHeadMatchTableViewCell

        if let somePlayers1 = players1 {
            cell.player1 = somePlayers1[indexPath.row]
        }

        if let somePlayers2 = players2 {
            cell.player2 = somePlayers2[indexPath.row]
        }

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let somePlayers1 = players1 {
            return somePlayers1.count
        }
        return 0
    }
}
