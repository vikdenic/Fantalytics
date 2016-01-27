//
//  SelectLineupViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 1/2/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

class SelectLineupViewController: UIViewController {

    var timeSlot : TimeSlot!
    var allPlayers : [Player]?
    var filteredPlayers = [Player]?()

    @IBOutlet var tableView: UITableView!
    @IBOutlet var doneButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        navigationItem.hidesBackButton = true

        Player.getAllPlayers(timeSlot) { (players, error) -> Void in
            self.allPlayers = players
            self.filterPlayersByPosition(1)
        }
    }

    //MARK: Actions
    @IBAction func onSegmentTapped(sender: UISegmentedControl) {
        filterPlayersByPosition(sender.selectedSegmentIndex + 1)
    }

    @IBAction func onDoneTapped(sender: UIBarButtonItem) {
        navigationController?.popToRootViewControllerAnimated(true)
    }

    //MARK: Helpers
    func filterPlayersByPosition(position : NSNumber) {
        if let somePlayers = allPlayers {
            var temporaryArray = [Player]()
            for player in somePlayers where player.position == position.stringAbbrev() {
                temporaryArray.append(player)
            }
            filteredPlayers = temporaryArray
            self.tableView.reloadData()
        }
    }
}

extension SelectLineupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellPlayerSelection) as! SelectPlayerTableViewCell

        if let somePlayers = filteredPlayers {
            cell.player = somePlayers[indexPath.row]
        }
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let somePlayers = filteredPlayers {
            return somePlayers.count
        }
        return 0
    }
}
