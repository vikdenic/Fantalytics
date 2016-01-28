
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
// Parse.Cloud.define("hello", function(request, response) {
//   response.success("Hello friend!");
// });

var proBballKey = "h8Eb1BCDqRgVU3ZcLvTIl5NzM9FnSQif";
var gameURL = "http://api.probasketballapi.com/game";
var playerURL = "http://api.probasketballapi.com/player"
var teamURL = "http://api.probasketballapi.com/team"

//MARK: Jobs
Parse.Cloud.job("gameCreation", function(request, status) {
	var Game = Parse.Object.extend("Game");

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
		
		var gameCount = 0;
		json.forEach(function(game) {			
			var dateString = game["date"];
			dateString = dateString.slice(0, -9);
			
			if (dateString == tomorrowsDateString()) {			
				var newGame = new Game();
				newGame.set("date", dateFromAPIString(game["date"]));
				newGame.set("homeId", game["home_id"]);
				newGame.set("awayId", game["away_id"]);
				saveGame(newGame);
				gameCount++;
			}
		 });
		console.log("saved " + gameCount + "game objects")
 	    status.success("Games completed successfully.");		
    }, 
    function (error) {
		sendCrashEmail(error);
        console.error('Console Log response: ' + error.text);
	    status.error("Error creating games.");
    })
});

