const requireRole = (roles) => {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({
        status: 'error',
        message: 'Authentication required'
      });
    }

    // Convert single role to array
    const allowedRoles = Array.isArray(roles) ? roles : [roles];

    if (!allowedRoles.includes(req.user.role)) {
      return res.status(403).json({
        status: 'error',
        message: 'Insufficient permissions'
      });
    }

    next();
  };
};

const requireInstructor = requireRole('instructor');
const requireStudent = requireRole('student');
const requireAnyRole = requireRole(['student', 'instructor']);

module.exports = {
  requireRole,
  requireInstructor,
  requireStudent,
  requireAnyRole
}; 