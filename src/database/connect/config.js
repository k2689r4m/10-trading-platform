const mysql = require('mysql2/promise');

const conn = mysql.createPool({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PW,
    database: process.env.MYSQL_DB,
    // connectTimeout: 5000,
    connectionLimit: 30, //default 10
    waitForConnections: true,
    enableKeepAlive: true, // false by default.
    queueLimit: 0,
})

module.exports = conn;