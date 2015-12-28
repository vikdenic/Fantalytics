
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
// Parse.Cloud.define("hello", function(request, response) {
//   response.success("Hello friend!");
// });

var proBballKey = "h8Eb1BCDqRgVU3ZcLvTIl5NzM9FnSQif";
var gameURL = "http://api.probasketballapi.com/game";

Parse.Cloud.define("test", function(request, response) {

    var params = {
      "api_key":proBballKey,
	   "season":"2015"
    }

    return Parse.Cloud.httpRequest({
      method: 'POST',
      url: gameURL,
      headers: {
        'Content-Type': 'application/json;charset=utf-8'
      },
      body: params
    }).then(function(httpResponse) {
		var json = JSON.parse(httpResponse.text);
		
	 	for (var i = 0; i < json.length; i++) {
			console.log(json[i]);
		}
		
        response.success(httpResponse.text);
    }, 
    function (error) {
        console.error('Console Log response: ' + error.text);
        response.error('Request failed with response ' + error.text)
    });
});

// class func getGamesForDate(date : NSDate, completion : (games : [JSON]?) -> Void) {
//
//     let parameters = ["api_key" : kProBballAPIKey, "season" : kCurrentSeason]
//
//     Alamofire.request(.POST, gameURL, parameters: parameters)
//         .responseJSON { response in
//
//             guard let jsonObject = response.result.value else {
//                 print("response: \(response)")
//                 completion(games: nil)
//                 return
//             }
//
//             let allGamesJson = JSON(jsonObject)
//
//             var specifiedGamesArray = [JSON]()
//             for game in allGamesJson.array! where game["date"].stringValue.trimCharactersFromEnd(9) == date.toStringForAPI() {
//                 specifiedGamesArray.append(game)
//             }
//
//             if specifiedGamesArray.count == 0 {
//                 completion(games: nil)
//             } else {
//                 completion(games: specifiedGamesArray)
//             }
//     }
// }