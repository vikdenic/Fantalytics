
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
// Parse.Cloud.define("hello", function(request, response) {
//   response.success("Hello friend!");
// });

var proBballKey = "h8Eb1BCDqRgVU3ZcLvTIl5NzM9FnSQif";
var gameURL = "http://api.probasketballapi.com/game";

Parse.Cloud.define("test", function(request, response) {
		
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
			
			if (dateString == todaysDateString()) {
				//Create TimeSlot with earliest game
				var timeSlot = new TimeSlot();
	      		timeSlot.set("startTime", dateFromString(game["date"]));
				
				//TODO Create multiple TimeSlots
	  			timeSlot.save(null, { 
	  			  success: function(timeSlot) {
	  			    // Execute any logic that should take place after the object is saved.
	  			    alert('New TimeSlot object created with objectId: ' + timeSlot.id);
	  			  },
	  			  error: function(coupon, error) {
	  			    // Execute any logic that should take place if the save fails.
	  			    // error is a Parse.Error with an error code and message.
	  			    alert('Failed to create new object, with error code: ' + error.message);
	  			  }
	  			});
			}
		 });
		 
		// response.success(httpResponse.text);
    }, 
    function (error) {
        console.error('Console Log response: ' + error.text);
        response.error('Request failed with response ' + error.text)
    });
});

function todaysDateString() {
	var date = new Date();
	date.setHours(date.getHours() - 5);
	
	var day = date.getDate();
	var month = date.getMonth() + 1;
	var year = date.getFullYear();

	var dateString = year + "-" + month + "-" + day;
	return dateString;
}

function dateFromString(str) {	
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