//
//  MyContestsViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/6/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Parse

class MyContestsViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!

    var selectedEntry : Entry!

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
        tableView.reloadData()
        viewSetup()
    }

    //MARK: View Helpers
    func viewSetup() {
        segmentedControl.selectedSegmentIndex = 2
    }

    //MARK: Actions
    @IBAction func onSegmentTapped(sender: UISegmentedControl) {
    }

    //MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == kSegueMyContestsToMMH2H {
            let vc = segue.destinationViewController as! HeadToHeadMatchViewController
            vc.entry1 = selectedEntry
        }
    }
}

extension MyContestsViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: TV
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdMyContests) as! MyContestsTableViewCell

        let entry = entries[indexPath.row] as Entry

        cell.dateLabel.text = entry.contest.startDate.toMonthDayYearAbbrevString()
        cell.contestKindLabel.text = entry.contestKind.name
        cell.gameKindLabel.text = entry.gameKind.name
        cell.entryFeeLabel.text = "Entry: $\(entry.contest.entryFee)"

        if segmentedControl.selectedSegmentIndex == 2 {
            if let _ = entry.contest.winners {
                cell.wonLabel.hidden = false
                cell.wonLabel.text = "Won: $\(entry.contest.prizeAmount)" //TODO: If current user is winner
            }
        }

        if entry.contestKind.objectId == ContestType.HeadToHead.parseObjectId {
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

    //MARK: TV DL
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedEntry = entries[indexPath.row] as Entry

        switch selectedEntry.gameKind.objectId {
        case GameType.MarathonMan.parseObjectId as NSString:
            performSegueWithIdentifier(kSegueMyContestsToMMH2H, sender: self)
        default:
            break
        }
        return indexPath
    }
}
