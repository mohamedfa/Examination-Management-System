const express = require('express');
const cors = require('cors');
const { connectDB } = require('./utils/db');
const app = express();
const path = require('path');

// Import routes
const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/users');
const examRoutes = require('./routes/exams');
const questionRoutes = require('./routes/questions');
const resultRoutes = require('./routes/results');
const notificationsRoutes = require('./routes/notifications');

// Connect to database (non-blocking)
connectDB().catch(error => {
  console.error('Database connection failed, but server will continue running');
  console.error('Error details:', error.message);
});

// CORS configuration
app.use(cors({
  origin: ['http://127.0.0.1:5500', 'http://localhost:5500', 'http://localhost:8080'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));

// Middleware
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Request logging middleware
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
  next();
});

// Health check endpoint
app.get('/api/health', (req, res) => {
    res.status(200).json({ status: 'OK', message: 'Backend is running' });
});

// API Routes
app.use('/api', authRoutes);
app.use('/api', userRoutes);
app.use('/api', examRoutes);
app.use('/api', questionRoutes);
app.use('/api', resultRoutes);
app.use('/api', notificationsRoutes);
app.use('/api/users', require('./routes/users'));
app.use('/api/instructor', require('./routes/instructor'));
// Add this for dashboard stats
app.use('/api/dashboard', require('./routes/users'));

// Serve new frontend from /new-version
app.use('/new-version', express.static(path.join(__dirname, '../new-version')));

// 404 handler
app.use('*', (req, res) => {
  res.status(404).json({
    status: 'error',
    message: `Route ${req.originalUrl} not found`
  });
});

// Global error handler
app.use((err, req, res, next) => {
  console.error('Error:', err);
  
  res.status(err.status || 500).json({
    status: 'error',
    message: err.message || 'Internal server error',
    ...(process.env.NODE_ENV === 'development' && { stack: err.stack })
  });
});

module.exports = app;