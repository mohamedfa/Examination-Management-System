// Exam JavaScript for ITI University Examination System
// Updated to integrate with backend API

// Global variables
let currentExam = null;
let currentQuestionIndex = 0;
let userAnswers = {};
let examTimer = null;
let timeRemaining = 0;
let examSessionId = null;

// Initialize exam
document.addEventListener('DOMContentLoaded', function() {
    // Role-based branching
    const userData = App.getUserData();
    if (!userData) {
        window.location.href = 'login.html';
        return;
    }
    if (userData.role === 'student') {
        initStudentExamFlow();
    } else if (userData.role === 'instructor') {
        initInstructorExamFlow();
    } else {
        App.showNotification('Unknown user role', 'error');
        window.location.href = 'login.html';
    }
});

async function initStudentExamFlow() {
    document.getElementById('studentExamSection').style.display = '';
    // Fetch available exams
    try {
        const response = await App.apiRequest('/exams/available');
        const exams = response.data;
        renderExamList(exams);
    } catch (error) {
        App.showNotification('Failed to load available exams', 'error');
    }
}

function renderExamList(exams) {
    const examList = document.getElementById('examList');
    examList.innerHTML = '';
    if (!exams.length) {
        examList.innerHTML = '<p>No available exams.</p>';
        return;
    }
    exams.forEach(exam => {
        const div = document.createElement('div');
        div.className = 'exam-item';
        div.innerHTML = `<strong>${exam.Title || exam.title}</strong> (ID: ${exam.Exam_ID || exam.id}) <button class="btn btn-secondary btn-sm" data-exam-id="${exam.Exam_ID || exam.id}">Take Exam</button>`;
        examList.appendChild(div);
    });
    examList.querySelectorAll('button[data-exam-id]').forEach(btn => {
        btn.addEventListener('click', function() {
            const examId = this.getAttribute('data-exam-id');
            loadExamQuestions(examId);
        });
    });
}

async function loadExamQuestions(examId) {
    try {
        const response = await App.apiRequest(`/exams/${examId}/questions`);
        const questions = response.data;
        document.getElementById('examQuestionsSection').style.display = '';
        document.getElementById('selectedExamTitle').textContent = `Exam ID: ${examId}`;
        renderQuestionsForm(questions, examId);
    } catch (error) {
        App.showNotification('Failed to load exam questions', 'error');
    }
}

function renderQuestionsForm(questions, examId) {
    const form = document.getElementById('examQuestionsForm');
    form.innerHTML = '';
    questions.forEach((q, idx) => {
        const qDiv = document.createElement('div');
        qDiv.className = 'question-block';
        qDiv.innerHTML = `<p><strong>Q${idx + 1}:</strong> ${q.Question_Text || q.questionText}</p>`;
        if (q.type === 'mcq' || q.Question_Type === 'mcq') {
            (q.Choices || q.choices || []).forEach((choice, cidx) => {
                const id = `q${idx}_c${cidx}`;
                qDiv.innerHTML += `<label><input type="radio" name="q${idx}" value="${choice.Choice_ID || cidx}"> ${choice.Choice_Text || choice}</label><br>`;
            });
        } else if (q.type === 'true_false' || q.Question_Type === 'true_false') {
            qDiv.innerHTML += `<label><input type="radio" name="q${idx}" value="true"> True</label> <label><input type="radio" name="q${idx}" value="false"> False</label>`;
        } else if (q.type === 'essay' || q.Question_Type === 'essay') {
            qDiv.innerHTML += `<textarea name="q${idx}" rows="3" placeholder="Your answer..."></textarea>`;
        }
        form.appendChild(qDiv);
    });
    document.getElementById('submitExamBtn').style.display = '';
    document.getElementById('submitExamBtn').onclick = function() {
        submitExamAnswers(questions, examId);
    };
}

async function submitExamAnswers(questions, examId) {
    const form = document.getElementById('examQuestionsForm');
    const answers = [];
    questions.forEach((q, idx) => {
        const name = `q${idx}`;
        const input = form.querySelector(`[name="${name}"]:checked`) || form.querySelector(`[name="${name}"]`);
        answers.push({
            questionId: q.Question_ID || q.id,
            answer: input ? input.value : ''
        });
    });
    try {
        await App.apiRequest(`/exams/${examId}/submit`, {
            method: 'POST',
            body: JSON.stringify({ answers })
        });
        window.location.href = `results.html?examId=${examId}`;
    } catch (error) {
        App.showNotification('Failed to submit exam', 'error');
    }
}

