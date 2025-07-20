// Main JavaScript for ITI Examination System
// Handles common functionality across all pages

// Main application module
window.App = {
    // Initialize the application
    init: async function() {
        this.setupNavigation();
        this.setupUserMenu();
        this.setupLogout();
        await this.loadUserData();
    },

    // Setup navigation functionality
    setupNavigation: function() {
        const navLinks = document.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                // Remove active class from all links
                navLinks.forEach(l => l.classList.remove('active'));
                // Add active class to clicked link
                this.classList.add('active');
            });
        });
    },

    // Setup user menu dropdown
    setupUserMenu: function() {
        const userMenu = document.querySelector('.user-menu');
        if (userMenu) {
            const userInfo = userMenu.querySelector('.user-info');
            const dropdownMenu = userMenu.querySelector('.dropdown-menu');
            
            if (userInfo && dropdownMenu) {
                userInfo.addEventListener('click', function(e) {
                    e.stopPropagation();
                    dropdownMenu.classList.toggle('show');
                });

                // Close dropdown when clicking outside
                document.addEventListener('click', function(e) {
                    if (!userMenu.contains(e.target)) {
                        dropdownMenu.classList.remove('show');
                    }
                });
            }
        }
    },

    // Setup logout functionality
    setupLogout: function() {
        const logoutBtn = document.getElementById('logoutBtn');
        if (logoutBtn) {
            logoutBtn.addEventListener('click', function(e) {
                e.preventDefault();
                App.logout();
            });
        }
    },

    // Load user data and update UI
    loadUserData: async function() {
        const userData = this.getUserData();
        if (userData) {
            this.updateUserInterface(userData);
        } else {
            // If no user data, redirect to login
            const currentPage = window.location.pathname;
            const protectedPages = ['dashboard.html', 'exam.html', 'profile.html', 'results.html'];
            
            if (protectedPages.some(page => currentPage.includes(page))) {
                window.location.href = 'login.html';
            }
        }
    },

    // Get user data from storage
    getUserData: function() {
        const userData = localStorage.getItem('userData') || sessionStorage.getItem('userData');
        return userData ? JSON.parse(userData) : null;
    },

    // Get authentication token
    getAuthToken: function() {
        return localStorage.getItem('authToken') || sessionStorage.getItem('authToken');
    },

    // Update user interface with user data
    updateUserInterface: function(userData) {
        // Update user name in navigation
        const userNameElements = document.querySelectorAll('#userName, #welcomeName');
        userNameElements.forEach(element => {
            if (element) {
                element.textContent = userData.fullName || userData.username || 'User';
            }
        });

        // Update welcome message
        const welcomeName = document.getElementById('welcomeName');
        if (welcomeName) {
            welcomeName.textContent = userData.fullName || userData.username || 'User';
        }
    },

    // Logout user
    logout: async function() {
        try {
            const token = this.getAuthToken();
            if (token) {
                await fetch(`${Utils.getApiBaseUrl()}/logout`, {
                    method: 'POST',
                    headers: {
                        'Authorization': `Bearer ${token}`,
                        'Content-Type': 'application/json'
                    }
                });
            }
        } catch (error) {
            console.error('Logout error:', error);
        } finally {
            // Clear stored data
            localStorage.removeItem('authToken');
            localStorage.removeItem('userData');
            sessionStorage.removeItem('authToken');
            sessionStorage.removeItem('userData');
            
            // Redirect to login
            window.location.href = 'login.html';
        }
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
    },

    // Make API request with authentication
    apiRequest: async function(endpoint, options = {}) {
        const token = this.getAuthToken();
        
        const defaultOptions = {
            headers: {
                'Content-Type': 'application/json',
                ...(token && { 'Authorization': `Bearer ${token}` })
            }
        };

        const response = await fetch(`${Utils.getApiBaseUrl()}${endpoint}`, {
            ...defaultOptions,
            ...options
        });

        if (!response.ok) {
            throw new Error(`API request failed: ${response.status}`);
        }

        return response.json();
    }
};

// Initialize app when DOM is loaded
document.addEventListener('DOMContentLoaded', async function() {
    await App.init();
}); 