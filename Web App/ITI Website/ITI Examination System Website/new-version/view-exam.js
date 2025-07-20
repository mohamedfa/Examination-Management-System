let examForView = null;
let questionsForView = [];

// On page load
window.addEventListener('DOMContentLoaded', () => {
    loadExamForView();
});

async function loadExamForView() {
    try {
        // Get exam ID from URL parameters
        const urlParams = new URLSearchParams(window.location.search);
        const examId = urlParams.get('examId');
        
        if (!examId) {
            showMessage('No exam ID provided', 'error');
            setTimeout(() => goBack(), 2000);
            return;
        }

        showLoading();
        const token = localStorage.getItem('token');
        
        if (!token) {
            showMessage('Authentication required', 'error');
            setTimeout(() => window.location.href = 'login.html', 2000);
            return;
        }
        
        const response = await fetch(`${API_BASE_URL}/api/exams/${examId}/view`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        
        const data = await response.json();
        
        if (response.ok && data.status === 'success') {
            examForView = data.data.exam;
            questionsForView = data.data.questions;
            renderExamPreview();
        } else {
            showMessage(data.message || 'Failed to load exam', 'error');
            setTimeout(() => goBack(), 2000);
        }
    } catch (error) {
        console.error('Error loading exam:', error);
        showMessage('Network error while loading exam', 'error');
        setTimeout(() => goBack(), 2000);
    } finally {
        hideLoading();
    }
}

function renderExamPreview() {
    const container = document.getElementById('examPreviewContainer');
    
    if (!examForView || !questionsForView.length) {
        container.innerHTML = '<p>No exam content available.</p>';
        return;
    }

    let html = `
        <div class="exam-preview">
            <div class="exam-header-preview">
                <h2>${examForView.name}</h2>
                <div class="exam-meta">
                    <p><strong>Total Marks:</strong> ${examForView.total_marks}</p>
                    <p><strong>Start Date:</strong> ${new Date(examForView.start_date).toLocaleString()}</p>
                    <p><strong>End Date:</strong> ${new Date(examForView.end_date).toLocaleString()}</p>
                    <p><strong>Total Questions:</strong> ${questionsForView.length}</p>
                </div>
            </div>
            
            <div class="exam-instructions-preview">
                <h3>Instructions:</h3>
                <ul>
                    <li>Read each question carefully before answering</li>
                    <li>For MCQ questions, select the best answer</li>
                    <li>For True/False questions, select either True or False</li>
                    <li>Each question has a specific mark value</li>
                    <li>You cannot go back to previous questions once submitted</li>
                </ul>
            </div>
            
            <div class="questions-preview">
    `;

    questionsForView.forEach((question, index) => {
        html += `
            <div class="question-preview">
                <div class="question-header-preview">
                    <h4>Question ${index + 1} (${question.marks} marks)</h4>
                    <span class="question-type-badge">${question.question_type}</span>
                </div>
                <div class="question-content-preview">
                    <p>${question.question_text}</p>
        `;

        if (question.question_type === 'MCQ' && question.choices) {
            html += '<div class="options-preview">';
            question.choices.forEach((choice, choiceIndex) => {
                const optionLabel = String.fromCharCode(65 + choiceIndex); // A, B, C, D...
                html += `
                    <div class="option-preview">
                        <span class="option-label">${optionLabel}.</span>
                        <span class="option-text">${choice}</span>
                    </div>
                `;
            });
            html += '</div>';
        } else if (question.question_type === 'True/False') {
            html += `
                <div class="options-preview">
                    <div class="option-preview">
                        <span class="option-label">A.</span>
                        <span class="option-text">True</span>
                    </div>
                    <div class="option-preview">
                        <span class="option-label">B.</span>
                        <span class="option-text">False</span>
                    </div>
                </div>
            `;
        }

        html += `
                </div>
            </div>
        `;
    });

    html += `
            </div>
        </div>
    `;

    container.innerHTML = html;
}

function goBack() {
    window.location.href = 'manage-exams.html';
}

function printExam() {
    const printWindow = window.open('', '_blank');
    const examContent = document.querySelector('.exam-preview').innerHTML;
    
    printWindow.document.write(`
        <!DOCTYPE html>
        <html>
        <head>
            <title>${examForView.name} - Exam</title>
            <style>
                body { font-family: Arial, sans-serif; margin: 20px; }
                .exam-header-preview { text-align: center; margin-bottom: 30px; }
                .exam-meta { margin-bottom: 20px; }
                .exam-instructions-preview { margin-bottom: 30px; }
                .question-preview { margin-bottom: 30px; page-break-inside: avoid; }
                .question-header-preview { margin-bottom: 10px; }
                .question-type-badge { background: #f0f0f0; padding: 2px 8px; border-radius: 3px; font-size: 12px; }
                .options-preview { margin-top: 10px; }
                .option-preview { margin: 5px 0; }
                .option-label { font-weight: bold; margin-right: 10px; }
                @media print {
                    .exam-actions { display: none; }
                }
            </style>
        </head>
        <body>
            ${examContent}
        </body>
        </html>
    `);
    
    printWindow.document.close();
    printWindow.print();
} 