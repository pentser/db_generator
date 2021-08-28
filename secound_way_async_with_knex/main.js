
const raw_repo=require("./raw-repo");
const updateTickets=async (_id)=>{

    try {
        const result=await raw_repo.getRowResult(`select * from tickets;`);
        console.log(result.rows);

        const res1= await raw_repo.getRowResult(`select * from flights where id='${_id}';`);
        const current_tickets=res1.rows[0].remaining_tickets;
      
        const res=await raw_repo.getRowResult(`select * from sp_update_flights_remaining_ticket(${_id},'${current_tickets}')`);

        console.log(res.rows);

    } catch(e){
        console.log(e.message)
    }
    

}

module.exports=updateTickets;