async function initInstructorExamFlow() {
    document.getElementById('instructorExamSection').style.display = '';
    const form = document.getElementById('createExamForm');
    form.onsubmit = async function(e) {
        e.preventDefault();
        const title = document.getElementById('examTitleInput').value;
        const date = document.getElementById('examDateInput').value;
        const trackId = document.getElementById('trackIdInput').value;
        const branchId = document.getElementById('branchIdInput').value;
        try {
            const response = await App.apiRequest('/exams', {
                method: 'POST',
                body: JSON.stringify({ title, date, trackId, branchId })
            });
            const examId = response.data.examId;
            document.getElementById('createdExamSection').style.display = '';
            document.getElementById('createdExamId').textContent = examId;
            setupGenerateQuestionsBtn(examId);
        } catch (error) {
            App.showNotification('Failed to create exam', 'error');
        }
    };
}

function setupGenerateQuestionsBtn(examId) {
    const btn = document.getElementById('generateQuestionsBtn');
    btn.onclick = async function() {
        try {
            const response = await App.apiRequest(`/exams/${examId}/generate-questions`, { method: 'POST' });
            document.getElementById('generationStatus').textContent = 'Questions generated successfully!';
        } catch (error) {
            document.getElementById('generationStatus').textContent = 'Failed to generate questions.';
        }
    };
}

async function initializeExam() {
    try {
        // Get exam ID from URL parameters
        const urlParams = new URLSearchParams(window.location.search);
        const examId = urlParams.get('examId');
        
        if (!examId) {
            showError('No exam ID provided');
            return;
        }

        // Start the exam session
        await startExamSession(examId);
        
        // Load exam data from API
        await loadExamData(examId);
        
        // Initialize UI
        updateExamHeader();
        generateQuestionNavigator();
        loadQuestion(0);
        startTimer();
        
        // Setup event listeners
        setupExamEventListeners();
        
        // Prevent page refresh/back
        preventPageNavigation();
        
    } catch (error) {
        console.error('Failed to initialize exam:', error);
        showError('Failed to load exam. Please try again.');
    }
}

async function startExamSession(examId) {
    try {
        const token = AuthSystem.getAuthToken();
        const response = await fetch(`${Utils.getApiBaseUrl()}/exams/${examId}/start`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            }
        });

        if (!response.ok) {
            throw new Error('Failed to start exam session');
        }

        const data = await response.json();
        examSessionId = data.data.examSession?.SessionId;
        
    } catch (error) {
        console.error('Failed to start exam session:', error);
        throw error;
    }
}

async function loadExamData(examId) {
    try {
        const token = AuthSystem.getAuthToken();
        
        // Get exam details
        const examResponse = await fetch(`${Utils.getApiBaseUrl()}/exams/${examId}`, {
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });

        if (!examResponse.ok) {
            throw new Error('Failed to load exam details');
        }

        const examData = await examResponse.json();
        currentExam = examData.data.exam;

        // Get exam questions
        const questionsResponse = await fetch(`${Utils.getApiBaseUrl()}/exams/${examId}/questions`, {
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });

        if (!questionsResponse.ok) {
            throw new Error('Failed to load exam questions');
        }

        const questionsData = await questionsResponse.json();
        currentExam.questions = questionsData.data.questions;
        currentExam.totalQuestions = currentExam.questions.length;
        
        // Set time remaining
        timeRemaining = currentExam.duration * 60; // Convert to seconds
        
    } catch (error) {
        console.error('Failed to load exam data:', error);
        throw error;
    }
}

function updateExamHeader() {
    const examTitle = document.getElementById('examTitle');
    const totalQuestionCount = document.getElementById('totalQuestionCount');
    
    if (examTitle) {
        examTitle.textContent = currentExam.title;
    }
    
    if (totalQuestionCount) {
        totalQuestionCount.textContent = currentExam.totalQuestions;
    }
}

