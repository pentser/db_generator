const Pool = require('pg').Pool
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'flightcrm',
  password: 'admin',
  port: 5432,
});

const chalk = require('chalk');

// custom module to generate departure and landing time
const generator=require('./date');

const fs= require('fs');
// get countries data from countries files
let string_from_file = fs.readFileSync('data\\countries.json', {encoding:'utf8', flag:'r'});
data = JSON.parse(string_from_file) ;


const config=require('config');
//global variables from config files
const scale = config.get('scale')
const num_of_users=scale.users;
const num_of_airlines=scale.airlines;
const num_of_customers=scale.customers;
const num_of_flights=scale.flights;
const num_of_tickets_per_airline=scale.tickets_per_airline;
const  num_of_countries=scale.countries;

const axios = require('axios');

async function InsertDataToTables() {

    const client = await pool.connect()
     try {
  
      await client.query('BEGIN')

      for (i=0;i<data.length;i++) {

		let text1 = "SELECT * FROM sp_insert_country($1)"
	    let value1 = [data[i].name];
        console.log(chalk.green(`insert country [${i+1}] ${data[i].name} to countries table.......... `));
	    await pool.query(text1,value1);

	}

     /////////////////////////////////////////////////////////////
  /*  users table*/ 
  //"https://randomuser.me/api/?results=10&seed=abc" - users data  username,password,nam
  /////////////////////////////////////////////////////////////
  let response = await axios({
    url: `https://randomuser.me/api/?results=${num_of_users}&seed=abc`,
    method: "get",
  });

  for(i=0;i< num_of_users;i++){

    username=response.data.results[i].login.username;
    password=response.data.results[i].login.password;
    email=response.data.results[i].email;
     /*  departure_time=response.data.results[i].dob.date;
         landing_time=response.data.results[i].registered.date;
     */
     const text2 = "SELECT * FROM sp_insert_users($1,$2,$3)"
   
       const value2 = [username,password,email];
       console.log(chalk.yellow(`insert user [${i+1}] ${username} to users table.......... `));
       await pool.query(text2,value2);
  }

  
   /////////////////////////////////////////////////////////////
   /*  customers table*/ 
   //"https://randomuser.me/api/?results=10&seed=abc" - username
  /////////////////////////////////////////////////////////////
  response = await axios({
    //url: `https://randomuser.me/api/?results=${num_of_customers}&seed=abc`,
    url: `https://random-data-api.com/api/users/random_user?size=${num_of_customers}`,
    method: "get",
  });
  
  let firstName;
  let lastName;
  let address;
  let phoneNumber;
  let userId=10;
  let credit_card_no;
  

 /*  for(i=0;i< num_of_customers;i++,userId++){

    firstName=response.data.results[i].name.first;
    lastName=response.data.results[i].name.last;
    address= response.data.results[i].location.street.name + ','+ response.data.results[i].location.city
    + ','+ response.data.results[i].location.country;
    phoneNumber=response.data.results[i].phone;
    credit_card_no=response.data.results[i].login.md5;



   const text3 = "SELECT * FROM sp_insert_customer($1,$2,$3,$4,$5,$6)"
     const value3 = [firstName,lastName,address,phoneNumber,userId,credit_card_no];
     console.log(chalk.blue(`insert customer [${i+1}] ${firstName}  ${lastName}  to customer table.......... `));
     pool.query(text3,value3);
  } */

  for(i=0;i< num_of_customers;i++,userId++){

    firstName=response.data[i].first_name;
    lastName= response.data[i].last_name;
    address= response.data[i].address.city + ','+ response.data[i].address.street_address
    + ','+ response.data[i].address.country;
    phoneNumber=response.data[i].phone_number;
    credit_card_no=response.data[i].credit_card.cc_number;


   const text3 = "SELECT * FROM sp_insert_customer($1,$2,$3,$4,$5,$6)"
     const value3 = [firstName,lastName,address,phoneNumber,userId,credit_card_no];
     console.log(chalk.blue(`insert customer [${i+1}] ${firstName}  ${lastName}  to customer table.......... `));
     await pool.query(text3,value3);
  }

  
   /////////////////////////////////////////////////////////////
   /*  airline table*/ 
   //http://api.travelpayouts.com/data/en/airports.json  - airlines data
  /////////////////////////////////////////////////////////////
  response = await axios({
    url: "https://api.travelpayouts.com/data/en/airlines.json",
    method: "get",
  });

  
  let airlineName;
  let airlineCode;
  let userId1=1;
  let countryId=1;

  for(i=0;i< num_of_airlines;i++,userId1++,countryId+=10){

    airlineName=response.data[i].name;
    airlineCode=response.data[i].code;

   
     const text4 = "SELECT * FROM sp_insert_airline($1,$2,$3)"
     const value4 = [airlineName,countryId,userId1];
     console.log(chalk.blueBright(`insert airline [${i+1}] ${airlineName} to airline table.......... `));
     await pool.query(text4,value4);
  }

  /////////////////////////////////////////////////////////////
   /*  flight table*/ 
   //"https://randomuser.me/api/?results=10&seed=abc" - username
  /////////////////////////////////////////////////////////////
 /*  response = await axios({
    url: `https://randomuser.me/api/?results=${num_of_flights}&seed=abc`,
    method: "get",
  }); */

  
  let departure_time;
  let landing_time;
  let airline_id;
  let origin_country_id;
  let destination_country_id;
  let remaining_tickets;
  


  for(i=0;i< num_of_flights;i++){

    let res=generator();
    departure_time=res.departure_time;
    landing_time=res.landing_time;
    airline_id= Math.floor(Math.random() * num_of_airlines) + 1;
    origin_country_id= Math.floor(Math.random() * num_of_countries) + 1;
    destination_country_id=Math.floor(Math.random() * num_of_countries) + 1;
    //remaining_tickets-=1;
    remaining_tickets=num_of_tickets_per_airline;


   const text = "SELECT * FROM sp_insert_flight($1,$2,$3,$4,$5,$6)"
     const value = [airline_id,origin_country_id,destination_country_id,departure_time,landing_time,remaining_tickets];
     console.log(chalk.yellowBright(`insert flight: [${i+1}] at [${departure_time}] to flight table.......... `));
     await pool.query(text,value);
  }

  
  let flight_id=1;  //50
 
  for(i=0;i< num_of_customers;i++,flight_id+=3){

   const text = "SELECT * FROM sp_insert_ticket($1,$2)"
     const value = [flight_id,i+1];
     console.log(chalk.greenBright(`insert ticket [${i+1}]  tickets table.......... `));
      await pool.query(text,value);
  }

  await client.query('COMMIT')

} catch (e) {
  await client.query('ROLLBACK')
  throw e
} finally {
  client.release();
  
}

}



  InsertDataToTables().catch(e => console.error(e.stack));



