// Authentication JavaScript for ITI University Examination System
// Updated to integrate with backend API

// Authentication module
window.AuthSystem = {
    // Initialize authentication
    init: async function() {
        console.log('AuthSystem.init() called');
        this.setupAuthForms();
        this.setupPasswordToggle();
        this.setupRememberMe();
        this.checkRememberedUser();
        this.setupPasswordStrength();
        this.setupCaptcha();
        await this.checkAuthStatus();
    },

    // Setup authentication forms
    setupAuthForms: function() {
        console.log('Setting up auth forms...');
        const loginForm = document.getElementById('loginForm');
        const forgotPasswordForm = document.getElementById('forgotPasswordForm');
        const resetPasswordForm = document.getElementById('resetPasswordForm');

        if (loginForm) {
            loginForm.addEventListener('submit', (e) => this.handleLogin(e));
            console.log('Login form event listener added');
        }

        if (forgotPasswordForm) {
            forgotPasswordForm.addEventListener('submit', (e) => this.handleForgotPassword(e));
        }

        if (resetPasswordForm) {
            resetPasswordForm.addEventListener('submit', (e) => this.handleResetPassword(e));
        }
    },

    // Handle login form submission
    handleLogin: async function(e) {
        console.log('Login form submitted!');
        e.preventDefault();
        
        const form = e.target;
        const username = form.querySelector('#username')?.value || form.querySelector('#email')?.value;
        const password = form.querySelector('#password').value;
        const rememberMe = form.querySelector('#rememberMe')?.checked || false;
        const captchaResponse = form.querySelector('#captchaResponse')?.value;

        // Validate form
        if (!this.validateLoginForm(form)) {
            return;
        }

        // Show loading state
        const submitBtn = form.querySelector('button[type="submit"]');
        this.setLoadingState(submitBtn, true);

        try {
            const response = await this.loginUser(username, password, rememberMe, captchaResponse);
            
            if (response.status === 'success') {
                this.handleLoginSuccess(response.data.user, response.data.token, rememberMe);
            } else {
                this.showAuthError(response.message || 'Login failed');
            }
        } catch (error) {
            console.error('Login error:', error);
            this.showAuthError('Network error. Please try again.');
        } finally {
            this.setLoadingState(submitBtn, false);
        }
    },

    // Handle forgot password form submission
    handleForgotPassword: async function(e) {
        e.preventDefault();
        
        const form = e.target;
        const email = form.querySelector('#email').value;

        if (!this.validateEmail(email)) {
            this.showAuthError('Please enter a valid email address');
            return;
        }

        // Show loading state
        const submitBtn = form.querySelector('button[type="submit"]');
        this.setLoadingState(submitBtn, true);

        try {
            const response = await this.forgotPassword(email);
            
            if (response.status === 'success') {
                this.showAuthSuccess('Password reset link sent to your email');
                form.reset();
            } else {
                this.showAuthError(response.message || 'Failed to send reset link');
            }
        } catch (error) {
            console.error('Forgot password error:', error);
            this.showAuthError('Network error. Please try again.');
        } finally {
            this.setLoadingState(submitBtn, false);
        }
    },

    // Handle reset password form submission
    handleResetPassword: async function(e) {
        e.preventDefault();
        
        const form = e.target;
        const password = form.querySelector('#password').value;
        const confirmPassword = form.querySelector('#confirmPassword').value;
        const token = new URLSearchParams(window.location.search).get('token');

        if (!this.validatePasswordReset(form)) {
            return;
        }

        // Show loading state
        const submitBtn = form.querySelector('button[type="submit"]');
        this.setLoadingState(submitBtn, true);

        try {
            const response = await this.resetPassword(token, password);
            
            if (response.status === 'success') {
                this.showAuthSuccess('Password reset successfully. Please login with your new password.');
                setTimeout(() => {
                    window.location.href = 'login.html';
                }, 2000);
            } else {
                this.showAuthError(response.message || 'Password reset failed');
            }
        } catch (error) {
            console.error('Reset password error:', error);
            this.showAuthError('Network error. Please try again.');
        } finally {
            this.setLoadingState(submitBtn, false);
        }
    },

    // Real login API call
    loginUser: async function(username, password, rememberMe, captchaResponse) {
        const response = await fetch(`${Utils.getApiBaseUrl()}/login`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                username,
                password
            })
        });

        const data = await response.json();
        
        if (!response.ok) {
            throw new Error(data.message || 'Login failed');
        }

        return data;
    },

    // Real forgot password API call
    forgotPassword: async function(email) {
        // Note: This endpoint might not exist in your backend yet
        // You may need to implement it or handle it differently
        const response = await fetch(`${Utils.getApiBaseUrl()}/forgot-password`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email })
        });

        const data = await response.json();
        
        if (!response.ok) {
            throw new Error(data.message || 'Failed to send reset link');
        }

        return data;
    },

    // Real reset password API call
    resetPassword: async function(token, password) {
        // Note: This endpoint might not exist in your backend yet
        const response = await fetch(`${Utils.getApiBaseUrl()}/reset-password`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ token, password })
        });

        const data = await response.json();
        
        if (!response.ok) {
            throw new Error(data.message || 'Password reset failed');
        }

        return data;
    },

    // Handle successful login
    handleLoginSuccess: function(user, token, rememberMe) {
        console.log('Login user object:', user); // Debug user object and role
        // Store token and user data
        if (rememberMe) {
            localStorage.setItem('authToken', token);
            localStorage.setItem('userData', JSON.stringify(user));
        } else {
            sessionStorage.setItem('authToken', token);
            sessionStorage.setItem('userData', JSON.stringify(user));
        }
        // Redirect based on role
        if (user.role === 'student' || user.role === 'instructor') {
            window.location.href = 'exam.html';
        } else {
            window.location.href = 'index.html';
        }
    },

    // Check authentication status
    checkAuthStatus: async function() {
        const token = this.getAuthToken();
        const userData = this.getUserData();
        
        if (token && userData) {
            // Validate token with backend
            try {
                const response = await fetch(`${Utils.getApiBaseUrl()}/auth/validate`, {
                    method: 'GET',
                    headers: {
                        'Authorization': `Bearer ${token}`,
                        'Content-Type': 'application/json'
                    }
                });
                
                if (response.ok) {
                    // Token is valid, redirect if on auth pages
                    const currentPage = window.location.pathname;
                    if (currentPage.includes('login.html')) {
                        window.location.href = 'dashboard.html';
                    }
                } else {
                    // Token is invalid, clear storage and stay on current page
                    this.clearAuthData();
                }
            } catch (error) {
                console.error('Token validation error:', error);
                // On error, clear storage and stay on current page
                this.clearAuthData();
            }
        } else {
            // User is not logged in, redirect if on protected pages
            const currentPage = window.location.pathname;
            const protectedPages = ['dashboard.html', 'exam.html', 'profile.html', 'results.html'];
            
            if (protectedPages.some(page => currentPage.includes(page))) {
                window.location.href = 'login.html';
            }
        }
    },

    // Clear authentication data
    clearAuthData: function() {
        localStorage.removeItem('authToken');
        localStorage.removeItem('userData');
        sessionStorage.removeItem('authToken');
        sessionStorage.removeItem('userData');
    },

    // Get authentication token
    getAuthToken: function() {
        return localStorage.getItem('authToken') || sessionStorage.getItem('authToken');
    },

    // Get user data
    getUserData: function() {
        const userData = localStorage.getItem('userData') || sessionStorage.getItem('userData');
        return userData ? JSON.parse(userData) : null;
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

    // Validate login form
    validateLoginForm: function(form) {
        const username = form.querySelector('#username')?.value || form.querySelector('#email')?.value;
        const password = form.querySelector('#password').value;

        if (!username || !password) {
            this.showAuthError('Please fill in all required fields');
            return false;
        }

        return true;
    },

    // Validate email
    validateEmail: function(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    },

    // Validate password reset form
    validatePasswordReset: function(form) {
        const password = form.querySelector('#password').value;
        const confirmPassword = form.querySelector('#confirmPassword').value;

        if (!password || !confirmPassword) {
            this.showAuthError('Please fill in all required fields');
            return false;
        }

        if (password !== confirmPassword) {
            this.showAuthError('Passwords do not match');
            return false;
        }

        if (password.length < 6) {
            this.showAuthError('Password must be at least 6 characters long');
            return false;
        }

        return true;
    },

    // Show authentication error
    showAuthError: function(message) {
        const errorDiv = document.getElementById('authError');
        if (errorDiv) {
            errorDiv.textContent = message;
            errorDiv.style.display = 'block';
            setTimeout(() => {
                errorDiv.style.display = 'none';
            }, 5000);
        } else {
            alert(message);
        }
    },

    // Show authentication success
    showAuthSuccess: function(message) {
        const successDiv = document.getElementById('authSuccess');
        if (successDiv) {
            successDiv.textContent = message;
            successDiv.style.display = 'block';
            setTimeout(() => {
                successDiv.style.display = 'none';
            }, 5000);
        } else {
            alert(message);
        }
    },

    // Set loading state
    setLoadingState: function(button, isLoading) {
        if (!button) return;
        
        if (isLoading) {
            button.disabled = true;
            button.innerHTML = '<span class="spinner"></span> Loading...';
        } else {
            button.disabled = false;
            button.innerHTML = button.getAttribute('data-original-text') || 'Submit';
        }
    },

    // Setup password toggle
    setupPasswordToggle: function() {
        const passwordToggles = document.querySelectorAll('.password-toggle');
        passwordToggles.forEach(toggle => {
            toggle.addEventListener('click', function() {
                const passwordField = this.previousElementSibling;
                if (passwordField.type === 'password') {
                    passwordField.type = 'text';
                    this.textContent = '👁️';
                } else {
                    passwordField.type = 'password';
                    this.textContent = '👁️‍🗨️';
                }
            });
        });
    },

    // Setup remember me functionality
    setupRememberMe: function() {
        const rememberMeCheckbox = document.querySelector('#rememberMe');
        if (rememberMeCheckbox) {
            const remembered = localStorage.getItem('rememberMe') === 'true';
            rememberMeCheckbox.checked = remembered;
            
            rememberMeCheckbox.addEventListener('change', function() {
                localStorage.setItem('rememberMe', this.checked);
            });
        }
    },

    // Check remembered user
    checkRememberedUser: function() {
        const remembered = localStorage.getItem('rememberMe') === 'true';
        if (remembered) {
            const savedUsername = localStorage.getItem('savedUsername');
            const savedPassword = localStorage.getItem('savedPassword');
            
            if (savedUsername && savedPassword) {
                const usernameField = document.querySelector('#username') || document.querySelector('#email');
                const passwordField = document.querySelector('#password');
                
                if (usernameField && passwordField) {
                    usernameField.value = savedUsername;
                    passwordField.value = savedPassword;
                }
            }
        }
    },

    // Setup password strength indicator
    setupPasswordStrength: function() {
        const passwordField = document.querySelector('#password');
        const strengthIndicator = document.querySelector('.password-strength');
        
        if (passwordField && strengthIndicator) {
            passwordField.addEventListener('input', function() {
                const strength = this.calculatePasswordStrength(this.value);
                this.updateStrengthIndicator(strengthIndicator, strength);
            });
        }
    },

    // Calculate password strength
    calculatePasswordStrength: function(password) {
        let score = 0;
        
        if (password.length >= 8) score++;
        if (/[a-z]/.test(password)) score++;
        if (/[A-Z]/.test(password)) score++;
        if (/[0-9]/.test(password)) score++;
        if (/[^A-Za-z0-9]/.test(password)) score++;
        
        if (score <= 2) return 'weak';
        if (score <= 3) return 'medium';
        return 'strong';
    },

    // Update strength indicator
    updateStrengthIndicator: function(indicator, strength) {
        indicator.className = `password-strength ${strength}`;
        indicator.textContent = `Strength: ${strength.charAt(0).toUpperCase() + strength.slice(1)}`;
    },

    // Setup captcha
    setupCaptcha: function() {
        // Implement captcha functionality if needed
        console.log('Captcha setup - implement as needed');
    }
};

// Initialize authentication when DOM is loaded
document.addEventListener('DOMContentLoaded', async function() {
    await AuthSystem.init();
});