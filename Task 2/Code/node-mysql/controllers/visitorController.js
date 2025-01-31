const { getPool } = require('../config/db');

exports.createVisitor = async (req, res) => {
  try {
    const { name } = req.body;
    if (!name) {
      return res.status(400).json({ error: 'Name is required' });
    }

    const pool = getPool();
    const insertQuery = `INSERT INTO visitors (name) VALUES (?)`;
    const [result] = await pool.execute(insertQuery, [name]);

    return res.status(201).json({
      message: 'Visitor added successfully',
      visitorId: result.insertId
    });
  } catch (error) {
    console.error('Error creating visitor:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
};

exports.getAllVisitors = async (req, res) => {
  try {
    const pool = getPool();
    const selectQuery = `SELECT * FROM visitors ORDER BY id DESC`;
    const [rows] = await pool.execute(selectQuery);

    return res.status(200).json(rows);
  } catch (error) {
    console.error('Error fetching visitors:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
};
