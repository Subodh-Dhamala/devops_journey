const express = require("express");
const cors = require("cors");

const app = express();

app.use(cors({
	origin: "http://localhost:8080"
		}));

app.get("/",(req,res)=>{
	res.json({
		status: "ok",	
		message: "Server is running!"
		});
	     });

const PORT = 3000;
 app.listen(PORT,()=>{
	console.log(`Server is running on  http://localhost:${PORT}`);
});

