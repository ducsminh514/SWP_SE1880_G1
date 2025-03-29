<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">

<!-- Mirrored from educhamp.themetrades.com/demo/admin/index.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:08:15 GMT -->
<head>

	<!-- META ============================================= -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="keywords" content="" />
	<meta name="author" content="" />
	<meta name="robots" content="" />
	
	<!-- DESCRIPTION -->
	<meta name="description" content="EduChamp : Education HTML Template" />
	
	<!-- OG -->
	<meta property="og:title" content="EduChamp : Education HTML Template" />
	<meta property="og:description" content="EduChamp : Education HTML Template" />
	<meta property="og:image" content="" />
	<meta name="format-detection" content="telephone=no">
	
	<!-- FAVICONS ICON ============================================= -->
	<link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.png" type="image/x-icon" />
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/favicon.png" />
	
	<!-- PAGE TITLE HERE ============================================= -->
	<title>Admin Dashboard - Online Learning Platform</title>
	
	<!-- MOBILE SPECIFIC ============================================= -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!--[if lt IE 9]>
	<script src="${pageContext.request.contextPath}/assets/js/html5shiv.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/respond.min.js"></script>
	<![endif]-->
	
	<!-- All PLUGINS CSS ============================================= -->
    <jsp:include page="../common/common_admin_css.jsp"></jsp:include>
    
    <!-- jQuery first, then Chart.js -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
	
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
				<h4 class="breadcrumb-title">Dashboard</h4>
				<ul class="db-breadcrumb-list">
					<li><a href="#"><i class="fa fa-home"></i>Home</a></li>
					<li>Dashboard</li>
				</ul>
			</div>	
			<!-- Card -->
			<div class="row">
				<div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
					<div class="widget-card widget-bg1">					 
						<div class="wc-item">
							<h4 class="wc-title">
								Total Users
							</h4>
							<span class="wc-des">
								Active User Accounts
							</span>
							<span class="wc-stats">
								<span class="counter">${userStats['totalUsers']}</span>
							</span>		
							<div class="progress wc-progress">
								<div class="progress-bar" role="progressbar" style="width: ${(userStats['activeUsers'] / userStats['totalUsers']) * 100}%;" aria-valuenow="${(userStats['activeUsers'] / userStats['totalUsers']) * 100}" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
							<span class="wc-progress-bx">
								<span class="wc-change">
									Active Users
								</span>
								<span class="wc-number ml-auto">
									${userStats['activeUsers']}
								</span>
							</span>
						</div>				      
					</div>
				</div>
				<div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
					<div class="widget-card widget-bg2">					 
						<div class="wc-item">
							<h4 class="wc-title">
								Total Courses
							</h4>
							<span class="wc-des">
								Available Courses
							</span>
							<span class="wc-stats counter">
								${courseEnrollmentStats.size()}
							</span>		
							<div class="progress wc-progress">
								<div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
							<span class="wc-progress-bx">
								<span class="wc-change">
									Course Categories
								</span>
								<span class="wc-number ml-auto">
									${courseEnrollmentStats.size()}
								</span>
							</span>
						</div>				      
					</div>
				</div>
				<div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
					<div class="widget-card widget-bg3">					 
						<div class="wc-item">
							<h4 class="wc-title">
								Quiz Attempts
							</h4>
							<span class="wc-des">
								Total Quiz Attempts
							</span>
							<span class="wc-stats counter">
								${quizStats['totalAttempts']}
							</span>		
							<div class="progress wc-progress">
								<div class="progress-bar" role="progressbar" style="width: 65%;" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
							<span class="wc-progress-bx">
								<span class="wc-change">
									Available Quizzes
								</span>
								<span class="wc-number ml-auto">
									<c:if test="${quizStats['quizData'] != null}">
                                        ${quizStats['quizData'].size()}
                                    </c:if>
								</span>
							</span>
						</div>				      
					</div>
				</div>
				<div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
					<div class="widget-card widget-bg4">					 
						<div class="wc-item">
							<h4 class="wc-title">
								New Users 
							</h4>
							<span class="wc-des">
								Last 30 Days
							</span>
							<span class="wc-stats counter">
								<span id="newUsersCount">0</span>
							</span>		
							<div class="progress wc-progress">
								<div class="progress-bar" role="progressbar" style="width: 90%;" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
							<span class="wc-progress-bx">
								<span class="wc-change">
									Growth Rate
								</span>
								<span class="wc-number ml-auto">
									<span id="userGrowthRate">0</span>%
								</span>
							</span>
						</div>				      
					</div>
				</div>
			</div>
			<!-- Card END -->
			<div class="row">
				<!-- Your Profile Views Chart -->
				<div class="col-lg-8 m-b30">
					<div class="widget-box">
						<div class="wc-title">
							<h4>User Registration Trends</h4>
						</div>
						<div class="widget-inner">
							<div class="row">
                                <div class="col-md-12">
                                    <div class="text-right mb-3">
                                        <button class="period-btn active btn btn-sm" data-period="monthly">Monthly</button>
                                        <button class="period-btn btn btn-sm" data-period="weekly">Weekly</button>
                                        <button class="period-btn btn btn-sm" data-period="daily">Daily</button>
                                        <button class="period-btn btn btn-sm" data-period="yearly">Yearly</button>
                                    </div>
                                    <div id="userRegistrationChartContainer" style="height: 300px;">
                                        <canvas id="userRegistrationChart"></canvas>
                                    </div>
                                </div>
                            </div>
						</div>
					</div>
				</div>
				<!-- Your Profile Views Chart END-->
				<div class="col-lg-4 m-b30">
					<div class="widget-box">
						<div class="wc-title">
							<h4>User Roles Distribution</h4>
						</div>
						<div class="widget-inner">
                            <div id="userRolesChartContainer" style="height: 300px;">
							    <canvas id="userRolesChart"></canvas>
                            </div>
						</div>
					</div>
				</div>
				
				<div class="col-lg-6 m-b30">
					<div class="widget-box">
						<div class="wc-title">
							<h4>Course Enrollment Distribution</h4>
						</div>
						<div class="widget-inner">
                            <div id="courseEnrollmentChartContainer" style="height: 300px;">
							    <canvas id="courseEnrollmentChart"></canvas>
                            </div>
						</div>
					</div>
				</div>
				
				<div class="col-lg-6 m-b30">
					<div class="widget-box">
						<div class="wc-title">
							<h4>Quiz Performance</h4>
						</div>
						<div class="widget-inner">
                            <div id="quizPerformanceChartContainer" style="height: 300px;">
							    <canvas id="quizPerformanceChart"></canvas>
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
document.addEventListener('DOMContentLoaded', function() {
    console.log("DOMContentLoaded event fired!");
    
    // Biến toàn cục để theo dõi các biểu đồ
    window.charts = {
        userRegistration: null,
        userRoles: null,
        courseEnrollment: null,
        quizPerformance: null
    };
    
    // Check if Chart.js is loaded
    if (typeof Chart === 'undefined') {
        console.error("Chart.js is not loaded! Loading it now...");
        var script = document.createElement('script');
        script.src = 'https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js';
        script.onload = function() {
            console.log("Chart.js loaded successfully!");
            initializeCharts();
        };
        document.head.appendChild(script);
    } else {
        console.log("Chart.js is already loaded!");
        setTimeout(initializeCharts, 500); // Đợi 500ms để đảm bảo DOM hoàn toàn sẵn sàng
    }

    // Check canvas elements
    function checkCanvasElements() {
        console.log("Canvas elements check:", {
            userRegistrationChart: document.getElementById('userRegistrationChart'),
            userRolesChart: document.getElementById('userRolesChart'),
            courseEnrollmentChart: document.getElementById('courseEnrollmentChart'),
            quizPerformanceChart: document.getElementById('quizPerformanceChart')
        });
    }
    
    // Hàm khởi tạo tất cả biểu đồ
    function initializeCharts() {
        checkCanvasElements();
        
        // Extract user stats from server data
        var userStats = {
            totalUsers: ${userStats['totalUsers'] != null ? userStats['totalUsers'] : 0},
            activeUsers: ${userStats['activeUsers'] != null ? userStats['activeUsers'] : 0},
            usersByRole: {}
        };
        
        <c:if test="${userStats['usersByRole'] != null}">
            <c:forEach items="${userStats['usersByRole']}" var="role">
                userStats.usersByRole['${role.key}'] = ${role.value};
            </c:forEach>
        </c:if>
        
        console.log("User stats:", userStats);
        
        // Course enrollment stats
        var courseEnrollmentStats = {};
        <c:forEach items="${courseEnrollmentStats}" var="course">
            courseEnrollmentStats['${course.key}'] = ${course.value};
        </c:forEach>
        console.log("Course enrollment stats:", courseEnrollmentStats);
        
        // Quiz stats
        var quizStats = {
            totalAttempts: ${quizStats['totalAttempts'] != null ? quizStats['totalAttempts'] : 0},
            quizData: []
        };
        
        <c:if test="${quizStats['quizData'] != null}">
            <c:forEach items="${quizStats['quizData']}" var="quiz">
                quizStats.quizData.push({
                    quizId: '${quiz.quizId}',
                    title: '${quiz.title}',
                    attempts: ${quiz.attempts},
                    avgScore: ${quiz.avgScore},
                    passRate: ${quiz.passRate}
                });
            </c:forEach>
        </c:if>
        console.log("Quiz stats:", quizStats);
        
        // Initialize all charts with try-catch to capture errors
        try {
            setTimeout(function() {
                // Initialize User Registration Chart
                initUserRegistrationChart('monthly');
                
                // Initialize User Roles Chart
                if (userStats.usersByRole && Object.keys(userStats.usersByRole).length > 0) {
                    initUserRolesChart(userStats.usersByRole);
                } else {
                    console.warn("User roles data is missing or null");
                    // Use sample data for testing
                    initUserRolesChart({
                        'Student': 8,
                        'Teacher': 3,
                        'Admin': 1
                    });
                }
                
                // Initialize Course Enrollment Chart
                if (courseEnrollmentStats && Object.keys(courseEnrollmentStats).length > 0) {
                    initCourseEnrollmentChart(courseEnrollmentStats);
                } else {
                    console.warn("Course enrollment data is missing or empty");
                    // Use sample data for testing
                    initCourseEnrollmentChart({
                        'Java Programming': 45,
                        'Web Development': 32,
                        'Database Management': 28,
                        'Mobile App Development': 15
                    });
                }
                
                // Initialize Quiz Performance Chart
                if (quizStats.quizData && quizStats.quizData.length > 0) {
                    initQuizPerformanceChart(quizStats.quizData);
                } else {
                    console.warn("Quiz data is missing or empty");
                    // Use sample data for testing
                    initQuizPerformanceChart([
                        {title: 'Java Basics', passRate: 82},
                        {title: 'Database Fundamentals', passRate: 72},
                        {title: 'Web Development', passRate: 94}
                    ]);
                }
            }, 1000); // Tăng thời gian delay để đảm bảo DOM đã sẵn sàng
            
            // Period selector for user registration chart
            $('.period-btn').click(function() {
                $('.period-btn').removeClass('active');
                $(this).addClass('active');
                const period = $(this).data('period');
                fetchUserRegistrationData(period);
            });
        } catch (e) {
            console.error("Error initializing charts:", e);
        }
    }
});

