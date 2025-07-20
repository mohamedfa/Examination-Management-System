# ITI Examination System - Backend API

A Node.js/Express backend API for the ITI Examination System, providing authentication, exam management, and result tracking for both students and instructors.

## 🚀 Features

- **Authentication & Authorization**: JWT-based authentication with role-based access control
- **Exam Management**: Create, read, update, delete exams (instructors only)
- **Question Management**: Add, edit, delete questions for exams
- **Exam Taking**: Students can start and submit exams
- **Result Tracking**: View and manage exam results
- **Security**: Rate limiting, CORS, helmet security headers
- **Database**: SQL Server integration with stored procedures

## 📋 Prerequisites

- Node.js (v14 or higher)
- SQL Server
- Your ITI Examination System database

## 🛠️ Installation

1. **Navigate to the backend directory:**
   ```bash
   cd "ITI Examination System Website/backend"
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Set up environment variables:**
   ```bash
   # Copy the example environment file
   cp env.example .env
   
   # Edit .env with your database credentials
   ```

4. **Configure your .env file:**
   ```env
   # Server Configuration
   PORT=3000
   NODE_ENV=development
   
   # Database Configuration
   DB_SERVER=localhost
   DB_DATABASE=ITI_Examination_System
   DB_USER=your_username
   DB_PASSWORD=your_password
   DB_PORT=1433
   
   # JWT Configuration
   JWT_SECRET=your_super_secret_jwt_key_change_this_in_production
   JWT_EXPIRES_IN=24h
   
   # CORS Configuration
   CORS_ORIGIN=http://localhost:5500
   ```

## 🚀 Running the Server

### Development Mode
```bash
npm run dev
```

### Production Mode
```bash
npm start
```

The server will start on `http://localhost:3000`

## 📚 API Endpoints

### Authentication
- `POST /api/register` - Register a new user
- `POST /api/login` - Login and receive JWT token
- `POST /api/logout` - Logout (protected)

### User Management
- `GET /api/profile` - Get user profile (protected)
- `PUT /api/profile` - Update user profile (protected)
- `PUT /api/change-password` - Change password (protected)

### Exam Management
- `GET /api/exams` - List all exams (protected)
- `GET /api/exams/:id` - Get exam details (protected)
- `POST /api/exams` - Create new exam (instructor only)
- `PUT /api/exams/:id` - Update exam (instructor only)
- `DELETE /api/exams/:id` - Delete exam (instructor only)
- `POST /api/exams/:id/start` - Start exam (student only)
- `POST /api/exams/:id/submit` - Submit exam (student only)

### Question Management
- `GET /api/exams/:examId/questions` - Get exam questions (protected)
- `GET /api/questions/:id` - Get question details (protected)
- `POST /api/exams/:examId/questions` - Add question (instructor only)
- `PUT /api/questions/:id` - Update question (instructor only)
- `DELETE /api/questions/:id` - Delete question (instructor only)

### Results Management
- `GET /api/results` - Get user results (student only)
- `GET /api/results/:examId` - Get specific exam result (student only)
- `GET /api/exams/:examId/results` - Get all results for exam (instructor only)
- `GET /api/results/:resultId/details` - Get result details (protected)
- `PUT /api/results/:resultId/questions/:questionId/grade` - Grade essay question (instructor only)
- `GET /api/exams/:examId/results/export` - Export results (instructor only)

## 🔐 Authentication

All protected endpoints require a JWT token in the Authorization header:
```
Authorization: Bearer <your_jwt_token>
```

## 👥 User Roles

- **Student**: Can take exams, view their results
- **Instructor**: Can create/manage exams, view all results, grade essays

## 🗄️ Database Integration

The backend uses stored procedures for all database operations. Make sure your SQL Server database has the following stored procedures:

### Authentication
- `RegisterUser`
- `AuthenticateUser`

### User Management
- `GetUserProfile`
- `UpdateUserProfile`
- `ChangePassword`

### Exam Management
- `CreateExam`
- `GetAllExams`
- `GetExamById`
- `UpdateExam`
- `DeleteExam`
- `StartExam`
- `SubmitExam`

### Question Management
- `AddQuestion`
- `GetExamQuestions`
- `UpdateQuestion`
- `DeleteQuestion`
- `GetQuestionById`

### Results Management
- `GetUserResults`
- `GetExamResult`
- `GetExamResults`
- `GradeEssayQuestion`
- `GetResultDetails`
- `ExportExamResults`

## 🔧 Development

### Project Structure
```
backend/
├── controllers/          # Request handlers
├── middleware/          # Authentication & authorization
├── routes/             # API route definitions
├── utils/              # Database & JWT utilities
├── app.js              # Express app configuration
├── server.js           # Server startup
├── package.json        # Dependencies
└── README.md          # This file
```

### Adding New Endpoints

1. Create controller function in `controllers/`
2. Add route in appropriate `routes/` file
3. Apply middleware for authentication/authorization
4. Test with your frontend

## 🚨 Security Features

- **Rate Limiting**: Prevents abuse
- **CORS**: Configured for frontend integration
- **Helmet**: Security headers
- **JWT**: Secure token-based authentication
- **Input Validation**: Request validation in controllers
- **SQL Injection Protection**: Parameterized queries via stored procedures

