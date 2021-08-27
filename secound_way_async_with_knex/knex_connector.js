const knex=require('knex');

const connectedKnex=knex({
    client:'pg',
    version:'13',
    connection:{
         host:'127.0.0.1',
         user:'postgres',
         password:'admin',
         database:'flightcrm'
    }
})

module.exports=connectedKnex;