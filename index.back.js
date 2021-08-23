
const axios = require('axios');
const config=require('config');
const fs= require('fs');

const Pool = require('pg').Pool
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'flightcrm',
  password: 'admin',
  port: 5432,
});


async function getCountriesDataFromFile() {

// get countries data from countries files
   let string_from_file = fs.readFileSync('data\\countries.json', {encoding:'utf8', flag:'r'});
  data = JSON.parse(string_from_file) ;


  const client = await pool.connect()
  try {
    await client.query('BEGIN')
  
    const text = "call sp_delete_and_reset_countries()";
    const res=await pool.query(text);

    for (i=0;i<data.length;i++) {

		const text = "SELECT * FROM sp_insert_country($1)"
	    const value = [data[i].name];
      console.log(`insert country ${data[i].name} to countries table.......... `);
	    pool.query(text,value);

	}
    await client.query('COMMIT')
  } catch (e) {
    await client.query('ROLLBACK')
    throw e
  } finally {
    client.release()
  }

}

//global variables
const scale = config.get('scale')
const num_of_users=scale.users;
const num_of_airlines=scale.airlines;
const num_of_customers=scale.customers;
const num_of_flights=scale.flights;
const num_of_tickets_per_airline=scale.tickets_per_airline;
const  num_of_countries=scale.countries;

async function getAirlinesFromInternet() {


  const client = await pool.connect()

   try {
  await client.query('BEGIN')

   /////////////////////////////////////////////////////////////
   /*  airline table*/ 
   //http://api.travelpayouts.com/data/en/airports.json  - airlines data
  /////////////////////////////////////////////////////////////
    response = await axios({
    url: "https://api.travelpayouts.com/data/en/airlines.json",
    method: "get",
  });
  
  text = "call sp_delete_and_reset_airlines()";
  res=await pool.query(text);

  let airlineName;
  let airlineCode;
  let userId=1;
  let countryId=1;

  for(i=0;i< num_of_airlines;i++,userId++,countryId+=10){

    airlineName=response.data[i].name;
    airlineCode=response.data[i].code;

   
   const text = "SELECT * FROM sp_insert_airline($1,$2,$3)"
     const value = [airlineName,countryId,userId];
     console.log(`insert airline [${i+1}] ${airlineName} to airline table.......... `);
     pool.query(text,value);
  }
 
 
   await client.query('COMMIT')
 } catch (e) {
   await client.query('ROLLBACK')
   throw e
 } finally {
   client.release()
 }
}

async function getUsersFromInternet() {


  const client = await pool.connect()
  let username;
  let password;
  let email;
  let departure_time;
  let landing_clstime;
   try {
  await client.query('BEGIN')
 
  /////////////////////////////////////////////////////////////
  /*  users table*/ 
  //"https://randomuser.me/api/?results=10&seed=abc" - users data  username,password,nam
  /////////////////////////////////////////////////////////////
    let response = await axios({
    url: `https://randomuser.me/api/?results=${num_of_users}&seed=abc`,
    method: "get",
  });
  
  let text = "call sp_delete_and_reset_users()";
  let res=await pool.query(text);

  for(i=0;i< num_of_users;i++){

  username=response.data.results[i].login.username;
  password=response.data.results[i].login.password;
  email=response.data.results[i].email;
   /*  departure_time=response.data.results[i].dob.date;
       landing_time=response.data.results[i].registered.date;
   */
   const text = "SELECT * FROM sp_insert_users($1,$2,$3)"
 
     const value = [username,password,email];
     console.log(`insert user [${i+1}] ${username} to users table.......... `);
     pool.query(text,value);
  }
 
   await client.query('COMMIT')
 } catch (e) {
   await client.query('ROLLBACK')
   throw e
 } finally {
   client.release()
 }
}