// Fetch user registration data by period
function fetchUserRegistrationData(period) {
    console.log("Fetching data for period:", period);
    $.ajax({
        url: '${pageContext.request.contextPath}/admin-dashboard',
        data: {
            action: 'userRegistration',
            period: period
        },
        success: function(response) {
            console.log("Received data:", response);
            
            if (response && response.data) {
                updateUserRegistrationChart(response.data, period);
                
                // Update new users count for last 30 days if daily data
                if (period === 'daily') {
                    const values = Object.values(response.data);
                    const newUsersCount = values.reduce((sum, current) => sum + current, 0);
                    $('#newUsersCount').text(newUsersCount);
                    
                    // Calculate growth rate (new users / total users)
                    const totalUsers = ${userStats['totalUsers'] != null ? userStats['totalUsers'] : 1};
                    const growthRate = Math.round((newUsersCount / totalUsers) * 100);
                    $('#userGrowthRate').text(growthRate);
                }
            } else {
                console.error("Invalid response format:", response);
            }
        },
        error: function(error) {
            console.error('Error fetching user registration data:', error);
            // Use sample data if there's an error
            const sampleData = getSampleRegistrationData(period);
            updateUserRegistrationChart(sampleData, period);
        }
    });
}

// Sample data function for testing
function getSampleRegistrationData(period) {
    const data = {};
    
    switch (period) {
        case 'daily':
            data['2023-07-01'] = 1;
            data['2023-07-02'] = 0;
            data['2023-07-03'] = 2;
            data['2023-07-04'] = 1;
            data['2023-07-05'] = 3;
            data['2023-07-06'] = 2;
            data['2023-07-07'] = 1;
            break;
            
        case 'weekly':
            data['2023-Week 26'] = 5;
            data['2023-Week 27'] = 8;
            data['2023-Week 28'] = 12;
            data['2023-Week 29'] = 7;
            break;
            
        case 'yearly':
            data['2020'] = 45;
            data['2021'] = 78;
            data['2022'] = 112;
            data['2023'] = 87;
            break;
            
        case 'monthly':
        default:
            data['2023-01'] = 8;
            data['2023-02'] = 12;
            data['2023-03'] = 15;
            data['2023-04'] = 10;
            data['2023-05'] = 14;
            data['2023-06'] = 9;
            data['2023-07'] = 11;
            break;
    }
    
    return data;
}

