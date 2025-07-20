let instructorExams = [];
let selectedExamId = null;

// On page load
window.addEventListener('DOMContentLoaded', () => {
    loadInstructorExams();
});

async function loadInstructorExams() {
    try {
        showLoading();
        const token = localStorage.getItem('token');
        const response = await fetch(`${API_BASE_URL}/api/exams`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        const data = await response.json();
        if (response.ok && data.status === 'success') {
            instructorExams = data.data.exams || [];
            renderExamsTable();
        } else {
            showMessage(data.message || 'Failed to load exams', 'error');
            document.getElementById('examsTableContainer').innerHTML = '<p>No exams found.</p>';
        }
    } catch (error) {
        showMessage('Network error while loading exams', 'error');
        document.getElementById('examsTableContainer').innerHTML = '<p>Error loading exams.</p>';
    } finally {
        hideLoading();
    }
}

function renderExamsTable() {
    const container = document.getElementById('examsTableContainer');
    if (!instructorExams.length) {
        container.innerHTML = '<p>No exams found.</p>';
        return;
    }
    let html = `<table class="exams-table">
        <thead><tr>
            <th>Name</th>
            <th>Course</th>
            <th>Track</th>
            <th>Branch</th>
            <th>Total Marks</th>
            <th>MCQ</th>
            <th>TF</th>
            <th>Start</th>
            <th>End</th>
            <th>Actions</th>
        </tr></thead>
        <tbody>`;
    instructorExams.forEach(exam => {
        html += `<tr>
            <td>${exam.name}</td>
            <td>${exam.course_name || ''}</td>
            <td>${exam.track_name || ''}</td>
            <td>${exam.branch_name || ''}</td>
            <td>${exam.total_marks || 0}</td>
            <td>${exam.mcq_count || 0}</td>
            <td>${exam.tf_count || 0}</td>
            <td>${new Date(exam.start_date).toLocaleString()}</td>
            <td>${new Date(exam.end_date).toLocaleString()}</td>
            <td>
                <button class="btn" onclick="viewExam('${exam.id}')">View</button>
                <button class="btn" onclick="openEditExamModal('${exam.id}')">Edit</button>
                <button class="btn btn-danger" onclick="openDeleteExamModal('${exam.id}')">Delete</button>
            </td>
        </tr>`;
    });
    html += '</tbody></table>';
    container.innerHTML = html;
}

function openEditExamModal(examId) {
    const exam = instructorExams.find(e => e.id == examId);
    if (!exam) return;
    selectedExamId = examId;
    document.getElementById('edit_exam_id').value = exam.id;
    document.getElementById('edit_exam_name').value = exam.name;
    document.getElementById('edit_mcq_count').value = exam.mcq_count;
    document.getElementById('edit_tf_count').value = exam.tf_count;
    document.getElementById('edit_start_date').value = exam.start_date.slice(0,16);
    document.getElementById('edit_end_date').value = exam.end_date.slice(0,16);
    if (document.getElementById('edit_exam_total_marks')) {
        document.getElementById('edit_exam_total_marks').value = exam.total_marks;
    }
    // Only populate branch id field
    if (document.getElementById('edit_branch_id')) {
        document.getElementById('edit_branch_id').value = String(exam.branch_id || '');
    }
    document.getElementById('editExamModal').style.display = 'block';
}

function closeEditExamModal() {
    document.getElementById('editExamModal').style.display = 'none';
}

function formatDateForSQL(input) {
    // input: "2024-06-10T10:00" or "2024-06-10T10:00:00"
    if (!input) return null;
    // If already has seconds, just replace T with space
    if (input.length === 19) return input.replace('T', ' ');
    // If only has hours and minutes, add :00 seconds
    return input.replace('T', ' ') + ':00';
}

document.getElementById('editExamForm').addEventListener('submit', async function(event) {
    event.preventDefault();
    try {
        showLoading();
        const token = localStorage.getItem('token');
        const examId = document.getElementById('edit_exam_id').value;
        const branchIdField = document.getElementById('edit_branch_id');
        if (!branchIdField || !branchIdField.value) {
            showMessage('Branch is required.', 'error');
            hideLoading();
            return;
        }
        const totalMarksField = document.getElementById('edit_exam_total_marks');
        const updatedExam = {
            exam_name: document.getElementById('edit_exam_name').value,
            exam_total_marks: parseInt(totalMarksField.value),
            exam_start_date: formatDateForSQL(document.getElementById('edit_start_date').value),
            exam_end_date: formatDateForSQL(document.getElementById('edit_end_date').value),
            branch_id: parseInt(branchIdField.value),
            num_mcq: parseInt(document.getElementById('edit_mcq_count').value),
            num_tf: parseInt(document.getElementById('edit_tf_count').value)
        };
        const response = await fetch(`${API_BASE_URL}/api/exams/${examId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify(updatedExam)
        });
        const data = await response.json();
        if (response.ok && data.status === 'success') {
            showMessage('Exam updated successfully!', 'success');
            closeEditExamModal();
            loadInstructorExams();
        } else {
            showMessage(data.message || 'Failed to update exam', 'error');
        }
    } catch (error) {
        showMessage('Network error while updating exam', 'error');
    } finally {
        hideLoading();
    }
});

function openDeleteExamModal(examId) {
    selectedExamId = examId;
    document.getElementById('deleteExamModal').style.display = 'block';
}

function closeDeleteExamModal() {
    document.getElementById('deleteExamModal').style.display = 'none';
}

document.getElementById('confirmDeleteExamBtn').addEventListener('click', async function() {
    if (!selectedExamId) return;
    try {
        showLoading();
        const token = localStorage.getItem('token');
        const response = await fetch(`${API_BASE_URL}/api/exams/${selectedExamId}`, {
            method: 'DELETE',
            headers: { 'Authorization': `Bearer ${token}` }
        });
        const data = await response.json();
        if (response.ok && data.status === 'success') {
            showMessage('Exam deleted successfully!', 'success');
            closeDeleteExamModal();
            loadInstructorExams();
        } else {
            showMessage(data.message || 'Failed to delete exam', 'error');
        }
    } catch (error) {
        showMessage('Network error while deleting exam', 'error');
    } finally {
        hideLoading();
    }
});

function viewExam(examId) {
    window.location.href = `view-exam.html?examId=${examId}`;
} 