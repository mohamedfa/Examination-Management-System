# ITI University Examination System

A comprehensive online examination system for ITI University, featuring MCQ and True/False questions with a modern, responsive web interface.

## 🎯 Features

### Core Functionality
- **User Authentication**: Secure login/register system with session management
- **Online Exams**: MCQ and True/False question types
- **Real-time Timer**: Configurable exam duration with auto-submission
- **Progress Tracking**: Visual progress indicators and question navigation
- **Results Management**: Detailed exam results with analytics
- **Responsive Design**: Mobile-friendly interface

### User Interface
- **Modern UI**: Clean, professional design with red color scheme
- **Dashboard**: Comprehensive overview of exams and performance
- **Exam Interface**: Intuitive question navigation and answer selection
- **Results Display**: Charts and analytics for performance insights
- **Settings Panel**: Customizable preferences and account management

### Technical Features
- **Session Management**: Automatic session timeout and security
- **Data Persistence**: Local storage for exam progress and results
- **Form Validation**: Client-side validation with error handling
- **Accessibility**: Keyboard navigation and screen reader support
- **Cross-browser Compatibility**: Works on all modern browsers

## 📁 Project Structure

```
app/
├── index.html              # Landing page
├── login.html              # User login
├── register.html           # User registration
├── dashboard.html          # Main dashboard
├── exam.html              # Exam interface
├── results.html           # Results and analytics
├── profile.html           # User profile
├── settings.html          # System settings
├── scripts/
│   ├── main.js           # Core functionality
│   ├── auth.js           # Authentication system
│   └── exam.js           # Exam functionality
└── styles/
    ├── main.css          # Global styles
    ├── auth.css          # Authentication styles
    ├── dashboard.css     # Dashboard styles
    └── exam.css          # Exam interface styles
```

## 🚀 Getting Started

### Prerequisites
- Modern web browser (Chrome, Firefox, Safari, Edge)
- Local web server (optional, for development)

### Installation
1. Clone or download the project files
2. Open `index.html` in your web browser
3. For development, use a local server:
   ```bash
   # Using Python
   python -m http.server 8000
   
   # Using Node.js
   npx serve .
   
   # Using PHP
   php -S localhost:8000
   ```

### Usage
1. **Registration**: Create a new account with student information
2. **Login**: Access your dashboard with email and password
3. **Take Exams**: Navigate to available exams and start testing
4. **View Results**: Check your performance and analytics
5. **Manage Settings**: Customize your preferences

## 🎨 Design System

### Color Scheme
- **Primary Red**: `#dc3545` - Main brand color
- **Secondary Red**: `#c82333` - Hover states and accents
- **Success Green**: `#28a745` - Positive actions
- **Warning Yellow**: `#ffc107` - Warnings and alerts
- **Info Blue**: `#17a2b8` - Information and links
- **Dark Gray**: `#343a40` - Text and backgrounds

### Typography
- **Primary Font**: System default (Arial, Helvetica, sans-serif)
- **Headings**: Bold weights for hierarchy
- **Body Text**: Regular weight for readability

### Components
- **Buttons**: Primary, secondary, outline, and danger variants
- **Cards**: Information containers with shadows
- **Forms**: Consistent input styling with validation
- **Modals**: Overlay dialogs for confirmations
- **Navigation**: Responsive header and sidebar

## 🔧 Configuration

### Database Integration
The system is designed to work with MS SQL Server. Update the API endpoints in `scripts/main.js`:

```javascript
config: {
    apiBaseUrl: 'https://your-api-domain.com/api',
    // ... other config
}
```

### Exam Configuration
Modify exam settings in `scripts/exam.js`:

```javascript
const sampleExam = {
    id: 1,
    title: "Your Exam Title",
    duration: 60, // minutes
    totalQuestions: 20,
    questions: [
        // ... question definitions
    ]
};
```

