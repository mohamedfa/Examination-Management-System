// Results page logic for ITI Examination System

document.addEventListener('DOMContentLoaded', async function() {
    const userData = App.getUserData();
    if (!userData || userData.role !== 'student') {
        window.location.href = 'login.html';
        return;
    }
    const urlParams = new URLSearchParams(window.location.search);
    const examId = urlParams.get('examId');
    if (!examId) {
        App.showNotification('No exam ID provided', 'error');
        return;
    }
    try {
        const response = await App.apiRequest(`/results/${examId}`);
        // TODO: Render result data in the page
        console.log('Exam result:', response.data);
        // Example: document.getElementById('score').textContent = response.data.score;
    } catch (error) {
        App.showNotification('Failed to load exam result', 'error');
    }
}); 