## 📝 Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | Server port | 3000 |
| `NODE_ENV` | Environment | development |
| `DB_SERVER` | SQL Server host | localhost |
| `DB_DATABASE` | Database name | ITI_Examination_System |
| `DB_USER` | Database username | - |
| `DB_PASSWORD` | Database password | - |
| `DB_PORT` | Database port | 1433 |
| `JWT_SECRET` | JWT signing secret | - |
| `JWT_EXPIRES_IN` | Token expiration | 24h |
| `CORS_ORIGIN` | Allowed origin | http://localhost:5500 |

## 🤝 Frontend Integration

The backend is configured to work with your existing frontend. Update your frontend JavaScript files to make API calls to these endpoints.

### Example Frontend Integration
```javascript
// Login example
const response = await fetch('/api/login', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    username: 'student1',
    password: 'password123'
  })
});

const data = await response.json();
localStorage.setItem('token', data.data.token);
```

## 🐛 Troubleshooting

1. **Database Connection Issues**: Check your SQL Server credentials in `.env`
2. **CORS Errors**: Verify `CORS_ORIGIN` matches your frontend URL
3. **JWT Errors**: Ensure `JWT_SECRET` is set and consistent
4. **Stored Procedure Errors**: Verify all required stored procedures exist in your database

## 📞 Support

For issues or questions, check your database stored procedures and ensure all required procedures are implemented according to the API specifications. 

Node.js is not installed on your system. Here's how to install Node.js and start the backend:

## 🚀 **Installing Node.js and Starting the Backend**

### **Step 1: Install Node.js**

1. **Download Node.js:**
   - Go to [https://nodejs.org/](https://nodejs.org/)
   - Download the LTS (Long Term Support) version for Windows
   - Choose the Windows Installer (.msi) file

2. **Install Node.js:**
   - Run the downloaded installer
   - Follow the installation wizard
   - Make sure to check "Add to PATH" during installation
   - Complete the installation

3. **Verify Installation:**
   - Open a new PowerShell window (important!)
   - Run these commands:
   ```powershell
   node --version
   npm --version
   ```

### **Step 2: Set Up Environment Variables**

Before starting the backend, you need to configure your database connection:

1. **Create `.env` file:**
   ```bash
   cd "ITI Examination System Website/backend"
   copy env.example .env
   ```

2. **Edit `.env` file with your database credentials:**
   ```env
   # Server Configuration
   PORT=3000
   NODE_ENV=development
   
   # Database Configuration
   DB_SERVER=localhost
   DB_DATABASE=ITI_Examination_System
   DB_USER=your_username
   DB_PASSWORD=your_password
   DB_PORT=1433
   
   # JWT Configuration
   JWT_SECRET=your_super_secret_jwt_key_change_this_in_production
   JWT_EXPIRES_IN=24h
   
   # CORS Configuration
   CORS_ORIGIN=http://localhost:5500
   ```

### **Step 3: Install Dependencies and Start Server**

Once Node.js is installed, run these commands:

```bash
# Navigate to backend directory
cd "ITI Examination System Website/backend"

# Install dependencies
npm install

# Start the server in development mode
npm run dev
```

### **Step 4: Verify Backend is Running**

You should see output like:
```
🚀 Server is running on port 3000
📊 Environment: development
 API Base URL: http://localhost:3000/api
✅ Database connected successfully
```

### **Step 5: Test the API**

Once the server is running, you can test it:

1. **Health Check:** Open your browser and go to `http://localhost:3000/health`
2. **API Test:** Try accessing `http://localhost:3000/api` (should show 404, which is expected)

### **🔧 Troubleshooting:**

**If you get database connection errors:**
- Make sure SQL Server is running
- Verify your database credentials in `.env`
- Ensure your database exists and has the required stored procedures

**If you get port conflicts:**
- Change the PORT in `.env` to another port (e.g., 3001)
- Update your frontend API_BASE_URL accordingly

**If npm install fails:**
- Make sure you have a stable internet connection
- Try running `npm cache clean --force` before `npm install`

### **📋 Quick Commands Summary:**

```bash
# After installing Node.js, run these commands:
cd "ITI Examination System Website/backend"
npm install
npm run dev
```

Once you've installed Node.js, let me know and I can help you with the next steps! 

---

## 🛠️ What to Do Next

### 1. **Verify Node.js Installation**

- Open a **new Command Prompt** (not PowerShell).
- Type:
  ```cmd
  node --version
  npm --version
  ```
- If you see version numbers, Node.js and npm are installed.

---

### 2. **If You Get “not recognized” Error**

#### **A. Node.js is Not Installed**

- Download and install Node.js from:  
  [https://nodejs.org/](https://nodejs.org/)
- **Choose the LTS version** and run the installer.
- Make sure to check the box that says **“Add to PATH”** during installation.

#### **B. Node.js is Installed, but Not in PATH**

- You must open a **new terminal window** after installation.
- If it still doesn’t work, restart your computer.

---

### 3. **Try Using Command Prompt (CMD) Instead of PowerShell**

- Press `Win + R`, type `cmd`, and press Enter.
- In the new window, run:
  ```cmd
  node --version
  npm --version
  ```
- If it works, use this window for your project commands.

---

### 4. **If It Still Fails**

- Reinstall Node.js and make sure “Add to PATH” is checked.
- Restart your computer after installation.

---

## ✅ Once It Works

When `npm --version` works, run:

```cmd
<code_block_to_apply_from>
```

---

**Summary:**  
You must have Node.js and npm installed and available in your system PATH.  
If you follow the steps above, you’ll be able to start your backend server.

If you’re still stuck, let me know exactly what you see after running `node --version` and `npm --version` in a new Command Prompt window! 