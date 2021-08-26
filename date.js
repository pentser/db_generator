function randomDate(start, end) {
    return new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
}

function generateDeartureAndLandingTime() {

// generate hours flight time
let hour=Math.floor((Math.random() * 15) + 1);


let today=new Date();
let departure_time=randomDate(new Date(2021, 0, 1),today);
let Original_departur_time=new Date(departure_time);
let landing_time=new Date(departure_time.setHours(departure_time.getHours()+hour));
return {
    departure_time:Original_departur_time,
    landing_time
};

}

module.exports=generateDeartureAndLandingTime;


/*let now = new Date(); // Fri Feb 20 2015 19:29:31 GMT+0530 (India Standard Time) 
let UTCDate = new Date(now.getTime() - now.getTimezoneOffset() * 60000).toUTCString();
//OUTPUT 2021-08-25 20:23:00.000000*/
















