var geolib = require("geolib");
module.exports = function() {
    this.currentLocation = {};
    this.destinationLocation = {};
    var self = this;

    this.findNear = function(req, res, next) {
        var locationData = false;
        if (req.body.latitude && req.body.longitude) {
            self.currentLocation = {
                latitude: req.body.latitude,
                longitude: req.body.longitude
            };
            locationData = true;
        };

        req.services(function(err, services) {
            if (Object.keys(self.currentLocation).length == 0) {
                res.redirect('/')
            } else {
                var rankService = services.rankService
                var location = req.body;
                rankService.getAllRanks(function(err, ranks) {
                    var sortedRanks = geolib.orderByDistance(self.currentLocation, ranks)
                    var rankInfo = [];
                    sortedRanks.forEach(function(rank) {
                        ranks.forEach(function(rawRank) {
                            if (rank.key == ranks.indexOf(rawRank)) {
                                rankInfo.push(rawRank)
                            }
                        })
                    })
                    rankInfo.forEach(function(rank) {
                        rankService.getRoutes(rank.rank_id, function(err, routes) {
                            rank["routes"] = routes;
                        });
                    });



                    if (!locationData)
                        if (Object.keys(self.destinationLocation).length != 0) {
                            res.render('index', {
                                ranks: rankInfo.slice(0, 5),
                                currentLocation: self.currentLocation,
                                destinationLocation: self.destinationLocation
                            })
                        } else {
                            res.render('index', {
                                ranks: rankInfo.slice(0, 5),
                                currentLocation: self.currentLocation
                            })
                        }

                    else
                        res.render('locationData', {
                            ranks: rankInfo.slice(0, 4)
                        })
                })
            }

        })
    }

    this.getCurrentLocation = function(req, res, next) {
        res.render('location')
    }
    this.receiveLocation = function(req, res, next) {
        var location = req.body;
        self.currentLocation = location;
        res.redirect('/whereami')
    }
    this.receivedSearch = function(req, res, next) {
        var location = req.body;

        self.destinationLocation = location;
        res.redirect('/whereami')
    }
    this.runSimulation = function(req, res, next) {
        res.render('simlation')
    }

    this.simulate = function(req, res, next) {
        var location = req.body;
        self.currentLocation = location;
        res.redirect('/whereami')
    }

    this.search = function(req, res, next) {
        req.services(function(err, services) {
            var rankService = services.rankService
            var location = req.body;
            rankService.findRank(location.find, function(err, results) {
                if (err) console.log(err)
                res.send(results);
            })
        })

    }
}
