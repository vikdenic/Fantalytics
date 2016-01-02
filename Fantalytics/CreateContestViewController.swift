//
//  CreateContestViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 1/1/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit
import Eureka

class CreateContestViewController: FormViewController {

    var availableContestsVC : AvailableContestsViewController!
    var isPrivate = false

//    let entryPrizeArray : [(entry: Double, prize: Double)] = [(1 , 1.80), (5 , 9),
//                                                             (10 , 18), (20 , 36),
//                                                             (50 , 90), (109 , 200),
//                                                             (270 , 500), (535 , 1000)]

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpForm()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.translucent = false
    }

    @IBAction func onDoneTapped(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Create Contest?", message: nil, preferredStyle: .Alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)

        let okayAction = UIAlertAction(title: "Create", style: .Default) { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                self.availableContestsVC.performSegueWithIdentifier(kSegueAvailableContestsToSelectLineup, sender: self.availableContestsVC)
            })
        }

        alert.addAction(okayAction)
        alert.addAction(cancelAction)

        presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func onCancelTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    //Using Eureka form builder library
    func setUpForm() {
            form =

                Section("")
                <<< SegmentedRow<String>("segments"){
                    $0.options = ["Public", "Private"]
                    $0.value = "Public"
                }.onChange({ (segmentedRow) -> () in
                    if segmentedRow.value == "Public" {

                    } else {

                    }
                })

                <<< PickerInlineRow<String>("PickerInlineRow") { (row : PickerInlineRow<String>) -> Void in
                    row.title = "Entry Fee"
                    row.options = ["$1 to win $1.80", "$2 to win $3.60", "$5 to win $9", "$10 to win $18", "$20 to win $36", "$50 to win $90", "$109 to win $200", "$270 to win $500", "$535 to win $1,000"]
                    row.value = row.options[0]
                    }.onChange {row in
                        print("Set to: \(row.value)")
                    }//.onExpandInlineRow { cell, row, inlineRow in }

                +++ Section(footer: "Automatically find an opponent if nobody accepts your challenge") {
                    $0.hidden = .Function(["segments"], { form -> Bool in
                        let row: RowOf<String>! = form.rowByTag("segments")

                        if row.value! == "Public" {
                            return true
                        } else {
                            return false
                        }
                    })
                }

                <<< LabelRow () {
                    $0.title = "Invites"
                    $0.value = ">"
                    }
                    .onCellSelection { cell, row in
                        print("Invites row tapped")
                }

                <<< SwitchRow() {
                    $0.title = "Find Opponent"
                    $0.value = true
                    }.onChange {
                        if $0.value == true {
                            print("switch on")
                        }
                        else {
                            print("switch off")
                        }
                }
        }
}