function generateQuestionNavigator() {
    const questionGrid = document.getElementById('questionGrid');
    if (!questionGrid) return;
    
    questionGrid.innerHTML = '';
    
    for (let i = 0; i < currentExam.totalQuestions; i++) {
        const questionNumber = document.createElement('div');
        questionNumber.className = 'question-number';
        questionNumber.textContent = i + 1;
        questionNumber.addEventListener('click', () => navigateToQuestion(i));
        
        questionGrid.appendChild(questionNumber);
    }
}

function loadQuestion(index) {
    if (index < 0 || index >= currentExam.questions.length) return;
    
    currentQuestionIndex = index;
    const question = currentExam.questions[index];
    
    // Update question display
    updateQuestionDisplay(question);
    updateQuestionNavigator();
    updateProgress();
}

function updateQuestionDisplay(question) {
    const questionText = document.getElementById('questionText');
    const questionType = document.getElementById('questionType');
    const questionOptions = document.getElementById('questionOptions');
    const currentQuestionNumber = document.getElementById('currentQuestionNumber');
    
    if (questionText) {
        questionText.textContent = question.questionText || question.question;
    }
    
    if (currentQuestionNumber) {
        currentQuestionNumber.textContent = currentQuestionIndex + 1;
    }
    
    if (questionType) {
        questionType.textContent = question.questionType || question.type;
    }
    
    if (questionOptions) {
        questionOptions.innerHTML = '';
        
        if (question.questionType === 'multiple_choice' || question.type === 'mcq') {
            const options = question.options || [];
            options.forEach((option, index) => {
                const optionElement = createMCQOption(option, index, question.id);
                questionOptions.appendChild(optionElement);
            });
        } else if (question.questionType === 'true_false' || question.type === 'true_false') {
            const trueOption = createTrueFalseOption(true, question.id);
            const falseOption = createTrueFalseOption(false, question.id);
            questionOptions.appendChild(trueOption);
            questionOptions.appendChild(falseOption);
        } else if (question.questionType === 'essay' || question.type === 'essay') {
            const textarea = document.createElement('textarea');
            textarea.id = `answer-${question.id}`;
            textarea.className = 'essay-answer';
            textarea.placeholder = 'Type your answer here...';
            textarea.rows = 6;
            textarea.addEventListener('input', (e) => {
                saveAnswer(question.id, e.target.value);
            });
            questionOptions.appendChild(textarea);
        }
        
        // Load saved answer
        loadUserAnswer(question.id);
    }
}

function createMCQOption(option, index, questionId) {
    const optionDiv = document.createElement('div');
    optionDiv.className = 'option';
    
    const radio = document.createElement('input');
    radio.type = 'radio';
    radio.name = `question-${questionId}`;
    radio.value = index;
    radio.id = `option-${questionId}-${index}`;
    radio.addEventListener('change', () => selectMCQOption(questionId, index));
    
    const label = document.createElement('label');
    label.htmlFor = `option-${questionId}-${index}`;
    label.textContent = option;
    
    optionDiv.appendChild(radio);
    optionDiv.appendChild(label);
    
    return optionDiv;
}

function createTrueFalseOption(value, questionId) {
    const optionDiv = document.createElement('div');
    optionDiv.className = 'option';
    
    const radio = document.createElement('input');
    radio.type = 'radio';
    radio.name = `question-${questionId}`;
    radio.value = value;
    radio.id = `option-${questionId}-${value}`;
    radio.addEventListener('change', () => selectTrueFalseOption(questionId, value));
    
    const label = document.createElement('label');
    label.htmlFor = `option-${questionId}-${value}`;
    label.textContent = value ? 'True' : 'False';
    
    optionDiv.appendChild(radio);
    optionDiv.appendChild(label);
    
    return optionDiv;
}

function selectMCQOption(questionId, optionIndex) {
    saveAnswer(questionId, optionIndex);
}

function selectTrueFalseOption(questionId, value) {
    saveAnswer(questionId, value);
}

