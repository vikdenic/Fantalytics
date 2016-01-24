
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
    }, 
    function (error) {
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
	    },
	  	error: function(error) {
	  		alert("Error: " + error.code + " " + error.message);
	    }
	}).then(function() {
    // Set the job's success status
    status.success("TimeSlots completed successfully.");
    }, function(error) {
    // Set the job's error status
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

//MARK: Set pointer to Team on saved Player object based on player's teamId
//TODO possible infinite loop here
Parse.Cloud.afterSave("Player", function(request) { 
	
	var player = request.object;
	
    var Team = Parse.Object.extend("Team");
    query = new Parse.Query("Team");
    query.equalTo("teamId", player.get("teamId"));
  
	query.find({
	    success: function(results) {
			
			player.set("team", results[0]);
			savePlayer(player);
	    },
	    error: function() {
	      console.log("Team query failed");
	    }
    });
});

//MARK: Set pointer to Team on saved Player object based on player's teamId
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

//MARK: Set a contest as isFilled when filled up
//MARK: Update Contest object when filled
Parse.Cloud.afterSave("Entry", function(request, response) {
    request.object.get("contest").fetch().then(function(contest){
		console.log("entries count is: " + contest.get("entriesCount"));
		console.log("max entries is: " + contest.get("maxEntries"));
	
		//check if entriesCount is less than maxEntries
		contest.set("entriesCount", contest.get("entriesCount") + 1);
			
		if (contest.get("entriesCount") == contest.get("maxEntries")) {
			contest.set("isFilled", true);
		}
		
		saveContest(contest);
    });
});

//MARK: Prevent contest from over-filling
Parse.Cloud.beforeSave("Entry", function(request, response) {
	var theContest = request.object.get("contest");
    theContest.fetch().then(function(contest){
  	  if (contest.get("isFilled") == true) {
  	      response.error('This contest is full.');
  	  } else {
	  	  contest.get("timeSlot").fetch().then(function(timeSlot){
			  var now = new Date();
		 	  if (timeSlot.get("startDate") < now) {
			  	response.error('This contest has already started.');
			  } else {
			      response.success();
			  }
		  });
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

//Email
Parse.Cloud.define("sendMail", function(request, response) {
var Mandrill = require('mandrill');
Mandrill.initialize('1LqrcTEglA_6Jpwx7nPCOw');

Mandrill.sendEmail({
	message: {
		text: "it worked",
		subject: "vwalla",
		from_email: "vik@fantalytics.co",
		from_name: "Fantalytics",
		to: [{ email: "vik.denic@gmail.com",
			   name: "Vik"
			}]
	},
	async: true
	},{ 
		success: function(httpResponse) {
			console.log(httpResponse);
			response.success("Email sent!");
		},
		error: function(httpResponse) {
			console.error(httpResponse);
			response.error("Uh oh, something went wrong");
		}
	});
});