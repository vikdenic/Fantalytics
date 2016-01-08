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
    var findsOpponent = true

    var timeSlot : TimeSlot!
    var gameKind : GameKind!
    var contestKind : ContestKind!

    var entryFee = 1 as NSNumber!
    var prizeAmount = 1.8 as NSNumber!

    let entryPrizeArray : [(entry: Double, prize: Double)] = [(1 , 1.80), (2, 3.6), (5 , 9),
                                                             (10 , 18), (20 , 36), (50 , 90),
                                                             (109 , 200), (270 , 500), (535 , 1000)]

    let rowOptions = ["$1 to win $1.80", "$2 to win $3.60", "$5 to win $9", "$10 to win $18", "$20 to win $36", "$50 to win $90", "$109 to win $200", "$270 to win $500", "$535 to win $1,000"]

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

            let contest = Contest(creator: User.currentUser()!, gameKind: self.gameKind, contestKind: self.contestKind, timeSlot: self.timeSlot, entryFee: self.entryFee, prizeAmount: self.prizeAmount, isPrivate: self.isPrivate, findsOpponent: self.findsOpponent, invites: nil)

            if contest.isPrivate == false {
                contest.findsOpponent = false
            }

            contest.saveInBackgroundWithBlock({ (object, error) -> Void in
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    self.availableContestsVC.performSegueWithIdentifier(kSegueAvailableContestsToSelectLineup, sender: self.availableContestsVC)
                })
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
                        self.isPrivate = false
                    } else {
                        self.isPrivate = true
                    }
                })

                <<< PickerInlineRow<String>("PickerInlineRow") { (row : PickerInlineRow<String>) -> Void in
                    row.title = "Entry Fee"
                    row.options = self.rowOptions
                    row.value = row.options[0]
                    }.onChange {row in
                        self.setEntryAndPrize(row.value!)
                    }.onExpandInlineRow { cell, row, inlineRow in
                        print("z")
                    }.onCollapseInlineRow({ (cell, row, inlinerow) -> () in
                        
                    })

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
                            self.findsOpponent = true
                            print("switch on")
                        }
                        else {
                            self.findsOpponent = false
                            print("switch off")
                        }
                }
        }

    func setEntryAndPrize(string : String) {
        switch string {
        case rowOptions[0]:
            self.entryFee = entryPrizeArray[0].entry
            self.prizeAmount = entryPrizeArray[0].prize
        case rowOptions[1]:
            self.entryFee = entryPrizeArray[1].entry
            self.prizeAmount = entryPrizeArray[1].prize
        case rowOptions[2]:
            self.entryFee = entryPrizeArray[2].entry
            self.prizeAmount = entryPrizeArray[2].prize
        case rowOptions[3]:
            self.entryFee = entryPrizeArray[3].entry
            self.prizeAmount = entryPrizeArray[3].prize
        case rowOptions[4]:
            self.entryFee = entryPrizeArray[4].entry
            self.prizeAmount = entryPrizeArray[4].prize
        case rowOptions[5]:
            self.entryFee = entryPrizeArray[5].entry
            self.prizeAmount = entryPrizeArray[5].prize
        case rowOptions[6]:
            self.entryFee = entryPrizeArray[6].entry
            self.prizeAmount = entryPrizeArray[6].prize
        case rowOptions[7]:
            self.entryFee = entryPrizeArray[7].entry
            self.prizeAmount = entryPrizeArray[7].prize
        case rowOptions[8]:
            self.entryFee = entryPrizeArray[8].entry
            self.prizeAmount = entryPrizeArray[8].prize
        default: return
        }
    }
}
