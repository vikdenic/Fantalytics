//
//  MarathonH2HMatchViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/15/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit
import Parse

class HeadToHeadMatchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!

    var entry1 : Entry!
    var entry2 : Entry? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Entry.getH2HOpponentEntryForEntry(entry1) { (entry, error) -> Void in
            self.entry2 = entry
        }
    }

    //MARK: TV DS
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellH2HMatch) as! HeadToHeadMatchTableViewCell

        cell.nameLabel1.text = entry1.user.username

        if let otherEntry = entry2 {
            cell.nameLabel2.text = otherEntry.user.username
        }

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
