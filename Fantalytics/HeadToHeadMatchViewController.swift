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
    var entry2 : Entry? {
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

        Entry.getH2HOpponentEntryForEntry(entry1) { (entry, error) -> Void in
            guard let someEntry = entry else {
                return
            }
            self.entry2 = someEntry
            self.contestant2NameLabel.text = someEntry.user.username

            if let someScore = someEntry.lineup?.totalScore {
                self.contestant2ScoreLabel.text = someScore.roundToTwoPlaces()
            }
        }
    }
}

extension HeadToHeadMatchViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: TV DS
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellH2HMatch) as! HeadToHeadMatchTableViewCell

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension NSNumber {
    /**
     - returns: A String representation of the number rounded to two decimal places
     */
    func roundToTwoPlaces() -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.roundingMode = .RoundUp
        formatter.positiveFormat = "0.00"
        return formatter.stringFromNumber(self)!
    }
}
