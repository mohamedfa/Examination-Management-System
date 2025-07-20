// Global variables
let currentUser = null;
let currentExam = null;
let examTimer = null;
let examStartTime = null;
const API_BASE_URL = 'http://localhost:3000';

// Initialize application on page load
document.addEventListener('DOMContentLoaded', async function() {
    setupNavigation();
    await checkAuthStatus();
    initializePage();
});

// Authentication functions
async function checkAuthStatus() {
    try {
        const token = localStorage.getItem('token');
        if (!token) {
            console.log('No token found');
            return;
        }
        
        const response = await fetch(`${API_BASE_URL}/api/validate`, {
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });
        
        if (response.ok) {
            const data = await response.json();
            currentUser = data.data.user;
            updateNavigation();
            showDashboardActions(); // <-- Show dashboard actions after user is set
        } else if (response.status === 401) {
            console.log('User not authenticated');
            localStorage.removeItem('token');
        } else {
            console.error(`Server error: ${response.status} - ${response.statusText}`);
            // Optionally show a UI message: showMessage('Backend server may not be running.', 'error');
        }
    } catch (error) {
        console.error('Network error during auth check:', error);
        // showMessage('Unable to connect to server. Please check if backend is running.', 'error');
    }
}

function updateNavigation() {
    const navMenu = document.querySelector('.nav-menu');
    if (currentUser) {
        navMenu.innerHTML = `
            <a href="index.html" class="nav-link">Home</a>
            <a href="dashboard.html" class="nav-link">Dashboard</a>
            <a href="profile.html" class="nav-link">Profile</a>
            <a href="about.html" class="nav-link">About</a>
            ${currentUser.role === 'instructor' ? '<a href="create-exam.html" class="nav-link">Create Exam</a><a href="manage-exams.html" class="nav-link">Manage Exams</a>' : ''}
            <a href="#" class="nav-link" onclick="logout()">Logout</a>
        `;
    } else {
        navMenu.innerHTML = `
            <a href="index.html" class="nav-link active">Home</a>
            <a href="about.html" class="nav-link">About</a>
            <a href="login.html" class="nav-link">Login</a>
        `;
    }
}

async function login(event) {
  console.log('Login function called');
  event.preventDefault();
    
    const form = event.target;
    const formData = new FormData(form);
    
    try {
        showLoading();
        
        const response = await fetch(`${API_BASE_URL}/api/login`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                username: formData.get('username'),
                password: formData.get('password')
            })
        });
        
        const data = await response.json();
        
        if (response.ok && data.status === 'success') {
            localStorage.setItem('token', data.data.token);
            currentUser = data.data.user;
            showMessage('Login successful!', 'success');
            setTimeout(() => {
                window.location.href = 'dashboard.html';
            }, 1000);
        } else {
            showMessage(data.message || 'Login failed. Please check your credentials.', 'error');
        }
    } catch (error) {
        console.error('Login error:', error);
        showMessage('An error occurred. Please try again.', 'error');
    } finally {
        hideLoading();
    }
}

