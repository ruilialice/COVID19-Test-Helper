const mongoose = require('mongoose')

var covidtesterSchema = new mongoose.Schema({
	userName: {
		type: String,
		required: 'This field is required'
	},
	password: {
		type: String,
		required: 'This field is required'
	}
});

module.exports = mongoose.model("CovidTester", covidtesterSchema);