
var express = require('express');
var exphbs = require('express-handlebars');
var mysql = require('mysql');
var myConnection = require('express-myconnection');
var bodyParser = require('body-parser');
var rankService = require('./dataServices/rankService');
var rank = require('./routes/ranks');
var connectionProvider = require('./routes/connectionProvider');

var app = express();

var dbOptions = {
	host: 'localhost',
	user: 'freakils',
	password: 'fish04',
	port: 3306,
	database: 'getmethere',
};

var serviceSetupCallback = function(connection){
	return {
		rankService : new rankService(connection)

	}
};

var myConnectionProvider = new connectionProvider(dbOptions, serviceSetupCallback);
app.use(myConnectionProvider.setupProvider);
app.use(myConnection(mysql, dbOptions, 'pool'));

app.use(express.static(__dirname + '/public'));

app.use(myConnection(mysql, dbOptions, 'single'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.engine('handlebars', exphbs({defaultLayout: 'main',layoutsDir:__dirname+'/views/layouts'}));
app.set('view engine', 'handlebars');
app.set('views', __dirname+'/views');

var taxiRanks = new rank();
app.get('/',taxiRanks.getCurrentLocation );
app.get('/whereami',taxiRanks.findNear)
app.post('/location',taxiRanks.receiveLocation)
app.post('/location/searched',taxiRanks.receivedSearch)
app.get('/simulation',taxiRanks.runSimulation)
app.post('/simulation',taxiRanks.simulate)
app.post('/search',taxiRanks.search)


module.exports = app;
