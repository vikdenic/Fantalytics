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
let playersURL = "http://api.probasketballapi.com/player"
let playersAdvancedURL = "http://api.probasketballapi.com/advanced/player"
let boxscoreURL = "http://api.probasketballapi.com/boxscore/team"
let shotchartsURL = "http://api.probasketballapi.com/shots"

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

    class func getAllPlayers(completion : (players : JSON) -> Void) {

        let parameters = ["api_key" : kProBballAPIKey]

        Alamofire.request(.POST, playersURL, parameters: parameters)
            .responseJSON { response in

                guard let jsonObject = response.result.value else {
                    print("response: \(response)")
                    completion(players: nil)
                    return
                }

//                print("json: \(JSON(jsonObject))")
                let json = JSON(jsonObject)
                completion(players: json)
        }
    }

    class func getAllAdvancedPlayers(completion : (players : JSON) -> Void) {

        let parameters = ["api_key" : kProBballAPIKey]

        Alamofire.request(.POST, playersAdvancedURL, parameters: parameters)
            .responseJSON { response in

                guard let jsonObject = response.result.value else {
                    print("response: \(response)")
                    completion(players: nil)
                    return
                }

                print("json: \(JSON(jsonObject))")
                let json = JSON(jsonObject)
                completion(players: json)
        }
    }

    class func getPlayersForTeam(team : NBATeam, completion : (teams : JSON) -> Void) {
        ProBballManager.getAllPlayers { (players) -> Void in
            for player in players.array! where player["team_id"].stringValue == String(team.teamId) {
                print(player)
            }
        }
    }

    class func getBoxScore(completion : (players : JSON) -> Void) {

        let parameters = ["api_key" : kProBballAPIKey]

        Alamofire.request(.POST, boxscoreURL, parameters: parameters)
            .responseJSON { response in

                guard let jsonObject = response.result.value else {
                    print("response: \(response)")
                    completion(players: nil)
                    return
                }

                print("json: \(JSON(jsonObject))")
                let json = JSON(jsonObject)
                completion(players: json)
        }
    }

    class func getShotCharts(completion : (shots : JSON) -> Void) {

        let parameters = ["api_key" : kProBballAPIKey]

        Alamofire.request(.POST, shotchartsURL, parameters: parameters)
            .responseJSON { response in

                guard let jsonObject = response.result.value else {
                    print("response: \(response)")
                    completion(shots: nil)
                    return
                }

                print("json: \(JSON(jsonObject))")
                let json = JSON(jsonObject)
                completion(shots: json)
        }
    }
}

enum NBATeam {
    case All
    case Atlanta
    case Boston
    case Brooklyn
    case Charlotte
    case Chicago
    case Cleveland
    case Dallas
    case Denver
    case Detroit
    case GoldenState
    case Houston
    case Indiana
    case LAClippers
    case LALakers
    case Memphis
    case Miami
    case Milwaukee
    case Minnesota
    case NewOrleans
    case NewYork
    case OklahomaCity
    case Orlando
    case Philadelphia
    case Phoenix
    case Portland
    case Sacramento
    case SanAntonio
    case Toronto
    case Utah
    case Washington

    var teamId : Int {
        switch self {
        case .Atlanta: return 1610612737;
        case .Boston: return 1610612738;
        case .Brooklyn: return 1610612751;
        case .Charlotte: return 1610612766;
        case .Chicago: return 1610612741;
        case .Cleveland: return 1610612739;
        case .Dallas: return 1610612742;
        case .Denver: return 1610612743;
        case .Detroit: return 1610612765;
        case .GoldenState: return 1610612744;
        case .Houston: return 1610612745;
        case .Indiana: return 1610612754;
        case .LAClippers: return 1610612746;
        case .LALakers: return 1610612747;
        case .Memphis: return 1610612763;
        case .Miami: return 1610612748;
        case .Milwaukee: return 1610612749;
        case .Minnesota: return 1610612750;
        case .NewOrleans: return 1610612740;
        case .NewYork: return 1610612752;
        case .OklahomaCity: return 1610612760;
        case .Orlando: return 1610612753;
        case .Philadelphia: return 1610612755;
        case .Phoenix: return 1610612756;
        case .Portland: return 1610612757;
        case .Sacramento: return 1610612758;
        case .SanAntonio: return 1610612759;
        case .Toronto: return 1610612761;
        case .Utah: return 1610612762;
        case .Washington: return 1610612764;
        default:
            return 1610612744
        }
    }
}