// Initialize User Registration Chart
function initUserRegistrationChart(period) {
    console.log("Initializing user registration chart with period:", period);
    fetchUserRegistrationData(period);
}

// Update user registration chart with fetched data
function updateUserRegistrationChart(data, period) {
    console.log("Updating user registration chart with data:", data);
    
    const ctx = document.getElementById('userRegistrationChart');
    if (!ctx) {
        console.error("Canvas element 'userRegistrationChart' not found!");
        return;
    }
    
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
    if (window.charts && window.charts.userRegistration) {
        window.charts.userRegistration.destroy();
    }
    
    // Create new chart
    window.charts.userRegistration = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: periodLabel + ' User Registrations',
                data: values,
                borderColor: '#4c1864',
                backgroundColor: 'rgba(76, 24, 100, 0.2)',
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

// Initialize User Roles Chart
function initUserRolesChart(userRolesData) {
    console.log("Initializing user roles chart with data:", userRolesData);
    
    const ctx = document.getElementById('userRolesChart');
    if (!ctx) {
        console.error("Canvas element 'userRolesChart' not found!");
        return;
    }
    
    const labels = Object.keys(userRolesData);
    const data = Object.values(userRolesData);
    
    // Destroy existing chart if it exists
    if (window.charts && window.charts.userRoles) {
        window.charts.userRoles.destroy();
    }
    
    window.charts.userRoles = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                backgroundColor: [
                    '#4099ff', '#2ed8b6', '#ffb64d', '#ff5370', '#7759de'
                ]
            }]
        },
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
}

