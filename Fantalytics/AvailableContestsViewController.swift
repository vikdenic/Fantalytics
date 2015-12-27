//
//  AvailableContestsViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/26/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

class AvailableContestsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AvailableContestsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellAvailableContest) as! AvailableContestTableViewCell

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}