async function logout() {
    try {
        const token = localStorage.getItem('token');
        if (token) {
            await fetch(`${API_BASE_URL}/api/logout`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`
                }
            });
        }
        localStorage.removeItem('token');
        currentUser = null;
        window.location.href = 'index.html';
    } catch (error) {
        console.error('Logout error:', error);
    }
}

// Dashboard functions
async function loadDashboard() {
    if (!currentUser) {
        window.location.href = 'login.html';
        return;
    }
    try {
        showLoading();
        const token = localStorage.getItem('token');
        const response = await fetch('http://localhost:3000/api/dashboard/dashboard', {
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });
        const data = await response.json();
        if (data.success) {
            displayDashboardStats(data.stats);
        } else {
            showMessage(data.message || 'Failed to load dashboard stats', 'error');
        }
    } catch (error) {
        console.error('Dashboard error:', error);
        showMessage('Error loading dashboard data', 'error');
    } finally {
        hideLoading();
    }
}

function displayDashboardStats(stats) {
    const statsContainer = document.querySelector('.dashboard-stats');
    if (!statsContainer) return;
    
    // Handle case where stats is undefined or null
    if (!stats) {
        console.error('No stats data received');
        return;
    }
    
    if (currentUser.role === 'instructor') {
        statsContainer.innerHTML = `
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-file-alt"></i>
                </div>
                <div class="stat-content">
                    <h3>${stats.total_exams || 0}</h3>
                    <p>Total Exams</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-play-circle"></i>
                </div>
                <div class="stat-content">
                    <h3>${stats.active_exams || 0}</h3>
                    <p>Active Exams</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-content">
                    <h3>${stats.total_students || 0}</h3>
                    <p>Total Students</p>
                </div>
            </div>
        `;
    } else {
        statsContainer.innerHTML = `
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-file-alt"></i>
                </div>
                <div class="stat-content">
                    <h3>${stats.total_exams_taken || 0}</h3>
                    <p>Exams Taken</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="stat-content">
                    <h3>${(stats.average_score || 0).toFixed(1)}%</h3>
                    <p>Average Score</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-content">
                    <h3>${stats.available_exams || 0}</h3>
                    <p>Available Exams</p>
                </div>
            </div>
        `;
    }
}

function showDashboardActions() {
    if (currentUser && currentUser.role === 'instructor') {
        const el = document.getElementById('instructor-actions');
        if (el) el.style.display = 'block';
    } else if (currentUser && currentUser.role === 'student') {
        const el1 = document.getElementById('student-available-exams');
        const el2 = document.getElementById('student-results');
        if (el1) el1.style.display = 'block';
        if (el2) el2.style.display = 'block';
    }
}

// Exam functions
async function loadAvailableExams() {
    if (!currentUser) {
        window.location.href = 'login.html';
        return;
    }
    
    try {
        const token = localStorage.getItem('token');
        const response = await fetch(`${API_BASE_URL}/api/exams/available`, {
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });
        const data = await response.json();
        if (data.status === "success" && data.data && Array.isArray(data.data.exams)) {
            displayExams(data.data.exams);
        } else {
            showMessage(data.message || 'No exams found', 'error');
        }
    } catch (error) {
        showMessage('Error loading exams', 'error');
    }
}

function displayExams(exams) {
    const examsContainer = document.querySelector('.exam-list');
    if (!examsContainer) return;
    
    // Debug: Log the exam data
    console.log('Displaying exams:', exams);
    exams.forEach((exam, index) => {
      console.log(`Exam ${index + 1}: ${exam.name} - MCQ: ${exam.mcq_count}, TF: ${exam.tf_count}, Total: ${(exam.mcq_count || 0) + (exam.tf_count || 0)}`);
    });
    
    if (exams.length === 0) {
        examsContainer.innerHTML = `
            <div class="exam-item">
                <div class="exam-info">
                    <h4>No Exams Available</h4>
                    <p>You have either completed all available exams or there are no exams currently available for your branch and track.</p>
                    <p>Check back later for new exams or contact your instructor if you believe this is an error.</p>
                </div>
            </div>
        `;
        return;
    }
    
    examsContainer.innerHTML = exams.map(exam => `
        <div class="exam-item">
            <div class="exam-info">
                <h4>${exam.name}</h4>
                <p>Course: ${exam.course_name}</p>
                <p>Questions: ${(exam.mcq_count || 0) + (exam.tf_count || 0)}</p>
                <p>Available until: ${new Date(exam.end_date).toLocaleString()}</p>
            </div>
            <button class="btn btn-primary" onclick="startExam(${exam.id})">Start Exam</button>
        </div>
    `).join('');
}

async function startExam(examId) {
    try {
        showLoading();
        const token = localStorage.getItem('token');
        const response = await fetch(`${API_BASE_URL}/api/exams/${examId}/start`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            }
        });
        
        const data = await response.json();
        
        if (data.status === 'success') {
            // Get exam questions after starting the exam
            const questionsResponse = await fetch(`${API_BASE_URL}/api/exams/${examId}/questions`, {
                headers: {
                    'Authorization': `Bearer ${token}`
                }
            });
            const questionsData = await questionsResponse.json();
            
            currentExam = {
                id: examId,
                student_exam_id: data.data.examSession.Student_Exam_ID,
                questions: questionsData.data
            };
            
            // Store exam data in sessionStorage
            sessionStorage.setItem('currentExam', JSON.stringify(currentExam));
            window.location.href = 'exam.html';
        } else {
            showMessage(data.message, 'error');
        }
    } catch (error) {
        showMessage('Error starting exam', 'error');
    } finally {
        hideLoading();
    }
}

function loadExam() {
    const examData = sessionStorage.getItem('currentExam');
    if (!examData) {
        window.location.href = 'dashboard.html';
        return;
    }
    
    currentExam = JSON.parse(examData);
    displayExam();
    startExamTimer();
}

function displayExam() {
    const examContainer = document.querySelector('.exam-container');
    if (!examContainer || !currentExam) return;
    
    const questions = currentExam.questions;
    let examHTML = `
        <div class="exam-header">
            <h2>Exam in Progress</h2>
            <p>Total Questions: ${questions.length}</p>
        </div>
        <div class="exam-timer" id="examTimer">
            Time Remaining: <span id="timerDisplay">--:--</span>
        </div>
        <form id="examForm">
    `;
    
    questions.forEach((question, index) => {
        examHTML += `
            <div class="question">
                <h3>Question ${index + 1}</h3>
                <p>${question.question_text}</p>
                <div class="options">
        `;
        
        if (question.question_type === 'mcq') {
            const options = ['A', 'B', 'C', 'D'];
            options.forEach(option => {
                const optionText = question[`option_${option.toLowerCase()}`];
                if (optionText) {
                    examHTML += `
                        <div class="option" onclick="selectOption(this, '${option}')">
                            <strong>${option}.</strong> ${optionText}
                        </div>
                    `;
                }
            });
        } else {
            examHTML += `
                <div class="option" onclick="selectOption(this, 'T')">
                    <strong>True</strong>
                </div>
                <div class="option" onclick="selectOption(this, 'F')">
                    <strong>False</strong>
                </div>
            `;
        }
        
        examHTML += `
                </div>
                <input type="hidden" name="question_${question.id}" id="answer_${question.id}">
            </div>
        `;
    });
    
    examHTML += `
            <button type="submit" class="btn btn-primary">Submit Exam</button>
        </form>
    `;
    
    examContainer.innerHTML = examHTML;
}

function selectOption(element, value) {
    // Remove selection from other options in the same question
    const question = element.closest('.question');
    question.querySelectorAll('.option').forEach(opt => opt.classList.remove('selected'));
    
    // Select this option
    element.classList.add('selected');
    
    // Store the answer
    const questionId = element.closest('.question').querySelector('input[type="hidden"]').name.replace('question_', '');
    document.getElementById(`answer_${questionId}`).value = value;
}

function startExamTimer() {
    examStartTime = Date.now();
    const duration = 60 * 60 * 1000; // 1 hour in milliseconds
    
    examTimer = setInterval(() => {
        const elapsed = Date.now() - examStartTime;
        const remaining = duration - elapsed;
        
        if (remaining <= 0) {
            clearInterval(examTimer);
            submitExam();
            return;
        }
        
        const minutes = Math.floor(remaining / 60000);
        const seconds = Math.floor((remaining % 60000) / 1000);
        document.getElementById('timerDisplay').textContent = 
            `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    }, 1000);
}

async function submitExam(event) {
    if (event) event.preventDefault();
    
    try {
        showLoading();
        const token = localStorage.getItem('token');
        // Collect all answers
        const answers = [];
        currentExam.questions.forEach(question => {
            const answer = document.getElementById(`answer_${question.id}`).value;
            if (answer) {
                answers.push({
                    question_id: question.id,
                    answer: answer
                });
            }
        });
        
        const response = await fetch(`${API_BASE_URL}/api/exams/${currentExam.id}/submit`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify({
                answers: answers
            })
        });
        
        const data = await response.json();
        
        if (data.status === 'success') {
            clearInterval(examTimer);
            sessionStorage.removeItem('currentExam');
            showMessage('Exam submitted successfully!', 'success');
            setTimeout(() => {
                window.location.href = 'results.html';
            }, 2000);
        } else {
            showMessage(data.message || 'Failed to submit exam', 'error');
        }
    } catch (error) {
        console.error('Error submitting exam:', error);
        showMessage('Error submitting exam. Please try again.', 'error');
    } finally {
        hideLoading();
    }
}

