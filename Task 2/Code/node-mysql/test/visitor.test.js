const request = require('supertest');
const { expect } = require('chai');
const app = require('../server');
const { getPool } = require('../config/db');

describe('Visitor API Tests', () => {
  let connection;

afterEach(async () => {
  const pool = getPool();
  await pool.query("DELETE FROM visitors WHERE name='Test Visitor'");
});
  describe('POST /api/visitors', () => {
    it('should create a new visitor when a valid name is provided', async () => {
      const response = await request(app)
        .post('/api/visitors')
        .send({ name: 'Test Visitor' });

      expect(response.status).to.equal(201);
      expect(response.body).to.have.property('message', 'Visitor added successfully');
      expect(response.body).to.have.property('visitorId');
    });

    it('should return 400 if name is not provided', async () => {
      const response = await request(app)
        .post('/api/visitors')
        .send({}); // No name provided

      expect(response.status).to.equal(400);
      expect(response.body).to.have.property('error', 'Name is required');
    });
  });

  describe('GET /api/visitors', () => {
    it('should return an array of visitors', async () => {
      const response = await request(app)
        .get('/api/visitors')
        .send();

      expect(response.status).to.equal(200);
      expect(response.body).to.be.an('array');
    });
  });
});
