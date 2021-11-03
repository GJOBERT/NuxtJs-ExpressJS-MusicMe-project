const mysql = require("mysql");
require("dotenv").config();

const connect = mysql.createConnection({
    host     : process.env.DB_HOST,
    user     : process.env.DB_USER,
    password : process.env.DB_PASS,
    database : process.env.DB_NAME
});

connect.connect(err => {
    if (err) {
        console.log("error connecting : " + err.stack);
    } else {
        console.log("Connected!");
    }
});

module.exports = connect;
