var RanksDataService = require('../dataServices/rankServicePromise');
var assert = require("assert");
var mysql = require("mysql");
var Promise = require("bluebird");

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : process.env.MYSQL_USER || 'root',
  password : "",
  database : 'test'
});

var rankService = new RanksDataService(connection);

describe('Rank Data Service', function(){

      it('should get all ranks', function (done) {
          rankService
            .getAllRanks()
            .done(function(ranks){
                assert.equal(3, ranks.length);
                done();
            });
      });

      it('should get all routes offered by specified rank', function (done) {
          rankService
            .getRoutes(2)
            .done(function(routes){
                assert.equal(2, routes.length);
                done();
            });
      });
      it('should get rank info', function (done) {
          rankService
            .getInfo(2)
            .done(function(rank){

                var bellville = {
                  rank_id:2,
                  name :'Bellville',
                  type:'official',
                  latitude:-33.9044802,
                  longitude:18.6081095
                }
                
                assert.deepEqual(bellville,rank[0]);
                done();
            });
      });

})
