const express = require('express');
const dotenv = require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res)=> {
        res.send('Hello, World!')    
})

app.get('/health', (req,res) => {
    res.json({
        status: "Healthy"
    });
})

app.listen(PORT, ()=>{
    console.log(`Server is running on http://localhost:${PORT}`);
})