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
//Jorge

// Obtener nodo por QR escaneado
app.get("/map/node/:qr", (req, res) => {

    const qr = req.params.qr

    const query = `
        SELECT id, nombre, x, y, node_type
        FROM insidemap
        WHERE qr_code = ?
    `

    db.query(query, [qr], (err, results) => {

        if (err) {
            res.status(500).json(err)
        } else {
            res.json(results[0])
        }

    })

})


// Obtener todos los baños
app.get("/map/bathrooms", (req, res) => {

    const query = `
        SELECT id, nombre, x, y
        FROM insidemap
        WHERE node_type = 'bathroom'
    `

    db.query(query, (err, results) => {

        if (err) {
            res.status(500).json(err)
        } else {
            res.json(results)
        }

    })

})


// Obtener todo el grafo (nodos + conexiones)
app.get("/map/graph", (req, res) => {

    const nodesQuery = `
        SELECT id, nombre, x, y, node_type
        FROM insidemap
    `

    const edgesQuery = `
        SELECT from_node, to_node, weight
        FROM insidemap_edges
    `

    db.query(nodesQuery, (err, nodes) => {

        if (err) {
            res.status(500).json(err)
        } else {

            db.query(edgesQuery, (err2, edges) => {

                if (err2) {
                    res.status(500).json(err2)
                } else {

                    res.json({
                        nodes: nodes,
                        edges: edges
                    })

                }

            })

        }

    })

})


app.listen(3000, () => {
    console.log("API running on port 3000")
})
