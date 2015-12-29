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

    var games : [Game]? {
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
        Game.getAllGamesForToday { (games, error) -> Void in
            guard let someGames = games else {
                print(error)
                return
            }
            self.games = someGames
        }
    }
}

extension TimeSlotsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellTimeSlot) as! TimeSlotTableViewCell

        if let someGames = self.games {
            cell.game = someGames[indexPath.row]
        }

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let someGames = self.games {
            return someGames.count
        }
        return 0
    }
}