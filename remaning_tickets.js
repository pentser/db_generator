const config=require('config');
//global variables from config files
const scale = config.get('scale')

const num_of_airlines=scale.airlines;
const num_of_tickets_per_airline=scale.tickets_per_airline;



let ar_tickets=new Array(num_of_airlines);

for(i=0;i<num_of_airlines;i++)
   ar_tickets.push(num_of_tickets_per_airline)

console.log(ar_tickets)

module.exports=ar_tickets;



