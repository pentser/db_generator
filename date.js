function randomDate(start, end) {
    return new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
}


let today=new Date();
let departure_time=randomDate(new Date(2021, 0, 1),today);
let landing_time=departure_time.getHours()+ 4.3;
console.log(Date(landing_time));



