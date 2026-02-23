const express = require('express');
const mysql = require('mysql');
const cors = require('cors');

const db = mysql.createConnection({
    host: "localhost",
    user:"root",
    password:"Shadowmaster123",
    connectionLimit: 10
})

db.connect((err) => {
    if (err) throw err;
    console.log('Connected to MySQL database.');
});
