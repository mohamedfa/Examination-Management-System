// Configuration for ITI Examination System
// Shared configuration across all JavaScript files

// API Configuration
window.API_CONFIG = {
    BASE_URL: 'http://localhost:3000/api'
};

// Global utility functions
window.Utils = {
    // Get API base URL
    getApiBaseUrl: function() {
        return API_CONFIG.BASE_URL;
    },
    
    // Show notification
    showNotification: function(message, type = 'info') {
        const notification = document.createElement('div');
        notification.className = `notification ${type}`;
        notification.textContent = message;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.remove();
        }, 3000);
    }
}; 