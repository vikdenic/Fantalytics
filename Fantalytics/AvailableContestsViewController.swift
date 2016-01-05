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

    //MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == kSegueAvailableContestsToCreate {
            let navController = segue.destinationViewController as! UINavigationController
            let createContestVC = navController.viewControllers[0] as! CreateContestViewController
            createContestVC.availableContestsVC = self
            createContestVC.timeSlot = timeSlot
            createContestVC.gameKind = gameKind
            createContestVC.contestKind = contestKind
        }
    }
}

extension AvailableContestsViewController: UITableViewDataSource, UITableViewDelegate {
    //Datasource
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

    //Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertController(title: "Join Contest?", message: nil, preferredStyle: .Alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)

        let okayAction = UIAlertAction(title: "Join", style: .Default) { (action) -> Void in
            self.performSegueWithIdentifier(kSegueAvailableContestsToSelectLineup, sender: self)
        }

        alert.addAction(okayAction)
        alert.addAction(cancelAction)

        presentViewController(alert, animated: true, completion: nil)
    }
}