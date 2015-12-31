//
//  LobbyViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/6/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var gameKinds : [GameKind]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        GameKind.getAllGameKinds { (gameKinds, error) -> Void in
            self.gameKinds = gameKinds
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkForUser()
    }

    //MARK: Handle no user
    func checkForUser() {
        if User.currentUser() == nil {
            performSegueWithIdentifier(kSegueLobbyToRegister, sender: self)
        }
    }

    //Mark Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == kSegueLobbyToTimeSlots {
            let timeSlotsVC = segue.destinationViewController as! TimeSlotsViewController
            timeSlotsVC.gameKind = gameKinds![(tableView.indexPathForSelectedRow?.row)!]
        }
    }

    //MARK: Testing
    @IBAction func onTestButtonTapped(sender: UIBarButtonItem) {
    }
}

//MARK: TableView
extension LobbyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(KCellLobby) as! LobbyTableViewCell
        cell.gameKind = gameKinds![indexPath.row]
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let someGameKinds = gameKinds {
            return someGameKinds.count
        }
        return 0
    }
}
