//
//  ProBballManager.swift
//  Fantalytics
//
//  Created by Vik Denic on 11/21/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let teamURL = "http://api.probasketballapi.com/team"

class ProBballManager {

    class func getAllTeams(completion : (teams : JSON) -> Void) {

        let parameters = ["api_key" : kProBballAPIKey]

        Alamofire.request(.POST, teamURL, parameters: parameters)
            .responseJSON { response in

                guard let jsonObject = response.result.value else {
                    print("response: \(response)")
                    completion(teams: nil)
                    return
                }

                print("json: \(JSON(jsonObject))")
                let json = JSON(jsonObject)
                completion(teams: json)
        }
    }
}
