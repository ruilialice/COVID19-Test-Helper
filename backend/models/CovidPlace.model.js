const mongoose = require('mongoose')


var covidplaceSchema = new mongoose.Schema({
	name: {
		type: String,
		required: 'This field is required'
	},
	category: {
		type: String,
		required: 'This field is required'
	},
	city: {
		type: String,
		required: 'This field is required'
	},
	state: {
		type: String,
		required: 'This field is required'
	},
	id: {
		type: Number,
		required: 'This field is required'
	},
	phone: {
		type: String,
		required: 'This field is required'
	},
	coordinates: {
		longitude: {
			type: String,
			required: 'This field is required'
		},
		latitude: {
			type: String,
			required: 'This field is required'
		}
	},
	address: {
		type: String,
		required: 'This field is required'
	},
	hours: {
		type: String,
		required: 'This field is required'
	},
	rating: {
		type: String,
		required: 'This field is required'
	},
	num_view: {
		type: Number,
		required: 'This field is required'
	}
});

module.exports = mongoose.model("CovidPlace", covidplaceSchema);