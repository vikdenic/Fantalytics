//
//  AvailableContestsViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/26/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

class AvailableContestsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var contests : [Contest]?  {
        didSet {
            self.tableView.reloadData()
        }
    }

    var timeSlot : TimeSlot!
    var gameKind : GameKind!
    var contestKind : ContestKind!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveAndSetContests()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    //MARK: Data retrieval
    func retrieveAndSetContests() {
        Contest.getTimeSlots(timeSlot, gameKind: gameKind, contestKind: contestKind) { (contests, error) -> Void in
            guard let someContests = contests else {
                return
            }
            self.contests = someContests
        }
    }
}

extension AvailableContestsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellAvailableContest) as! AvailableContestTableViewCell

        if let someContests = contests {
            cell.contest = someContests[indexPath.row]
        }
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let someContests = contests {
            return someContests.count
        }
        return 0
    }
}