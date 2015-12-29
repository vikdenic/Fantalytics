
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
// Parse.Cloud.define("hello", function(request, response) {
//   response.success("Hello friend!");
// });

var proBballKey = "h8Eb1BCDqRgVU3ZcLvTIl5NzM9FnSQif";
var gameURL = "http://api.probasketballapi.com/game";

Parse.Cloud.define("createGames", function(request, response) {
		
	var Game = Parse.Object.extend("Game");
	var TimeSlot = Parse.Object.extend("TimeSlot");

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
	
		json.forEach(function(game) {
			var dateString = game["date"];
			dateString = dateString.slice(0, -9);
			
			if (dateString == tomorrowsDateString()) {
				var newGame = new Game();
				newGame.set("date", dateFromAPIString(game["date"]));
				saveGame(newGame);
			}
		 });
		 
		// response.success(httpResponse.text);
    }, 
    function (error) {
        console.error('Console Log response: ' + error.text);
        response.error('Request failed with response ' + error.text);
    });
});

Parse.Cloud.define("createTimeSlots", function(request, response) {
	var TimeSlot = Parse.Object.extend("TimeSlot");
	
	var now = new Date();
	//Get all the upcoming games
    var query = new Parse.Query("Game");
    query.greaterThan("date", now);

    query.find({
    	success: function(results) {
    		console.log("Successfully retrieved " + results.length + " games.");

			var slots = [];
			var previousTime = null;

	  	    for (var i = 0; i < results.length; i++) {
				var date = results[i].get("date");
				
				//Always create TimeSlot with date of first game
				if (i == 0) {
					previousTime = date;
					var timeSlot = new TimeSlot();
					timeSlot.set("startDate", date);
					slots.push(timeSlot);
					saveTimeSlot(timeSlot);
				} else {
					//If date is at least 1 hour later then previously saved TimeSlot, create TimeSlot with it
					var difference = Math.abs(date - previousTime) / 36e5;
					var gamesLeft = results.length - i;
										
					if (difference >= 1.0 && gamesLeft >= 3) {
						previousTime = date;
						var timeSlot = new TimeSlot();
						timeSlot.set("startDate", date);
						slots.push(timeSlot);
						saveTimeSlot(timeSlot);
					}
				}
   			}
	    },
	  	error: function(error) {
	  		alert("Error: " + error.code + " " + error.message);
	    }
	});
});

//MARK: Helpers
function saveTimeSlot(timeSlot) {
	timeSlot.save(null, { 
	  success: function(timeSlot) {
	    // Execute any logic that should take place after the object is saved.
	    alert('New TimeSlot object created with objectId: ' + timeSlot.id);
	  },
	  error: function(timeSlot, error) {
	    // Execute any logic that should take place if the save fails.
	    // error is a Parse.Error with an error code and message.
	    alert('Failed to create new object, with error code: ' + error.message);
	  }
	});
}

function saveGame(game) {
	game.save(null, { 
	  success: function(game) {
	    // Execute any logic that should take place after the object is saved.
	    alert('New Game object created with objectId: ' + game.id);
	  },
	  error: function(game, error) {
	    // Execute any logic that should take place if the save fails.
	    // error is a Parse.Error with an error code and message.
	    alert('Failed to create new object, with error code: ' + error.message);
	  }
	});
}

// Returns a String of today's date (i.e. 12/02/2015) 
// to be used for comparison with the dates of Games from the ProBball API
function todaysDateString() {
	var date = new Date();
	date.setHours(date.getHours() - 5);
	
	var day = date.getDate();
	var month = date.getMonth() + 1;
	var year = date.getFullYear();

	var dateString = year + "-" + month + "-" + day;
	return dateString;
}

// Returns a String of tomorrow's date (i.e. 12/02/2015) 
// to be used for comparison with the dates of Games from the ProBball API
function tomorrowsDateString() {
	var date = new Date(new Date().getTime() + 24 * 60 * 60 * 1000);
	date.setHours(date.getHours() - 5);
	
	var day = date.getDate();
	var month = date.getMonth() + 1;
	var year = date.getFullYear();

	var dateString = year + "-" + month + "-" + day;
	return dateString;
}

// Creates a date object from Strings retrieved from the ProBball API
// this method assumes the string is formatted like so: "2015-12-28 22:00:00" 
function dateFromAPIString(str) {	
	var yearStr = str.substr(0, 4);
	var monthStr = str.substr(5, 2);
	var dayStr = str.substr(8, 2);
	var date = new Date(yearStr,monthStr,dayStr);

	var hourStr = str.substr(11, 2);
	var minuteStr = str.substr(14, 2);
	date.setHours(+hourStr);
	date.setMinutes(+minuteStr);

	date.setMonth(date.getMonth() - 1);
	date.setHours(date.getHours() + 5); //to GMT
	
	return date;
}