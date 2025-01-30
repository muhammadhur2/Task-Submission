require('dotenv').config();
const mysql = require('mysql2/promise');

let pool;

(async function createConnectionPool() {
  try {
    pool = await mysql.createPool({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
      port: process.env.DB_PORT || 3306,
      connectionLimit: 10 // Adjust as needed
    });

    // Create table if not exists
    const createTableQuery = `
      CREATE TABLE IF NOT EXISTS visitors (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        visit_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `;
    await pool.query(createTableQuery);

    console.log('MySQL pool created and visitors table ensured.');
  } catch (error) {
    console.error('Error creating MySQL pool', error);
    process.exit(1);
  }
})();

module.exports = {
  getPool: () => pool
};
