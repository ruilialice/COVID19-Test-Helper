const express = require("express")
const mongoose = require('mongoose')
const CovidTester = require('./models/CovidTester.model')
const CovidPlace = require('./models/CovidPlace.model')

var app = express();
app.use(express.json())

function ComputeDistance(cur_log, cur_lat, log1, lat1) { 
        const R = 6371e3; // metres
        const φ1 = lat1 * Math.PI/180; // φ, λ in radians
        const φ2 = cur_lat * Math.PI/180;
        const Δφ = (cur_lat-lat1) * Math.PI/180;
        const Δλ = (cur_log-log1) * Math.PI/180;

        const a = Math.sin(Δφ/2) * Math.sin(Δφ/2) +
          Math.cos(φ1) * Math.cos(φ2) *
          Math.sin(Δλ/2) * Math.sin(Δλ/2);
        const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

        const d = R * c; // in metres
        return d;
}

app.get("/", (req, res) => {
        res.send("Welcome to CovidTest Database!");
});

app.post("/create_tester", async (req, res) => {
        try{
                const myuser = new CovidTester(req.body);
                await myuser.save()
                res.send(myuser);
                console.log('create tester');
        } catch (err) {
                res.send({ message: err });
        }
        // console.log(req.body.userName);
        // res.send(`Created your user ${req.body.userName}`);
})

app.post("/validate_tester", async (req, res) => {
        CovidTester.find({userName: req.body.userName, password: req.body.password}, function(err, result) {
                if (err) {
                        res.send({ message: err });
                } 
                else {
                        var temp = result[0];
                        if (temp) {
                                res.send({message: "correct" });
                                console.log('validate tester');
                        }
                        else {
                                res.send({message: "wrong" });
                                console.log('cannot validate tester');
                        }

                }
        })
})

app.post("/create_place", async (req, res) => {
        try{
                const myplace = new CovidPlace(req.body);
                await myplace.save()
                res.send(myplace);
                console.log('create place');
        } catch (err) {
                res.send({ message: err });
        }
})

function sortWithIndeces(distanceArray, idArray) {
  for (var i = 0; i < distanceArray.length; i++) {
    distanceArray[i] = [distanceArray[i], idArray[i]];
  }
  distanceArray.sort(function(left, right) {
    return left[0] < right[0] ? -1 : 1;
  });
  distanceArray.sortIndices = [];
  for (var j = 0; j < distanceArray.length; j++) {
    distanceArray.sortIndices.push(distanceArray[j][1]);
    distanceArray[j] = distanceArray[j][0];
  }
  return distanceArray;
}


app.post("/search_pos", async (req, res) => {
        cur_log = parseFloat(req.body.longitude); 
        cur_lat = parseFloat(req.body.latitude);
        console.log(cur_log);
        console.log(cur_lat);
        var idArray = []
        var distanceArray = []

        CovidPlace.find({}, (err, places) => {
                places.forEach((place) => {
                        log1 = parseFloat(place.coordinates.longitude);
                        lat1 = parseFloat(place.coordinates.latitude);
                        temp_dis = ComputeDistance(cur_log, cur_lat, log1, lat1);
                        // console.log(temp_dis);
                        idArray.push(place._id);
                        distanceArray.push(temp_dis);
                });

                // console.log(idArray);
                // console.log(distanceArray);

                sortWithIndeces(distanceArray, idArray);
                // console.log(distanceArray.sortIndices)

                CovidPlace.find({_id: { "$in": distanceArray.sortIndices.slice(0,4) }}, function(err, result) {
                    if (err) {
                            res.send({ message: err });
                    } 
                    else {
                            var temp = result;
                            if (temp) {
                                    res.send(temp);
                                    console.log(temp);
                            }
                            else {
                                    res.send({message: "wrong" });
                                    console.log('cannot find nearest place');
                            }

                    }
                })

        });

})

mongoose.connect('mongodb://localhost:27017/CovidTesterDB', {
        useNewUrlParser: true
},
err => {
        if (!err) {
                console.log('Connection succeeded')
        } 
        else {
                console.log('Error in connection' + err)
        }
})

app.listen(3000, ()=>{
        console.log("server started at port 3000");
});