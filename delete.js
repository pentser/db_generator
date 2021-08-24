

const Pool = require('pg').Pool
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'flightcrm',
  password: 'admin',
  port: 5432,
});

const chalk = require('chalk');



async function deleteAllTables() {

    const client = await pool.connect()
     try {
  
      await client.query('BEGIN')

      let text1 = "call sp_delete_and_reset_tickets()";
      pool.query(text1);
      console.log(chalk.blue('delete and reset tickets table......'));

      let text2 = "call sp_delete_and_reset_flights()";
      pool.query(text2);
      console.log(chalk.blue('delete and reset flights table......'));

      let text3 = "call sp_delete_and_reset_airlines()";
      pool.query(text3);
      console.log(chalk.blue('delete and reset airlines table......'));

      let text4 = "call sp_delete_and_reset_customers()";
      pool.query(text4);
      console.log(chalk.blue('delete and reset customers table......'));

      let text5 = "call sp_delete_and_reset_users()";
      pool.query(text5);
      console.log(chalk.blue('delete and reset users table......'));

      let text6 = "call sp_delete_and_reset_countries()";
      pool.query(text6);
      console.log(chalk.blue('delete and reset countries table......'));


     await client.query('COMMIT')
   } catch (e) {
     await client.query('ROLLBACK')
     throw e
   } finally {
     client.release();
     require("./insert");
   }
  
  }



  deleteAllTables().catch(e => console.error(e.stack));


  
  
  
  
  
  
  
  