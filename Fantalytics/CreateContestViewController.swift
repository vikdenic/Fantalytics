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

    var isPrivate = false

//    let entryPrizeArray : [(entry: Double, prize: Double)] = [(1 , 1.80), (5 , 9),
//                                                             (10 , 18), (20 , 36),
//                                                             (50 , 90), (109 , 200),
//                                                             (270 , 500), (535 , 1000)]

    override func viewDidLoad() {
        super.viewDidLoad()

        if isPrivate == false {
            title = "Create Public H2H"
            setUpPublicForm()
        } else {
            title = "Create Private H2H"
            setUpPrivateForm()
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.translucent = false
    }

    @IBAction func onCancelTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    //Using Eureka form builder library
    func setUpPublicForm() {
        form

            +++ Section("")
            <<< PickerInlineRow<String>("PickerInlineRow") { (row : PickerInlineRow<String>) -> Void in
                row.title = "Entry Fee"
                row.options = ["$1 to win $1.80", "$2 to win $3.60", "$5 to win $9", "$10 to win $18", "$20 to win $36", "$50 to win $90", "$109 to win $200", "$270 to win $500", "$535 to win $1,000"]
                row.value = row.options[0]
                }.onChange {row in
                    print("Set to: \(row.value)")
            }//.onExpandInlineRow { cell, row, inlineRow in }
    }

    func setUpPrivateForm() {

        if isPrivate == true {
            form =

                Section()
                <<< PickerInlineRow<String>("PickerInlineRow") { (row : PickerInlineRow<String>) -> Void in
                    row.title = "Entry Fee"
                    row.options = ["$1 to win $1.80", "$2 to win $3.60", "$5 to win $9", "$10 to win $18", "$20 to win $36", "$50 to win $90", "$109 to win $200", "$270 to win $500", "$535 to win $1,000"]
                    row.value = row.options[0]
                    }.onChange {row in
                        print("Set to: \(row.value)")
                    }//.onExpandInlineRow { cell, row, inlineRow in }

                +++ Section("")

                <<< LabelRow () {
                    $0.title = "Invites"
                    $0.value = ">"
                    }
                    .onCellSelection { cell, row in
                        print("Invites row tapped")
                }

                +++ Section("")

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
}