### Styling Customization
Update colors and styles in the CSS files:
- `styles/main.css` - Global styles and variables
- `styles/auth.css` - Authentication page styles
- `styles/dashboard.css` - Dashboard and navigation styles
- `styles/exam.css` - Exam interface styles

## 📊 Database Schema

### Users Table
```sql
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    StudentID NVARCHAR(20) UNIQUE,
    Department NVARCHAR(50),
    Role NVARCHAR(20) DEFAULT 'student',
    CreatedAt DATETIME DEFAULT GETDATE(),
    LastLogin DATETIME
);
```

### Exams Table
```sql
CREATE TABLE Exams (
    ExamID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500),
    Duration INT NOT NULL, -- minutes
    TotalQuestions INT NOT NULL,
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);
```

### Questions Table
```sql
CREATE TABLE Questions (
    QuestionID INT PRIMARY KEY IDENTITY(1,1),
    ExamID INT FOREIGN KEY REFERENCES Exams(ExamID),
    QuestionType NVARCHAR(20) NOT NULL, -- 'mcq' or 'true_false'
    QuestionText NVARCHAR(1000) NOT NULL,
    Options NVARCHAR(MAX), -- JSON for MCQ options
    CorrectAnswer NVARCHAR(10) NOT NULL,
    QuestionOrder INT NOT NULL
);
```

### ExamResults Table
```sql
CREATE TABLE ExamResults (
    ResultID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    ExamID INT FOREIGN KEY REFERENCES Exams(ExamID),
    Score DECIMAL(5,2) NOT NULL,
    TotalQuestions INT NOT NULL,
    CorrectAnswers INT NOT NULL,
    TimeTaken INT NOT NULL, -- seconds
    SubmittedAt DATETIME DEFAULT GETDATE()
);
```

## 🔒 Security Features

### Authentication
- Password hashing and salting
- JWT token-based sessions
- Session timeout management
- CSRF protection

### Data Protection
- Input validation and sanitization
- SQL injection prevention
- XSS protection
- Secure headers

### Privacy
- GDPR compliance features
- Data export functionality
- Account deletion options
- Privacy settings

## 📱 Responsive Design

The system is fully responsive and works on:
- **Desktop**: Full-featured interface
- **Tablet**: Optimized touch interface
- **Mobile**: Streamlined mobile experience

### Breakpoints
- **Mobile**: < 768px
- **Tablet**: 768px - 1024px
- **Desktop**: > 1024px

## 🧪 Testing

### Manual Testing Checklist
- [ ] User registration and login
- [ ] Exam navigation and question answering
- [ ] Timer functionality and auto-submission
- [ ] Results display and analytics
- [ ] Responsive design on different devices
- [ ] Form validation and error handling
- [ ] Session management and logout

### Browser Compatibility
- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

## 🚀 Deployment

### Production Setup
1. **Web Server**: Configure Apache/Nginx
2. **Database**: Set up MS SQL Server
3. **SSL Certificate**: Enable HTTPS
4. **Environment Variables**: Configure API endpoints
5. **Backup Strategy**: Implement data backup

### Performance Optimization
- Minify CSS and JavaScript
- Optimize images and assets
- Enable gzip compression
- Implement caching strategies
- Use CDN for static assets

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and questions:
- **Email**: support@iti-university.com
- **Phone**: +1 (555) 123-4567
- **Documentation**: [Wiki Link]

## 🔄 Version History

### v1.0.0 (December 2024)
- Initial release
- Core examination functionality
- User authentication system
- Responsive design implementation
- Results analytics and reporting

## 🎯 Roadmap

### Future Features
- [ ] Advanced question types (essay, file upload)
- [ ] Proctoring integration
- [ ] Real-time collaboration
- [ ] Advanced analytics
- [ ] Mobile app development
- [ ] AI-powered question generation
- [ ] Multi-language support
- [ ] Advanced reporting tools

---

**ITI University Examination System** - Empowering education through technology. 