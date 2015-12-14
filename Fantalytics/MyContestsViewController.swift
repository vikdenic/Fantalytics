//
//  MyContestsViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/6/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class MyContestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!

    var entries = [Entry]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Entry.getAllEntriesForCurrentUser { (entries, error) -> Void in

            guard let someEntries = entries else {
                showAlertWithError(error, forVC: self)
                return
            }
            
            self.entries = someEntries
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        viewSetup()
    }

    //MARK: Helpers
    func viewSetup() {
        segmentedControl.selectedSegmentIndex = 2
    }

    //MARK: TV
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdMyContests) as! MyContestsTableViewCell

        let entry = entries[indexPath.row] as Entry

        cell.dateLabel.text = entry.contest.startDate.toMonthDayYearAbbrevString()
        cell.contestKindLabel.text = entry.contestKind.name
        cell.gameKindLabel.text = entry.gameKind.name
        cell.entryFeeLabel.text = "Entry: $\(entry.contest.entryFee)"

        if entry.contestKind.objectId == ContestType.HeadToHead.parseObjectId
        {
            cell.placeLabel.text = "nth / 2"
        } else {
            Entry.getAllEntriesForContest(entry.contest, completed: { (entries, error) -> Void in
                guard let someEntries = entries else {
                    showAlertWithError(error, forVC: self)
                    return
                }
                cell.placeLabel.text = "nth / \(someEntries.count)"
            })
        }

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    //MARK: Actions
    @IBAction func onSegmentTapped(sender: UISegmentedControl) {
    }
}
