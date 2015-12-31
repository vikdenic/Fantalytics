//
//  TimeSlotsViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/26/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

class TimeSlotsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var gameKind : GameKind!
    var contestKind : ContestKind!

    var timeSlots : [TimeSlot]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extendedLayoutIncludesOpaqueBars = true
        retrieveAndSetTimeSlots()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    //MARK: Data
    func retrieveAndSetTimeSlots() {
        TimeSlot.getCurrentTimeSlots { (timeSlots, error) -> Void in
            guard let someTimeSlots = timeSlots else {
                print(error)
                return
            }

            var validSlots = [TimeSlot]()
            for slot in someTimeSlots {
                if slot.startDate.isTomorrow() && !slot.isFirst {
                    continue
                }
                validSlots.append(slot as TimeSlot)
            }
            self.timeSlots = validSlots
        }
    }

    //Mark Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == kSegueTimeSlotsToAvailable {
            let contestsVC = segue.destinationViewController as! AvailableContestsViewController
            contestsVC.timeSlot = timeSlots![(tableView.indexPathForSelectedRow?.row)!]
            contestsVC.gameKind = gameKind
            contestsVC.contestKind = ContestType.HeadToHead.parseObject
        }
    }
}

extension TimeSlotsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellTimeSlot) as! TimeSlotTableViewCell

        if let someTimeSlots = self.timeSlots {
            cell.timeSlot = someTimeSlots[indexPath.row]
        }

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let someTimeSlots = self.timeSlots {
            return someTimeSlots.count
        }
        return 0
    }
}