//
//  ViewController.swift
//  Fantalytics
//
//  Created by Vik Denic on 11/21/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let teamURL = "http://api.probasketballapi.com/team"
    let myAPIkey = "h8Eb1BCDqRgVU3ZcLvTIl5NzM9FnSQif"

    override func viewDidLoad() {
        super.viewDidLoad()

        let paramaters = ["api_key" : myAPIkey, "team_abbrv" : "BOS"]

        Alamofire.request(.POST, teamURL, parameters: paramaters)
            .responseJSON { response in

                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization

                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }
}

