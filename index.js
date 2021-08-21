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

//getCountriesDataFromFile().catch(e => console.error(e.stack))




/*
   get relevant data from the internet
   http://api.travelpayouts.com/data/en/airports.json  - airlines data
   "https://randomuser.me/api/?results=10&seed=abc" - users data  username,password,name


*/


const scale = config.get('scale')
const num_of_users=scale.users;

async function getDataFromInternet() {


  const client = await pool.connect()
  let username;
  let password;
  let email;
  let departure_time;
  let landing_time;
   try {
  await client.query('BEGIN')
 
    const response = await axios({
    url: "https://randomuser.me/api/?results=10&seed=abc",
    method: "get",
  });
  
  const text = "call sp_delete_and_reset_users()";
  const res=await pool.query(text);

  for(i=0;i< num_of_users;i++){

  username=response.data.results[i].login.username;
  password=response.data.results[i].login.password;
  email=response.data.results[i].email;
  departure_time=response.data.results[i].dob.date;
  landing_time=response.data.results[i].registered.date;
  
   const text = "SELECT * FROM sp_insert_users($1,$2,$3)"
     const value = [username,password,email];
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


getDataFromInternet().catch(e => console.error(e.stack))

   





