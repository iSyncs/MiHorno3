const express = require("express")
const mysql = require("mysql2")
const cors = require("cors")

const app = express()
app.use(cors())

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "m78719ce0f092",
    database: "MiHorno3"
})

db.connect(err => {
    if (err) {
        console.log("Error connecting to MySQL:", err)
    } else {
        console.log("Connected to MySQL")
    }
})

//Carlos Baranda Endpoint to get all challenges
app.get("/challenges", (req, res) => {

    const query = "SELECT * FROM challenges"

    db.query(query, (err, results) => {

        if (err) {
            res.status(500).json(err)
        } else {
            res.json(results)
        }

    })

})
    
// Joel

// Sebastian

//Jorge

app.listen(3000, () => {
    console.log("API running on port 3000")
})
