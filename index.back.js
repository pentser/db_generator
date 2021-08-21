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
})

let string_from_file = fs.readFileSync('data\\countries.json', {encoding:'utf8', flag:'r'});
data = JSON.parse(string_from_file) ;


   async function getDataFromInternet() {

    try {
		   const response = await axios({
			url: "https://randomuser.me/api/?results=10&seed=abc",
			method: "get",
		});	

		for(i=1;i<5;i++){

		let username=response.data.results[i].login.username;
		let password=response.data.results[i].login.password;
		let email=response.data.results[i].email;
		let departure_time=response.data.results[i].dob.date;
		let landing_time=response.data.results[i].registered.date;

		console.log(response.data.results);
		

		 const text = "SELECT * FROM sp_insert_users($1,$2,$3)"
		const values = [username,password,email];
	 	   pool.query(text,values,(error, results) => {
			if (error) {
                console.log('error')
		  }
		  else
		  console.log(results.rows)
	  })  
	} 
	     
	
	} catch (err) {
		console.log(err)
	} 

}


//getDataFromInternet();

async function getDataFromFile() {

	 const text = "call sp_delete_and_reset_countries()";
	 pool.query(text,(error, results) => {
		if (error) {
			console.log('error');
	  }
	    else {
	      console.log(results.rows);
	  }
});


	for (i=0;i<data.length;i++) {

		const text = "SELECT * FROM sp_insert_country($1)"
	    const values = [data[i].name];
	 pool.query(text,values,(error, results) => {
		if (error) {
			console.log('error',error.message)
	  }
	  else {
	      console.log(results.rows)
	  }
	});
}

}


getDataFromFile()