// Results functions
async function loadResults() {
    if (!currentUser) {
        window.location.href = 'login.html';
        return;
    }
    
    try {
        const token = localStorage.getItem('token');
        const response = await fetch(`${API_BASE_URL}/api/student-results`, {
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });
        const data = await response.json();
        
        if (data.success) {
            displayResults(data.results);
        }
    } catch (error) {
        showMessage('Error loading results', 'error');
    }
}

function displayResults(results) {
    const resultsContainer = document.querySelector('.results-container');
    if (!resultsContainer) return;
    
    if (results.length === 0) {
        resultsContainer.innerHTML = '<p>No exam results found.</p>';
        return;
    }
    
    const resultsHTML = results.map(result => `
        <div class="result-item">
            <h4>${result.exam_name}</h4>
            <p>Course: ${result.course_name}</p>
            <p>Completed: ${new Date(result.end_time).toLocaleString()}</p>
            <p>Time Spent: ${Math.floor(result.time_spent / 60)} minutes</p>
            <div class="score">Score: ${result.score.toFixed(1)}%</div>
        </div>
    `).join('');
    
    resultsContainer.innerHTML = resultsHTML;
}

// Profile functions
async function loadProfile() {
    if (!currentUser) {
        window.location.href = 'login.html';
        return;
    }
    
    document.getElementById('fullName').value = currentUser.full_name;
    document.getElementById('email').value = currentUser.email;
    document.getElementById('username').value = currentUser.username;
    document.getElementById('role').value = currentUser.role;
}

