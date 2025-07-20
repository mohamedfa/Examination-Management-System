// Dashboard JavaScript for ITI Examination System
// Handles dashboard-specific functionality

// Dashboard module
window.Dashboard = {
    // Initialize dashboard
    init: function() {
        this.loadDashboardData();
        this.setupCharts();
        this.setupNotifications();
    },

    // Load dashboard data
    loadDashboardData: async function() {
        try {
            // Load user stats
            await this.loadUserStats();
            
            // Load upcoming exams
            await this.loadUpcomingExams();
            
            // Load recent results
            await this.loadRecentResults();
            
            // Load notifications
            await this.loadNotifications();
            
        } catch (error) {
            console.error('Error loading dashboard data:', error);
            this.showError('Failed to load dashboard data');
        }
    },

    // Load user statistics
    loadUserStats: async function() {
        try {
            const response = await App.apiRequest('/users/stats');
            
            if (response.status === 'success') {
                const stats = response.data;
                
                // Update stats in UI
                document.getElementById('totalExams').textContent = stats.totalExams || 0;
                document.getElementById('completedExams').textContent = stats.completedExams || 0;
                document.getElementById('pendingExams').textContent = stats.pendingExams || 0;
                document.getElementById('averageScore').textContent = `${stats.averageScore || 0}%`;
            }
        } catch (error) {
            console.error('Error loading user stats:', error);
            // Set default values
            document.getElementById('totalExams').textContent = '0';
            document.getElementById('completedExams').textContent = '0';
            document.getElementById('pendingExams').textContent = '0';
            document.getElementById('averageScore').textContent = '0%';
        }
    },

    // Load upcoming exams
    loadUpcomingExams: async function() {
        try {
            const response = await App.apiRequest('/exams/upcoming');
            const upcomingExamsContainer = document.getElementById('upcomingExams');
            
            if (response.status === 'success' && response.data.length > 0) {
                upcomingExamsContainer.innerHTML = response.data.map(exam => `
                    <div class="exam-item">
                        <div class="exam-info">
                            <h4>${exam.title}</h4>
                            <p>${exam.subject} - ${exam.duration} minutes</p>
                            <span class="exam-date">${new Date(exam.startDate).toLocaleDateString()}</span>
                        </div>
                        <div class="exam-actions">
                            <a href="exam.html?id=${exam.id}" class="btn btn-primary">Start Exam</a>
                        </div>
                    </div>
                `).join('');
            } else {
                upcomingExamsContainer.innerHTML = '<p class="no-data">No upcoming exams</p>';
            }
        } catch (error) {
            console.error('Error loading upcoming exams:', error);
            document.getElementById('upcomingExams').innerHTML = '<p class="no-data">Failed to load upcoming exams</p>';
        }
    },

    // Load recent results
    loadRecentResults: async function() {
        try {
            const response = await App.apiRequest('/results/recent');
            const recentResultsContainer = document.getElementById('recentResults');
            
            if (response.status === 'success' && response.data.length > 0) {
                recentResultsContainer.innerHTML = response.data.map(result => `
                    <div class="result-item">
                        <div class="result-info">
                            <h4>${result.examTitle}</h4>
                            <p>${result.subject}</p>
                            <span class="result-date">${new Date(result.completedAt).toLocaleDateString()}</span>
                        </div>
                        <div class="result-score">
                            <span class="score ${this.getScoreClass(result.score)}">${result.score}%</span>
                        </div>
                    </div>
                `).join('');
            } else {
                recentResultsContainer.innerHTML = '<p class="no-data">No recent results</p>';
            }
        } catch (error) {
            console.error('Error loading recent results:', error);
            document.getElementById('recentResults').innerHTML = '<p class="no-data">Failed to load recent results</p>';
        }
    },

    // Load notifications
    loadNotifications: async function() {
        try {
            const response = await App.apiRequest('/notifications');
            const notificationsContainer = document.getElementById('notificationsList');
            
            if (response.status === 'success' && response.data.length > 0) {
                notificationsContainer.innerHTML = response.data.map(notification => `
                    <div class="notification-item ${notification.type}">
                        <div class="notification-icon">
                            <i class="fas ${this.getNotificationIcon(notification.type)}"></i>
                        </div>
                        <div class="notification-content">
                            <p>${notification.message}</p>
                            <span class="notification-time">${new Date(notification.createdAt).toLocaleDateString()}</span>
                        </div>
                    </div>
                `).join('');
            } else {
                notificationsContainer.innerHTML = '<p class="no-data">No notifications</p>';
            }
        } catch (error) {
            console.error('Error loading notifications:', error);
            document.getElementById('notificationsList').innerHTML = '<p class="no-data">Failed to load notifications</p>';
        }
    },

    // Setup performance chart
    setupCharts: function() {
        const chartCanvas = document.getElementById('performanceChart');
        if (chartCanvas) {
            this.createPerformanceChart(chartCanvas);
        }
    },

    // Create performance chart
    createPerformanceChart: function(canvas) {
        const ctx = canvas.getContext('2d');
        
        // Sample data - replace with real data from API
        const chartData = {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'Performance Score',
                data: [75, 82, 78, 85, 90, 88],
                borderColor: '#4CAF50',
                backgroundColor: 'rgba(76, 175, 80, 0.1)',
                tension: 0.4
            }]
        };

        new Chart(ctx, {
            type: 'line',
            data: chartData,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100
                    }
                }
            }
        });
    },

    // Setup notifications
    setupNotifications: function() {
        // Add any notification-specific functionality here
        console.log('Notifications setup complete');
    },

    // Get score class for styling
    getScoreClass: function(score) {
        if (score >= 90) return 'excellent';
        if (score >= 80) return 'good';
        if (score >= 70) return 'average';
        return 'poor';
    },

    // Get notification icon
    getNotificationIcon: function(type) {
        const icons = {
            'info': 'fa-info-circle',
            'success': 'fa-check-circle',
            'warning': 'fa-exclamation-triangle',
            'error': 'fa-times-circle'
        };
        return icons[type] || 'fa-bell';
    },

    // Show error message
    showError: function(message) {
        App.showNotification(message, 'error');
    },

    // Show success message
    showSuccess: function(message) {
        App.showNotification(message, 'success');
    }
};

// Initialize dashboard when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    Dashboard.init();
}); 