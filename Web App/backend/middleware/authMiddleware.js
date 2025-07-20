const { verifyToken } = require('../utils/jwt');

const authenticateToken = (req, res, next) => {
  console.log('Request headers:', req.headers); // Debug: print all headers
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1]; // Bearer TOKEN

  if (!token) {
    return res.status(401).json({
      status: 'error',
      message: 'Access token required'
    });
  }

  try {
    const decoded = verifyToken(token);
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(403).json({
      status: 'error',
      message: 'Invalid or expired token'
    });
  }
};

const optionalAuth = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (token) {
    try {
      const decoded = verifyToken(token);
      req.user = decoded;
    } catch (error) {
      // Token is invalid but we continue without authentication
      req.user = null;
    }
  } else {
    req.user = null;
  }

  next();
};

module.exports = {
  authenticateToken,
  optionalAuth
}; 