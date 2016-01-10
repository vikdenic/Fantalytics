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

    @IBOutlet var noContestsLabel: UILabel!
    @IBOutlet var noContestsDescLabel: UILabel!

    var selectedEntry : Entry!

    var allEntries = [Entry]()
    var displayedEntries = [Entry]() {
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
            self.allEntries = someEntries
            self.sortEntries(byStatus: .TodayOrUpcoming)
        }
    }

    func sortEntries(byStatus status : EntryStatus) {
        var sortedArray = [Entry]()
        for entry in self.allEntries {
            if status == .TodayOrUpcoming {
                if entry.isTodayOrUpcoming() {
                    sortedArray.append(entry)
                }
            } else {
                if !entry.isTodayOrUpcoming() {
                    sortedArray.append(entry)
                }
            }
        }
        self.displayedEntries = sortedArray
        self.hideOrShowEmptyMessages()
    }

    //MARK: View Helpers
    func viewSetup() {
        self.segmentedControl.selectedSegmentIndex = 1
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    func hideOrShowEmptyMessages() {
        if self.displayedEntries.count == 0 {
            self.noContestsLabel.hidden = false
            self.noContestsDescLabel.hidden = false
        } else {
            self.noContestsLabel.hidden = true
            self.noContestsDescLabel.hidden = true
        }
    }

    //MARK: Actions
    @IBAction func onSegmentTapped(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            sortEntries(byStatus: .Recent)
            self.noContestsLabel.text = EntryStatus.Recent.emptyMessage
        } else {
            sortEntries(byStatus: .TodayOrUpcoming)
            self.noContestsLabel.text = EntryStatus.TodayOrUpcoming.emptyMessage
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

        let entry = displayedEntries[indexPath.row] as Entry
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
        return displayedEntries.count
    }

    //MARK: TV DL
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedEntry = displayedEntries[indexPath.row] as Entry

        switch selectedEntry.contest.gameKind.objectId {
        case GameType.MarathonMan.parseObjectId as NSString:
            performSegueWithIdentifier(kSegueMyContestsToMMH2H, sender: self)
        default:
            break
        }
        return indexPath
    }
}