async function updateProfile(event) {
    event.preventDefault();
    
    const form = event.target;
    const formData = new FormData(form);
    
    try {
        showLoading();
        const token = localStorage.getItem('token');
        const response = await fetch(`${API_BASE_URL}/api/profile`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify({
                full_name: formData.get('full_name'),
                email: formData.get('email')
            })
        });
        
        const data = await response.json();
        
        if (data.success) {
            currentUser.full_name = formData.get('full_name');
            currentUser.email = formData.get('email');
            showMessage('Profile updated successfully!', 'success');
        } else {
            showMessage(data.message, 'error');
        }
    } catch (error) {
        showMessage('Error updating profile', 'error');
    } finally {
        hideLoading();
    }
}

// Utility functions
function showMessage(message, type = 'info') {
    // Create or get the floating notification container
    let notificationContainer = document.getElementById('notification-container');
    if (!notificationContainer) {
        notificationContainer = document.createElement('div');
        notificationContainer.id = 'notification-container';
        document.body.appendChild(notificationContainer);
    }

    // Create the message div
    const messageDiv = document.createElement('div');
    messageDiv.className = `message ${type}`;
    messageDiv.textContent = message;

    // Add to the container
    notificationContainer.appendChild(messageDiv);

    // Remove after 5 seconds
    setTimeout(() => {
        messageDiv.remove();
        // Remove container if empty
        if (notificationContainer.children.length === 0) {
            notificationContainer.remove();
        }
    }, 5000);
}

function showLoading() {
    const loadingDiv = document.createElement('div');
    loadingDiv.className = 'loading-overlay';
    loadingDiv.innerHTML = '<div class="spinner"></div>';
    document.body.appendChild(loadingDiv);
}

function hideLoading() {
    const loadingDiv = document.querySelector('.loading-overlay');
    if (loadingDiv) {
        loadingDiv.remove();
    }
}

function setupNavigation() {
    // Add mobile menu toggle if needed
    const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
    if (mobileMenuToggle) {
        mobileMenuToggle.addEventListener('click', () => {
            const navMenu = document.querySelector('.nav-menu');
            navMenu.classList.toggle('active');
        });
    }
}

// Page-specific functions
function initializePage() {
    const currentPage = window.location.pathname.split('/').pop();
    
    switch (currentPage) {
        case 'dashboard.html':
            loadDashboard();
            break;
        case 'exams.html':
            loadAvailableExams();
            break;
        case 'exam.html':
            loadExam();
            break;
        case 'results.html':
            loadResults();
            break;
        case 'profile.html':
            loadProfile();
            break;
    }
}

window.showMessage = showMessage;
window.showLoading = showLoading;
window.hideLoading = hideLoading;