async function getCustomersFromInternet() {


  const client = await pool.connect()

   try {
  await client.query('BEGIN')

   /////////////////////////////////////////////////////////////
   /*  customers table*/ 
   //"https://randomuser.me/api/?results=10&seed=abc" - username
  /////////////////////////////////////////////////////////////
    response = await axios({
    url: "https://randomuser.me/api/?results=10&seed=abc",
    method: "get",
  });
  
  text = "call sp_delete_and_reset_customers()";
  res=await pool.query(text);

  let firstName;
  let lastName;
  let address;
  let phoneNumber;
  let userId=10;
  let credit_card_no='';
  

  for(i=0;i< num_of_customers;i++,userId++){

    firstName=response.data.results[i].name.first;
    lastName=response.data.results[i].name.last;
    address= response.data.results[i].location.street.name + ','+ response.data.results[i].location.city
    + ','+ response.data.results[i].location.country;
    phoneNumber=response.data.results[i].phone;
    credit_card_no=response.data.results[i].login.md5;



   const text = "SELECT * FROM sp_insert_customer($1,$2,$3,$4,$5,$6)"
     const value = [firstName,lastName,address,phoneNumber,userId,credit_card_no];
     console.log(`insert customer [${i+1}] ${firstName}  ${lastName}  to customer table.......... `);
     pool.query(text,value);
  }
 
 
   await client.query('COMMIT')
 } catch (e) {
   await client.query('ROLLBACK')
   throw e
 } finally {
   client.release()
 }
}

async function getFlightsFromInternet() {


  const client = await pool.connect()

   try {
  await client.query('BEGIN')

   /////////////////////////////////////////////////////////////
   /*  flight table*/ 
   //"https://randomuser.me/api/?results=10&seed=abc" - username
  /////////////////////////////////////////////////////////////
    response = await axios({
    url: `https://randomuser.me/api/?results=${num_of_flights}&seed=abc`,
    method: "get",
  });
  
  text = "call sp_delete_and_reset_flights()";
  res=await pool.query(text);

  let departure_time;
  let landing_time;
  let airline_id;
  let origin_country_id;
  let destination_country_id;
  let remaining_tickets=num_of_tickets_per_airline;

  for(i=0;i< num_of_flights;i++){

    departure_time=response.data.results[i].dob.date;
    landing_time=response.data.results[i].registered.date;
    airline_id= Math.floor(Math.random() * num_of_airlines) + 1;
    origin_country_id= Math.floor(Math.random() * num_of_countries) + 1;
    destination_country_id=Math.floor(Math.random() * num_of_countries) + 1;
    //remaining_tickets-=1;


   const text = "SELECT * FROM sp_insert_flight($1,$2,$3,$4,$5,$6)"
     const value = [airline_id,origin_country_id,destination_country_id,departure_time,landing_time,remaining_tickets];
     console.log(`insert flight: [${i+1}] at [${departure_time}] to flight table.......... `);
     pool.query(text,value);
  }
 
 
   await client.query('COMMIT')
 } catch (e) {
   await client.query('ROLLBACK')
   throw e
 } finally {
   client.release()
 }
}


async function getTicketsFromInternet() {

 
  const client = await pool.connect()

  try{
  await client.query('BEGIN')

  text = "call sp_delete_and_reset_tickets()";
  res=await pool.query(text);

  let flight_id=1;  //50
 
  for(i=0;i< num_of_customers;i++,flight_id+=3){

   const text = "SELECT * FROM sp_insert_ticket($1,$2)"
     const value = [flight_id,i+1];
     console.log(`insert ticket [${i+1}]  tickets table.......... `);
      pool.query(text,value);
  
  }
 
 
   await client.query('COMMIT')
 } catch (e) {
   await client.query('ROLLBACK')
   throw e
 } finally {
  client.release();
 }
}



 getAirlinesFromInternet().catch(e => console.error(e.stack));

getUsersFromInternet().catch(e => console.error(e.stack));

getTicketsFromInternet().catch(e => console.error(e.stack));

getCustomersFromInternet().catch(e => console.error(e.stack));

getFlightsFromInternet().catch(e => console.error(e.stack));

getCountriesDataFromFile().catch(e => console.error(e.stack));
 
/*
delete                     

tickets
flight
airlines
customers
users
countries

insert

countries
users
customers
airlines
flights
tickets
*/








