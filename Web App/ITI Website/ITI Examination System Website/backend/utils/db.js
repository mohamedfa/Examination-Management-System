const sql = require('mssql');

const dbConfig = {
  server: process.env.DB_SERVER || 'localhost',
  database: process.env.DB_DATABASE || 'ITI_Examination_System',
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  port: parseInt(process.env.DB_PORT) || 1433,
  options: {
    encrypt: false, // For Azure use true
    trustServerCertificate: true, // For local dev / self-signed certs
    enableArithAbort: true
  },
  pool: {
    max: 10,
    min: 0,
    idleTimeoutMillis: 30000
  }
};

let pool;

const connectDB = async () => {
  try {
    pool = await sql.connect(dbConfig);
    console.log('✅ Database connected successfully');
    return pool;
  } catch (error) {
    console.error('❌ Database connection failed:', error.message);
    console.error('Error details:', error);
    console.error('DB Config:', dbConfig);
    console.log('⚠️  Server will run without database connection for testing');
    console.log('📝 Please configure your database credentials in .env file');
    return null;
  }
};

const getPool = () => {
  if (!pool) {
    throw new Error('Database not connected. Please configure your database credentials in .env file');
  }
  return pool;
};

const executeQuery = async (query, params = []) => {
  try {
    const pool = getPool();
    const request = pool.request();
    
    // Add parameters if provided
    params.forEach((param, index) => {
      request.input(`param${index + 1}`, param);
    });
    
    const result = await request.query(query);
    return result;
  } catch (error) {
    console.error('Database query error:', error);
    throw error;
  }
};

const executeStoredProcedure = async (procedureName, params = {}) => {
  try {
    const pool = getPool();
    const request = pool.request();
    
    // Add parameters
    Object.keys(params).forEach(key => {
      request.input(key, params[key]);
    });
    
    const result = await request.execute(procedureName);
    return result;
  } catch (error) {
    console.error('Stored procedure error:', error);
    throw error;
  }
};

module.exports = {
  connectDB,
  getPool,
  executeQuery,
  executeStoredProcedure
};