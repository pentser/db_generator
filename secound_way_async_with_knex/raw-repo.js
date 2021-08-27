
const connextedKnex=require('./knex_connector');


const getRowResult=(raw_query)=>connextedKnex.raw(raw_query);

module.exports={
    getRowResult
}