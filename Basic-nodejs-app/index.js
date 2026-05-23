const express = require('express');
const app = express();
const request = require('request');
const wikip = require('wiki-infobox-parser');

app.set("view engine", 'ejs');

// routes
app.get('/', (req, res) => {
    res.render('index');
});

app.get('/index', (req, response) => {
    // ... your Wikipedia logic ...
});

// health check route
app.get('/healthz', (req, res) => {
    res.status(200).send('OK');
});

// port
app.listen(3000, () => console.log("Listening at port 3000..."));
