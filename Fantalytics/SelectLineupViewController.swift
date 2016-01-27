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

    @IBOutlet var tableView: UITableView!
    @IBOutlet var doneButton: UIBarButtonItem!

    var players : [Player]?  {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        Player.getAllPlayers(timeSlot) { (players, error) -> Void in
            print(players)
        }
    }

    //MARK: Actions
    @IBAction func onSegmentTapped(sender: UISegmentedControl) {
        
    }

    @IBAction func onDoneTapped(sender: UIBarButtonItem) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
}

extension SelectLineupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellPlayerSelection) as! SelectPlayerTableViewCell

        if let somePlayers = players {
            cell.player = somePlayers[indexPath.row]
        }
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let somePlayers = players {
            return somePlayers.count
        }
        return 0
    }
}

