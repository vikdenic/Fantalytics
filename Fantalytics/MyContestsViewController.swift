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
            self.entries = someEntries
        }
    }

    //MARK: View Helpers
    func viewSetup() {
        segmentedControl.selectedSegmentIndex = 2
    }

    //MARK: Actions
    @IBAction func onSegmentTapped(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {

        } else {

        }
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

        Entry.getAllEntriesForContest(entry.contest) { (entries, error) -> Void in
            guard let someEntries = entries else {
                return
            }
             cell.entriesCount = someEntries.count
        }

//        if segmentedControl.selectedSegmentIndex == 2 {
//            if let _ = entry.contest.winners {
//                cell.wonLabel.hidden = false
//                cell.wonLabel.text = "Won: $\(entry.contest.prizeAmount)" //TODO: If current user is winner
//            }
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
