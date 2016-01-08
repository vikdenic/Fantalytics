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
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        viewSetup()
        retrieveAndSetEntries()
    }

    //MARK: Data Helpers
    func retrieveAndSetEntries() {
        Entry.getAllEntriesForCurrentUser { (entries, error) -> Void in

            guard let someEntries = entries else {
                UIAlertController.showAlertWithError(error, forVC: self)
                return
            }
            print(self.entries)
            self.entries = someEntries
        }
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
        cell.entry = entry

        entry.contest.fetchIfNeededInBackgroundWithBlock { (object, error) -> Void in
            let someContest = object as! Contest
            cell.contest = someContest
        }

        entry.contest.timeSlot.fetchIfNeededInBackgroundWithBlock { (object, error) -> Void in
            let someSlot = object as! TimeSlot
            cell.timeSlot = someSlot
        }

        entry.contest.gameKind.fetchIfNeededInBackgroundWithBlock { (object, error) -> Void in
            let someGameKind = object as! GameKind
            cell.gameKind = someGameKind
        }

        entry.contest.contestKind.fetchIfNeededInBackgroundWithBlock { (object, error) -> Void in
            let someContestKind = object as! ContestKind
            cell.contestKind = someContestKind
        }
//        entry.contest.timeSlot.fetchIfNeededInBackgroundWithBlock { (object, error) -> Void in
//            let someTimeSlot = object as! TimeSlot
////            cell.dateLabel.text = someTimeSlot.startDate.toAbbrevString()
//        }

//        entry.contest.fetchIfNeededInBackgroundWithBlock { (object, error) -> Void in
//            let someContest = object as! Contest
//
//            cell.entry = someContest
//        }

//        cell.contestKindLabel.text = entry.contestKind.name
//        cell.gameKindLabel.text = entry.gameKind.name
//        cell.entryFeeLabel.text = "Entry: $\(entry.contest.entryFee)"

//        if segmentedControl.selectedSegmentIndex == 2 {
//            if let _ = entry.contest.winners {
//                cell.wonLabel.hidden = false
//                cell.wonLabel.text = "Won: $\(entry.contest.prizeAmount)" //TODO: If current user is winner
//            }
//        }

//        if entry.contestKind.objectId == ContestType.HeadToHead.parseObjectId {
//            cell.placeLabel.text = "nth / 2"
//        } else {
//            Entry.getAllEntriesForContest(entry.contest, completed: { (entries, error) -> Void in
//                guard let someEntries = entries else {
//                    UIAlertController.showAlertWithError(error, forVC: self)
//                    return
//                }
//                cell.placeLabel.text = "nth / \(someEntries.count)"
//            })
//        }
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    //MARK: TV DL
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedEntry = entries[indexPath.row] as Entry

        switch selectedEntry.contest.gameKind.objectId {
        case GameType.MarathonMan.parseObjectId as NSString:
            performSegueWithIdentifier(kSegueMyContestsToMMH2H, sender: self)
        default:
            break
        }
        return indexPath
    }
}
