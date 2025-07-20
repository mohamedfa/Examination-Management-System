const getNotifications = async (req, res) => {
  // Dummy data for dashboard
  res.json({
    status: 'success',
    data: [
      { id: 1, message: 'Welcome to the ITI Examination System!', date: '2024-06-01' },
      { id: 2, message: 'Your Math Exam is scheduled for 2024-06-10.', date: '2024-06-05' }
    ]
  });
};

module.exports = {
  getNotifications
}; 