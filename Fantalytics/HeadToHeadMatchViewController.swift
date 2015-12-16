//
//  MarathonH2HMatchViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/15/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

class HeadToHeadMatchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!

    var entry : Entry!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("entry is \(entry)")
    }

    //MARK: TV DS
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellH2HMatch) as! HeadToHeadMatchTableViewCell

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