Parse.Cloud.job("slotCreation", function(request, status) {
	var TimeSlot = Parse.Object.extend("TimeSlot");
	var tomorrow = new Date(new Date().getTime() + 24 * 60 * 60 * 1000);
	
	//Get all the upcoming games
    var query = new Parse.Query("Game");
    query.greaterThan("date", tomorrow);
	
	query.find().then(function(results) {
		
		var slots = [];
		var previousTime = null;
		
  	    for (var i = 0; i < results.length; i++) {
			var date = results[i].get("date");
			
			//Always create TimeSlot with date of first game
			if (i == 0) {
				previousTime = date;
				var timeSlot = new TimeSlot();
				timeSlot.set("startDate", date);
				timeSlot.set("isFirst", true);
				
				slots.push(timeSlot);
				saveTimeSlot(timeSlot);
			} else {
				// If date is at least 1 hour later then previously saved TimeSlot
				// AND there are at least 3 games remaining from that time, creat TimeSlot with it
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
		return results;
	}).then(function(result) {
	    status.success("TimeSlots completed successfully.");		
	}, function(error) {
		sendCrashEmail(error);
	    status.error("Uh oh, something went wrong.");
	});
});

Parse.Cloud.job("playerCreation", function(request, status) {
	
	var Player = Parse.Object.extend("Player");
	var query = new Parse.Query(Player);
	query.limit(1000);
	query.find({
	  success: function(parsePlayers) {
	    alert("Successfully retrieved " + parsePlayers.length + " players.");

	    var params = {
	      "api_key":proBballKey,
		   "season":"2015"
	    }

	    return Parse.Cloud.httpRequest({
	      method: 'POST',
	      url: playerURL,
	      headers: {
	        'Content-Type': 'application/json;charset=utf-8'
	      },
	      body: params
	    }).then(function(httpResponse) {
			var json = JSON.parse(httpResponse.text);
		
			var updatedTeamCount = 0;
			var updatedPositionCount = 0;
			var newPlayerCount = 0;
			
	  	    for (var i = 0; i < json.count; i++) {
				var apiPlayer = json[i];
				var isNew = true;

				parsePlayers.forEach(function(parsePlayer) {

					if (apiPlayer["id"] == parsePlayer.get("playerId")) {
						console.log("prevented duplicate Player for " + apiPlayer["player_name"]);
						isNew = false;

						if (apiPlayer["team_id"] != parsePlayer.get("teamId")) {
							parsePlayer.set("teamId", apiPlayer["team_id"]);

							savePlayer(parsePlayer);
							updatedTeamCount++;
							console.log("updated team for " + apiPlayer["player_name"]);
						}

						// if (apiPlayer["dk_position"] != parsePlayer.get("position")) {
						//
						// 			 				parsePlayer.set("position", apiPlayer["dk_position"]);
						//
						// 	savePlayer(parsePlayer);
						// 	updatedPositionCount++;
						// 	console.log("updated position for " + apiPlayer["player_name"]);
						// }
					}
				 });

				 if (isNew == true) {
	 				var newPlayer = new Player();
	 				newPlayer.set("playerId", apiPlayer["id"]);
	 				newPlayer.set("firstName", apiPlayer["first_name"]);
	 				newPlayer.set("lastName", apiPlayer["last_name"]);

					if (apiPlayer["dk_position"] == "") {
						//TODO Send myself a push or email
						newPlayer.set("position", apiPlayer["position"]);
					} else {
		 				newPlayer.set("position", apiPlayer["dk_position"]);
					}

	 				newPlayer.set("teamId", apiPlayer["team_id"]);

	 				savePlayer(newPlayer);
	 				newPlayerCount++;
					console.log("created new Player: " + apiPlayer["player_name"]);
				 }
	  	    }
			 console.log("updated team for " + updatedTeamCount + " players.")
			 // console.log("updated position for " + updatedPositionCount +  " players.")
			 console.log("created " + newPlayerCount + " new players")
	    }, 
	    function (error) {
			//TODO Send myself a push or email
	        console.error('Console Log response: ' + error.text);
		    status.error("Error updating / creating players.");
	    })

	  },
	  error: function(error) {
	    alert("Error: " + error.code + " " + error.message);
	  }
	});
});

Parse.Cloud.job("teamCreation", function(request, status) {
	var Team = Parse.Object.extend("Team");

    var params = {
      "api_key":proBballKey,
	   "season":"2015"
    }

    return Parse.Cloud.httpRequest({
      method: 'POST',
      url: teamURL,
      headers: {
        'Content-Type': 'application/json;charset=utf-8'
      },
      body: params
    }).then(function(httpResponse) {
		var json = JSON.parse(httpResponse.text);
		var teamCount = 0;
		
		json.forEach(function(apiTeam) {						
				var newTeam = new Team();
				newTeam.set("teamId", apiTeam["id"]);
				newTeam.set("teamName", apiTeam["team_name"]);
				newTeam.set("cityName", apiTeam["city"]);
				newTeam.set("abbrevName", apiTeam["abbreviation"]);
				
				saveTeam(newTeam);
				teamCount++;
		 });
		 console.log("saved " + teamCount + " team objects")
    }, 
    function (error) {
        console.error('Console Log response: ' + error.text);
	    status.error("Error creating teams.");
    })
});

//MARK: Before Saves
//Prevent contest from over-filling
Parse.Cloud.beforeSave("Entry", function(request, response) {
    var entry = request.object;
    var contest = request.object.get("contest");

    var fetchedUser, fetchedContest;
    var errorMessage;

    entry.get("user").fetch().then(function(result) {
        fetchedUser = result;
        return contest.fetch();
    }).then(function(result) {
        fetchedContest = result;
        return fetchedContest.get("timeSlot").fetch();
    }).then(function(fetchedTimeSlot) {
        // now we have all the variables we need to determine validity
        var now = new Date();
        var hasSufficientFunds = fetchedUser.get("fundsAvailable") >= fetchedContest.get("entryFee");
        var contestNotStarted = fetchedTimeSlot.get("startDate") >= now;
        if (hasSufficientFunds && contestNotStarted) {
            contest.increment("entriesCount");
            contest.increment("entriesLimit", 0); //have to do this, otherwise entriesLimit is undefined in save callback (?)
            return contest.save();
        } else {
            errorMessage = (hasSufficientFunds)? 'This contest has already started.' : 'Insufficient Funds.';
            return null;
        }
    }).then(function(result) {
        if (!result) {
            response.error(errorMessage);
        } else {
            if (contest.get("entriesCount") > contest.get("entriesLimit")) {
                response.error('The contest is full.');
            } else {
                response.success();
            }
        }
    }, function(error) {
        response.error(error);
    });
});

//Prevent contest creation if funds insufficient
Parse.Cloud.beforeSave("Contest", function(request, response) {
	var contest = request.object;
	
	contest.get("creator").fetch().then(function(creator) {
		if (creator.get("fundsAvailable") < contest.get("entryFee")) {
  		  	response.error('Insufficient funds.');
		} else {
			response.success();
		}
 	});
});

//MARK: Set up new users
Parse.Cloud.beforeSave(Parse.User, function(request, response) {
	var user = request.object;
	
	if (!user.existed()) {
		user.set("fundsAvailable", 0);
	}
	
	response.success();
});

//MARK: After saves
//Restrict contest entriesCount from exceeding max
Parse.Cloud.afterSave("Contest", function(request) {
	var contest = request.object;
    if (contest.get("entriesCount") >= contest.get("entriesLimit") && contest.get("isFull") != true) {
		contest.set("isFull", true);
		saveContest(contest);
    }
});

//Set pointer to Team on saved Player object based on player's teamId
Parse.Cloud.afterSave("Game", function(request) { 
	
	var createdAt = request.object.get("createdAt");
	var updatedAt = request.object.get("updatedAt");
	var objectExisted = (createdAt.getTime() != updatedAt.getTime());
	
	if (!objectExisted) {
		var game = request.object;
	
	    var Team = Parse.Object.extend("Team");
	    homeQuery = new Parse.Query("Team");
	    homeQuery.equalTo("teamId", game.get("homeId"));
  
		homeQuery.find({
		    success: function(results) {
				game.set("homeTeam", results[0]);
				saveGame(game);
		        console.log("Updated game with home team pointer");
		    },
		    error: function() {
		      console.log("team query failed");
		    }
	    });
	
	    awayQuery = new Parse.Query("Team");
	    awayQuery.equalTo("teamId", game.get("awayId"));
  
		awayQuery.find({
		    success: function(results) {
			
				game.set("awayTeam", results[0]);
				saveGame(game);
		        console.log("Updated game with away team pointer");
		    },
		    error: function() {
		      console.log("team query failed");
		    }
	    });
	}
});

//MARK: Save Helpers
function saveTimeSlot(timeSlot) {
	timeSlot.save(null, { 
	  success: function(timeSlot) {
	    // Execute any logic that should take place after the object is saved.
	    alert('New TimeSlot object created with objectId: ' + timeSlot.id);
	  },
	  error: function(timeSlot, error) {
	    // Execute any logic that should take place if the save fails.
	    // error is a Parse.Error with an error code and message.
	    alert('Failed to create new timeSlot object, with error code: ' + error.message);
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
	    alert('Failed to create new game object, with error code: ' + error.message);
	  }
	});
}

function savePlayer(player) {
	player.save(null, { 
	  success: function(player) {
	    // Execute any logic that should take place after the object is saved.
	    alert('New Player object created with objectId: ' + player.id);
	  },
	  error: function(player, error) {
	    // Execute any logic that should take place if the save fails.
	    // error is a Parse.Error with an error code and message.
	    alert('Failed to create new player object, with error code: ' + error.message);
	  }
	});
}

function saveTeam(team) {
	team.save(null, { 
	  success: function(team) {
	    // Execute any logic that should take place after the object is saved.
	    alert('New team object created with objectId: ' + team.id);
	  },
	  error: function(team, error) {
	    // Execute any logic that should take place if the save fails.
	    // error is a Parse.Error with an error code and message.
	    alert('Failed to create new team object, with error code: ' + error.message);
	  }
	});
}

function saveContest(contest) {
	contest.save(null, { 
	  success: function(contest) {
	    // Execute any logic that should take place after the object is saved.
	    alert('New contest object created with objectId: ' + contest.id);
	  },
	  error: function(contest, error) {
	    // Execute any logic that should take place if the save fails.
	    // error is a Parse.Error with an error code and message.
	    alert('Failed to create new contest object, with error code: ' + error.message);
	  }
	});
}

//MARK: Date Helpers
// Returns a String of today's date (i.e. 12/02/2015) 
// to be used for comparison with the dates of Games from the ProBball API
function todaysDateString() {
	var date = new Date();
	date.setHours(date.getHours() - 5);
	
	var day = date.getDate();
	var month = date.getMonth() + 1;
	var year = date.getFullYear();
	
	if (month < 10) {
		month = "0" + month
	}
	if (day < 10) {
		day = "0" + day
	}

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
	
	if (month < 10) {
		month = "0" + month
	}
	if (day < 10) {
		day = "0" + day
	}
	
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

///MARK: Email
function sendCrashEmail(error) {
	var Mandrill = require('mandrill');
	Mandrill.initialize('1LqrcTEglA_6Jpwx7nPCOw');
	
	var textDesc = "File: " + error.fileName + "/n" + "Line: " + error.lineNumber + "/n /n" + error.toSource() + "/n /n" + error.toString();

	Mandrill.sendEmail({
		message: {
			text: textDesc,
			subject: "Error discovered in Fantalytics: " + error.toString(),
			from_email: "no-reply@fantalytics.co",
			from_name: "Fantalytics",
			to: [{ email: "vik@fantalytics.co",
				   name: "Vik"
				}]
		},
		async: true
		},{ 
			success: function(httpResponse) {
				console.log(httpResponse);
				response.success("Crash email sent!");
			},
			error: function(httpResponse) {
				console.error(httpResponse);
				response.error("Uh oh, something went wrong. Crash email failed to send.");
			}
		});
}