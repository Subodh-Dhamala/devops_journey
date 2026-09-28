const express = require('express');
const {Pool} = require('pg');
const dotenv = require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
});

app.get('/', (req, res)=> {
        res.send('Hello, World!')    
})

app.get('/health', (req,res) => {
    res.json({
        status: "Healthy"
    });
})

app.get("/db", async (req, res) => {
    try{
        const result = await pool.query("SELECT NOW()");
        res.json({
            status: "success",
            database: "connected",
            data: result.rows
        });
    }
    catch(err){
        console.error("DB connection failed:", err);
        res.status(500).json({
            status: "error",
            database: "disconnected",
        });
    }
});

app.listen(PORT, ()=>{
    console.log(`Server is running on http://localhost:${PORT}`);
})