// Initialize Course Enrollment Chart
function initCourseEnrollmentChart(courseEnrollmentData) {
    console.log("Initializing course enrollment chart with data:", courseEnrollmentData);
    
    const ctx = document.getElementById('courseEnrollmentChart');
    if (!ctx) {
        console.error("Canvas element 'courseEnrollmentChart' not found!");
        return;
    }
    
    const labels = Object.keys(courseEnrollmentData);
    const data = Object.values(courseEnrollmentData);
    
    // Destroy existing chart if it exists
    if (window.charts && window.charts.courseEnrollment) {
        window.charts.courseEnrollment.destroy();
    }
    
    window.charts.courseEnrollment = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Enrollments',
                data: data,
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

// Initialize Quiz Performance Chart
function initQuizPerformanceChart(quizData) {
    console.log("Initializing quiz performance chart with data:", quizData);
    
    const ctx = document.getElementById('quizPerformanceChart');
    if (!ctx) {
        console.error("Canvas element 'quizPerformanceChart' not found!");
        return;
    }
    
    const labels = quizData.map(item => item.title || ('Quiz ' + item.quizId));
    const data = quizData.map(item => item.passRate);
    
    // Destroy existing chart if it exists
    if (window.charts && window.charts.quizPerformance) {
        window.charts.quizPerformance.destroy();
    }
    
    window.charts.quizPerformance = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Pass Rate (%)',
                data: data,
                backgroundColor: '#ffb64d'
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

// Tắt tính năng mCustomScrollbar nếu không được hỗ trợ
$(document).ready(function(){
    // Kiểm tra nếu mCustomScrollbar được định nghĩa
    if ($.fn.mCustomScrollbar === undefined) {
        console.warn("mCustomScrollbar plugin is not available, disabling related functions");
        // Override hàm để tránh lỗi
        $.fn.mCustomScrollbar = function() {
            console.warn("mCustomScrollbar called but not available");
            return this; // Trả về đối tượng hiện tại để không phá vỡ chuỗi
        };
    }
});
</script>
</body>

<!-- Mirrored from educhamp.themetrades.com/demo/admin/index.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:09:05 GMT -->
</html>