function loadUserAnswer(questionId) {
    const savedAnswer = userAnswers[questionId];
    if (savedAnswer !== undefined) {
        const question = currentExam.questions[currentQuestionIndex];
        
        if (question.questionType === 'multiple_choice' || question.type === 'mcq') {
            const radio = document.querySelector(`input[name="question-${questionId}"][value="${savedAnswer}"]`);
            if (radio) radio.checked = true;
        } else if (question.questionType === 'true_false' || question.type === 'true_false') {
            const radio = document.querySelector(`input[name="question-${questionId}"][value="${savedAnswer}"]`);
            if (radio) radio.checked = true;
        } else if (question.questionType === 'essay' || question.type === 'essay') {
            const textarea = document.querySelector(`#answer-${questionId}`);
            if (textarea) textarea.value = savedAnswer || '';
        }
    }
}

function updateQuestionNavigator() {
    const questionNumbers = document.querySelectorAll('.question-number');
    questionNumbers.forEach((number, index) => {
        number.classList.remove('current', 'answered');
        
        if (index === currentQuestionIndex) {
            number.classList.add('current');
        } else if (userAnswers[currentExam.questions[index].id] !== undefined) {
            number.classList.add('answered');
        }
    });
}

function updateProgress() {
    const progressBar = document.getElementById('progressBar');
    const progressText = document.getElementById('progressText');
    
    if (progressBar) {
        const progress = (currentQuestionIndex + 1) / currentExam.totalQuestions * 100;
        progressBar.style.width = `${progress}%`;
    }
    
    if (progressText) {
        progressText.textContent = `${currentQuestionIndex + 1} of ${currentExam.totalQuestions}`;
    }
}

function navigateToQuestion(index) {
    loadQuestion(index);
    updateNavigationButtons();
}

function updateNavigationButtons() {
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    
    if (prevBtn) {
        prevBtn.disabled = currentQuestionIndex === 0;
    }
    
    if (nextBtn) {
        nextBtn.disabled = currentQuestionIndex === currentExam.totalQuestions - 1;
    }
}

function setupExamEventListeners() {
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    const submitBtn = document.getElementById('submitBtn');
    const finishBtn = document.getElementById('finishBtn');
    
    if (prevBtn) {
        prevBtn.addEventListener('click', () => {
            if (currentQuestionIndex > 0) {
                loadQuestion(currentQuestionIndex - 1);
                updateNavigationButtons();
            }
        });
    }
    
    if (nextBtn) {
        nextBtn.addEventListener('click', () => {
            if (currentQuestionIndex < currentExam.totalQuestions - 1) {
                loadQuestion(currentQuestionIndex + 1);
                updateNavigationButtons();
            }
        });
    }
    
    if (submitBtn) {
        submitBtn.addEventListener('click', showSubmitModal);
    }
    
    if (finishBtn) {
        finishBtn.addEventListener('click', showSubmitModal);
    }
    
    // Keyboard navigation
    document.addEventListener('keydown', (e) => {
        if (e.key === 'ArrowLeft' && currentQuestionIndex > 0) {
            loadQuestion(currentQuestionIndex - 1);
            updateNavigationButtons();
        } else if (e.key === 'ArrowRight' && currentQuestionIndex < currentExam.totalQuestions - 1) {
            loadQuestion(currentQuestionIndex + 1);
            updateNavigationButtons();
        }
    });
}

function startTimer() {
    examTimer = setInterval(() => {
        timeRemaining--;
        updateTimerDisplay();
        
        if (timeRemaining <= 0) {
            clearInterval(examTimer);
            autoSubmitExam();
        } else if (timeRemaining <= 300) { // 5 minutes warning
            showTimeWarning();
        }
    }, 1000);
}

function updateTimerDisplay() {
    const timerDisplay = document.getElementById('timerDisplay');
    if (timerDisplay) {
        const minutes = Math.floor(timeRemaining / 60);
        const seconds = timeRemaining % 60;
        timerDisplay.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
        
        // Add warning class when time is low
        if (timeRemaining <= 300) {
            timerDisplay.classList.add('warning');
        }
    }
}

function showTimeWarning() {
    if (timeRemaining === 300) { // Show warning only once at 5 minutes
        alert('Warning: You have 5 minutes remaining!');
    }
}

