<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- META ============================================= -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="keywords" content=""/>
    <meta name="author" content=""/>
    <meta name="robots" content=""/>
    
    <!-- DESCRIPTION -->
    <meta name="description" content="EduChamp : Education HTML Template"/>
    
    <!-- OG -->
    <meta property="og:title" content="EduChamp : Education HTML Template"/>
    <meta property="og:description" content="EduChamp : Education HTML Template"/>
    <meta property="og:image" content=""/>
    <meta name="format-detection" content="telephone=no">
    
    <!-- PAGE TITLE HERE ============================================= -->
    <title>Admin Statistics Dashboard</title>
    
    <!-- MOBILE SPECIFIC ============================================= -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- All PLUGINS CSS ============================================= -->
    <jsp:include page="../common/common_admin_css.jsp"></jsp:include>
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        .dashboard-card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            padding: 20px;
            background-color: #fff;
        }
        
        .dashboard-card h4 {
            margin-top: 0;
            color: #4c1864;
            font-weight: 600;
        }
        
        .stat-overview {
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            color: white;
            margin-bottom: 15px;
        }
        
        .stat-users {
            background: linear-gradient(45deg, #4099ff, #73b4ff);
        }
        
        .stat-courses {
            background: linear-gradient(45deg, #2ed8b6, #59e0c5);
        }
        
        .stat-quizzes {
            background: linear-gradient(45deg, #ffb64d, #ffcb80);
        }
        
        .stat-number {
            font-size: 28px;
            font-weight: bold;
        }
        
        .stat-label {
            font-size: 14px;
            opacity: 0.9;
        }
        
        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
        }
        
        .tab-pane {
            padding-top: 20px;
        }
        
        .period-selector {
            margin-bottom: 15px;
            text-align: right;
        }
        
        .period-selector button {
            padding: 5px 15px;
            margin-left: 5px;
            border-radius: 4px;
            border: 1px solid #ddd;
            background: #f8f8f8;
            cursor: pointer;
        }
        
        .period-selector button.active {
            background: #4c1864;
            color: white;
            border-color: #4c1864;
        }
    </style>
</head>
<body class="ttr-opened-sidebar ttr-pinned-sidebar">

<!-- header start -->
<jsp:include page="../common/common_admin_header.jsp"></jsp:include>
<!-- header end -->

<!-- Left sidebar menu start -->
<jsp:include page="../common/common_admin_sidebar_menu.jsp"></jsp:include>
<!-- Left sidebar menu end -->

<!--Main container start -->
<main class="ttr-wrapper">
    <div class="container-fluid">
        <div class="db-breadcrumb">
            <h4 class="breadcrumb-title">Statistics Dashboard</h4>
            <ul class="db-breadcrumb-list">
                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                <li>Statistics Dashboard</li>
            </ul>
        </div>
        
        <!-- Overview Cards -->
        <div class="row">
            <div class="col-md-4">
                <div class="stat-overview stat-users">
                    <div class="stat-number">${userStats.totalUsers}</div>
                    <div class="stat-label">Total Users</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-overview stat-courses">
                    <div class="stat-number">${courseEnrollmentStats.size()}</div>
                    <div class="stat-label">Total Courses</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-overview stat-quizzes">
                    <div class="stat-number">${quizStats.totalAttempts}</div>
                    <div class="stat-label">Quiz Attempts</div>
                </div>
            </div>
        </div>
        
        <!-- Tabbed Statistics -->
        <div class="row">
            <div class="col-lg-12 m-b30">
                <div class="widget-box">
                    <div class="wc-title">
                        <h4>Statistics Dashboard</h4>
                    </div>
                    <div class="widget-inner">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="users-tab" data-toggle="tab" href="#users" role="tab" aria-controls="users" aria-selected="true">Users</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="courses-tab" data-toggle="tab" href="#courses" role="tab" aria-controls="courses" aria-selected="false">Courses</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="quizzes-tab" data-toggle="tab" href="#quizzes" role="tab" aria-controls="quizzes" aria-selected="false">Quizzes</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <!-- USERS STATISTICS -->
                            <div class="tab-pane fade show active" id="users" role="tabpanel" aria-labelledby="users-tab">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="dashboard-card">
                                            <h4>User Registration Trends</h4>
                                            <div class="period-selector">
                                                <button class="period-btn active" data-period="monthly">Monthly</button>
                                                <button class="period-btn" data-period="weekly">Weekly</button>
                                                <button class="period-btn" data-period="daily">Daily</button>
                                                <button class="period-btn" data-period="yearly">Yearly</button>
                                            </div>
                                            <div class="chart-container">
                                                <canvas id="userRegistrationChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="dashboard-card">
                                            <h4>User Roles Distribution</h4>
                                            <div class="chart-container">
                                                <canvas id="userRolesChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="dashboard-card">
                                            <h4>User Activity Metrics</h4>
                                            <div class="chart-container">
                                                <canvas id="userActivityChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- COURSES STATISTICS -->
                            <div class="tab-pane fade" id="courses" role="tabpanel" aria-labelledby="courses-tab">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="dashboard-card">
                                            <h4>Course Enrollment Distribution</h4>
                                            <div class="chart-container">
                                                <canvas id="courseEnrollmentChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- QUIZZES STATISTICS -->
                            <div class="tab-pane fade" id="quizzes" role="tabpanel" aria-labelledby="quizzes-tab">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="dashboard-card">
                                            <h4>Quiz Attempts</h4>
                                            <div class="chart-container">
                                                <canvas id="quizAttemptsChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="dashboard-card">
                                            <h4>Quiz Pass Rates</h4>
                                            <div class="chart-container">
                                                <canvas id="quizPassRateChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="dashboard-card">
                                            <h4>Quiz Scores Distribution</h4>
                                            <div class="chart-container">
                                                <canvas id="quizScoresChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<div class="ttr-overlay"></div>

<!-- External JavaScripts -->
<jsp:include page="../common/common_admin_js.jsp"></jsp:include>

<script>
    $(document).ready(function() {
        // Initialize charts
        initUserCharts();
        
        // Handle tab changes to initialize charts when tab is shown
        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            const tabId = $(e.target).attr('id');
            
            switch(tabId) {
                case 'users-tab':
                    initUserCharts();
                    break;
                case 'courses-tab':
                    initCourseCharts();
                    break;
                case 'quizzes-tab':
                    initQuizCharts();
                    break;
            }
        });
        
        // Period selector for user registration chart
        $('#users .period-btn').click(function() {
            $('#users .period-btn').removeClass('active');
            $(this).addClass('active');
            const period = $(this).data('period');
            fetchUserRegistrationData(period);
        });
    });
    
    // Initialize User-related charts
    function initUserCharts() {
        // Initial fetch for user registration data with default period (monthly)
        fetchUserRegistrationData('monthly');
        
        // User roles distribution chart
        const userRolesData = {
            labels: Object.keys(${userStats.usersByRole}),
            datasets: [{
                data: Object.values(${userStats.usersByRole}),
                backgroundColor: [
                    '#4099ff', '#2ed8b6', '#ffb64d', '#ff5370', '#7759de'
                ]
            }]
        };
        
        new Chart(document.getElementById('userRolesChart'), {
            type: 'pie',
            data: userRolesData,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right'
                    }
                }
            }
        });
        
        // User activity chart
        new Chart(document.getElementById('userActivityChart'), {
            type: 'bar',
            data: {
                labels: ['Total Users', 'Active Users'],
                datasets: [{
                    label: 'User Count',
                    data: [${userStats.totalUsers}, ${userStats.activeUsers}],
                    backgroundColor: ['#4099ff', '#2ed8b6']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }
    
    // Fetch user registration data by period
    function fetchUserRegistrationData(period) {
        $.ajax({
            url: '${pageContext.request.contextPath}/admin-statistics',
            data: {
                action: 'userRegistration',
                period: period
            },
            success: function(response) {
                updateUserRegistrationChart(response.data, period);
            },
            error: function(error) {
                console.error('Error fetching user registration data:', error);
            }
        });
    }
    
    // Update user registration chart with fetched data
    function updateUserRegistrationChart(data, period) {
        const labels = Object.keys(data);
        const values = Object.values(data);
        
        let periodLabel;
        switch(period) {
            case 'daily':
                periodLabel = 'Daily';
                break;
            case 'weekly':
                periodLabel = 'Weekly';
                break;
            case 'monthly':
                periodLabel = 'Monthly';
                break;
            case 'yearly':
                periodLabel = 'Yearly';
                break;
            default:
                periodLabel = 'Monthly';
        }
        
        // Destroy existing chart if it exists
        if (window.userRegistrationChart) {
            window.userRegistrationChart.destroy();
        }
        
        // Create new chart
        window.userRegistrationChart = new Chart(document.getElementById('userRegistrationChart'), {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: periodLabel + ' User Registrations',
                    data: values,
                    borderColor: '#4099ff',
                    backgroundColor: 'rgba(64, 153, 255, 0.2)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            precision: 0
                        }
                    }
                }
            }
        });
    }
    
    // Initialize Course-related charts
    function initCourseCharts() {
        // Course enrollment chart
        const courseLabels = [];
        const courseData = [];
        
        <c:forEach items="${courseEnrollmentStats}" var="entry">
            courseLabels.push('${entry.key}');
            courseData.push(${entry.value});
        </c:forEach>
        
        new Chart(document.getElementById('courseEnrollmentChart'), {
            type: 'bar',
            data: {
                labels: courseLabels,
                datasets: [{
                    label: 'Enrollments',
                    data: courseData,
                    backgroundColor: '#2ed8b6'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            precision: 0
                        }
                    }
                }
            }
        });
    }
    
    // Initialize Quiz-related charts
    function initQuizCharts() {
        const quizData = ${quizStats.quizData};
        const quizIds = quizData.map(item => item.title || ('Quiz ' + item.quizId));
        const attempts = quizData.map(item => item.attempts);
        const passRates = quizData.map(item => item.passRate);
        
        // Quiz attempts chart
        new Chart(document.getElementById('quizAttemptsChart'), {
            type: 'bar',
            data: {
                labels: quizIds,
                datasets: [{
                    label: 'Attempts',
                    data: attempts,
                    backgroundColor: '#ffb64d'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            precision: 0
                        }
                    }
                }
            }
        });
        
        // Quiz pass rate chart
        new Chart(document.getElementById('quizPassRateChart'), {
            type: 'bar',
            data: {
                labels: quizIds,
                datasets: [{
                    label: 'Pass Rate (%)',
                    data: passRates,
                    backgroundColor: '#2ed8b6'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100
                    }
                }
            }
        });
        
        // Quiz scores distribution
        const scores = quizData.map(item => item.avgScore);
        
        new Chart(document.getElementById('quizScoresChart'), {
            type: 'line',
            data: {
                labels: quizIds,
                datasets: [{
                    label: 'Average Score',
                    data: scores,
                    borderColor: '#7759de',
                    backgroundColor: 'rgba(119, 89, 222, 0.2)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100
                    }
                }
            }
        });
    }
</script>
</body>
</html> 