function showSubmitModal() {
    const modal = document.getElementById('submitModal');
    if (modal) {
        modal.style.display = 'block';
        
        // Show submission summary
        const answeredCount = Object.keys(userAnswers).length;
        const totalQuestions = currentExam.totalQuestions;
        
        const summaryText = document.getElementById('submissionSummary');
        if (summaryText) {
            summaryText.textContent = `You have answered ${answeredCount} out of ${totalQuestions} questions. Are you sure you want to submit?`;
        }
    }
}

function hideSubmitModal() {
    const modal = document.getElementById('submitModal');
    if (modal) {
        modal.style.display = 'none';
    }
}

async function submitExam() {
    try {
        // Prepare answers array for API
        const answers = Object.keys(userAnswers).map(questionId => ({
            questionId: parseInt(questionId),
            answer: userAnswers[questionId]
        }));

        const token = AuthSystem.getAuthToken();
        const urlParams = new URLSearchParams(window.location.search);
        const examId = urlParams.get('examId');

        const response = await fetch(`${Utils.getApiBaseUrl()}/exams/${examId}/submit`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ answers })
        });

        if (!response.ok) {
            throw new Error('Failed to submit exam');
        }

        const data = await response.json();
        
        // Stop timer
        if (examTimer) {
            clearInterval(examTimer);
        }

        // Show results
        showResultsModal(data.data.result);
        
    } catch (error) {
        console.error('Failed to submit exam:', error);
        showError('Failed to submit exam. Please try again.');
    }
}

function autoSubmitExam() {
    alert('Time is up! Your exam will be submitted automatically.');
    submitExam();
}

function showResultsModal(results) {
    const modal = document.getElementById('resultsModal');
    if (modal) {
        modal.style.display = 'block';
        
        // Display results
        const scoreElement = document.getElementById('finalScore');
        const percentageElement = document.getElementById('finalPercentage');
        const statusElement = document.getElementById('finalStatus');
        
        if (scoreElement) {
            scoreElement.textContent = `${results.score}/${results.totalMarks}`;
        }
        
        if (percentageElement) {
            const percentage = (results.score / results.totalMarks) * 100;
            percentageElement.textContent = `${percentage.toFixed(1)}%`;
        }
        
        if (statusElement) {
            const percentage = (results.score / results.totalMarks) * 100;
            statusElement.textContent = percentage >= 60 ? 'PASS' : 'FAIL';
            statusElement.className = percentage >= 60 ? 'pass' : 'fail';
        }
        
        // Create results chart if available
        createResultsChart(results);
    }
}

function createResultsChart(results) {
    const chartContainer = document.getElementById('resultsChart');
    if (!chartContainer) return;
    
    // Simple chart implementation
    const percentage = (results.score / results.totalMarks) * 100;
    const chartHTML = `
        <div class="chart">
            <div class="chart-bar" style="width: ${percentage}%"></div>
            <div class="chart-label">${percentage.toFixed(1)}%</div>
        </div>
    `;
    
    chartContainer.innerHTML = chartHTML;
}

function saveAnswer(questionId, answer) {
    userAnswers[questionId] = answer;
    updateQuestionNavigator();
    
    // Save to localStorage as backup
    localStorage.setItem(`exam_answers_${questionId}`, JSON.stringify(answer));
}

function showError(message) {
    const errorDiv = document.getElementById('errorMessage');
    if (errorDiv) {
        errorDiv.textContent = message;
        errorDiv.style.display = 'block';
        setTimeout(() => {
            errorDiv.style.display = 'none';
        }, 5000);
    } else {
        alert(message);
    }
}

function preventPageNavigation() {
    // Prevent back button
    window.history.pushState(null, null, window.location.href);
    window.addEventListener('popstate', function() {
        window.history.pushState(null, null, window.location.href);
    });
    
    // Prevent refresh
    window.addEventListener('beforeunload', function(e) {
        if (Object.keys(userAnswers).length > 0) {
            e.preventDefault();
            e.returnValue = 'Are you sure you want to leave? Your progress will be lost.';
        }
    });
}

function loadSavedSession() {
    // Load saved answers from localStorage
    currentExam.questions.forEach(question => {
        const savedAnswer = localStorage.getItem(`exam_answers_${question.id}`);
        if (savedAnswer) {
            try {
                userAnswers[question.id] = JSON.parse(savedAnswer);
            } catch (error) {
                console.error('Failed to parse saved answer:', error);
            }
        }
    });
} 