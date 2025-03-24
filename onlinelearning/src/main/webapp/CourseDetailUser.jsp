<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 3/24/2025
  Time: 9:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
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
    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

    <!-- PAGE TITLE HERE ============================================= -->
    <title>Course Detail</title>

    <!-- MOBILE SPECIFIC ============================================= -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!--[if lt IE 9]>
    <script src="assets/js/html5shiv.min.js"></script>
    <script src="assets/js/respond.min.js"></script>
    <![endif]-->

    <!-- All PLUGINS CSS ============================================= -->
    <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

    <!-- TYPOGRAPHY ============================================= -->
    <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

    <!-- SHORTCODES ============================================= -->
    <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

    <!-- STYLESHEETS ============================================= -->
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

    <!-- REVOLUTION SLIDER CSS ============================================= -->
    <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/layers.css">
    <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/settings.css">
    <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/navigation.css">
    <!-- Style CSS specifically for our course detail page -->
    <style>
        /* Custom styles for course navigation, subject panels, and lesson items */
        .course-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #e9e9e9;
            margin-bottom: 20px;
        }

        .subject-panel {
            margin-bottom: 15px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
            overflow: hidden;
        }

        .subject-header {
            padding: 15px;
            background-color: #f8f8f8;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .subject-content {
            display: none;
            padding: 0;
        }

        .lesson-item {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            border-top: 1px solid #e9e9e9;
            transition: background-color 0.3s;
            cursor: pointer;
        }

        .lesson-item:hover {
            background-color: #f1f1f1;
        }

        .lesson-icon {
            margin-right: 15px;
            width: 24px;
            text-align: center;
        }

        .lesson-title {
            flex: 1;
        }

        .lesson-duration {
            margin-top: 5px;
            font-size: 12px;
            color: #666;
        }

        /* Content display area */
        .content-display {
            padding: 20px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
            min-height: 400px;
        }

        /* Video container */
        .video-container {
            position: relative;
            padding-bottom: 56.25%; /* 16:9 aspect ratio */
            height: 0;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .video-container iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        /* Toggle button */
        .toggle-btn {
            background: none;
            border: none;
            font-size: 18px;
            cursor: pointer;
        }

        /* Completed lesson indicator */
        .completed-lesson {
            color: #28a745;
        }

        /* Responsive adjustments */
        @media (max-width: 767px) {
            .course-container {
                flex-direction: column;
            }
            .course-sidebar {
                width: 100%;
                margin-bottom: 20px;
            }
            .course-content {
                width: 100%;
            }
        }
    </style>
</head>
<body id="bg">
<div class="page-wraper">
    <div id="loading-icon-bx"></div>
    <!-- Header Top ==== -->
    <jsp:include page="header.jsp"/>
    <!-- header END ==== -->
    <!-- Content -->
    <div class="page-content bg-white">
        <!-- inner page banner -->
        <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner3.jpg);">
            <div class="container">
                <div class="page-banner-entry">
                    <h1 class="text-white">${course.title}</h1>
                </div>
            </div>
        </div>
        <!-- Breadcrumb row -->
        <div class="breadcrumb-row">
            <div class="container">
                <ul class="list-inline">
                    <li><a href="home">Home</a></li>
                    <li><a href="courses.jsp">Courses</a></li>
                    <li>${course.title}</li>
                </ul>
            </div>
        </div>
        <!-- Breadcrumb row END -->

        <!-- inner page banner END -->
        <div class="content-block">
            <!-- About Us -->
            <div class="section-area section-sp1">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 col-md-7 col-sm-12">
                            <div class="course-nav">
                                <h4>${course.title}</h4>
                                <div>
                                    <a href="course?id=${course.courseId}" class="btn">Course Info</a>
                                </div>
                            </div>

                            <!-- Content display area -->
                            <div class="content-display" id="lesson-content">
                                <!-- Content will be loaded here via AJAX -->
                                <div class="text-center p-5">
                                    <h3>Select a lesson to start learning</h3>
                                    <p>Click on any lesson from the sidebar to view its content</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-5 col-sm-12">
                            <div class="course-sidebar">
                                <div class="widget widget-newslatter">
                                    <h6 class="widget-title">Course Content</h6>
                                    <div class="course-lessons">
                                        <c:forEach items="${subjects}" var="subject" varStatus="subjectStatus">
                                            <div class="subject-panel">
                                                <div class="subject-header" onclick="toggleSubject(${subject.subjectId})">
                                                    <h6 class="m-0">${subject.name}</h6>
                                                    <button class="toggle-btn">
                                                        <i id="icon-${subject.subjectId}" class="fa fa-plus"></i>
                                                    </button>
                                                </div>
                                                <div class="subject-content" id="subject-${subject.subjectId}">
                                                    <c:forEach items="${subject.lessons}" var="lesson">
                                                        <div class="lesson-item" onclick="loadLessonContent(${lesson.lessonId}, '${lesson.type}')">
                                                            <div class="lesson-icon">
                                                                <c:choose>
                                                                    <c:when test="${lesson.type == 'TEXT'}">
                                                                        <i class="fa fa-file-text-o"></i>
                                                                    </c:when>
                                                                    <c:when test="${lesson.type == 'VIDEO'}">
                                                                        <i class="fa fa-play-circle-o"></i>
                                                                    </c:when>
                                                                    <c:when test="${lesson.type == 'FILE'}">
                                                                        <i class="fa fa-file-o"></i>
                                                                    </c:when>
                                                                    <c:when test="${lesson.type == 'QUIZ'}">
                                                                        <i class="fa fa-question-circle-o"></i>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i class="fa fa-file-o"></i>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div class="lesson-title">
                                                                ${lesson.lessonName}
                                                                <div class="lesson-duration">
                                                                    <c:choose>
                                                                        <c:when test="${lesson.type == 'VIDEO'}">
                                                                            <i class="fa fa-clock-o"></i> ${lesson.duration} min
                                                                        </c:when>
                                                                        <c:when test="${lesson.type == 'QUIZ'}">
                                                                            <i class="fa fa-question-circle"></i> ${lesson.questionCount} questions
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <i class="fa fa-file-text"></i> ${lesson.type}
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </div>
                                                            <div>
                                                                <c:if test="${lesson.completed}">
                                                                    <i class="fa fa-check-circle completed-lesson"></i>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- contact area END -->
    </div>
    <!-- Content END-->
    <!-- Footer ==== -->
    <jsp:include page="footer.jsp"/>
    <!-- Footer END ==== -->
    <button class="back-to-top fa fa-chevron-up"></button>
</div>
<!-- External JavaScripts -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/vendors/bootstrap/js/popper.min.js"></script>
<script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
<script src="assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
<script src="assets/vendors/magnific-popup/magnific-popup.js"></script>
<script src="assets/vendors/counter/waypoints-min.js"></script>
<script src="assets/vendors/counter/counterup.min.js"></script>
<script src="assets/vendors/imagesloaded/imagesloaded.js"></script>
<script src="assets/vendors/masonry/masonry.js"></script>
<script src="assets/vendors/masonry/filter.js"></script>
<script src="assets/vendors/owl-carousel/owl.carousel.js"></script>
<script src="assets/js/functions.js"></script>
<script src="assets/js/contact.js"></script>
<script src='assets/vendors/switcher/switcher.js'></script>

<!-- Custom JavaScript for course interaction -->
<script>
    // Toggle subject content visibility
    function toggleSubject(subjectId) {
        var content = document.getElementById('subject-' + subjectId);
        var icon = document.getElementById('icon-' + subjectId);
        
        if (content.style.display === 'block') {
            content.style.display = 'none';
            icon.className = 'fa fa-plus';
        } else {
            content.style.display = 'block';
            icon.className = 'fa fa-minus';
        }
    }
    
    // Load lesson content via AJAX
    function loadLessonContent(lessonId, lessonType) {
        const contentDisplay = document.getElementById('lesson-content');
        contentDisplay.innerHTML = '<div class="text-center p-5"><i class="fa fa-spinner fa-spin fa-3x"></i><p>Loading content...</p></div>';
        
        // AJAX request to get lesson content
        $.ajax({
            url: 'lesson-content',
            type: 'GET',
            data: {
                lessonId: lessonId,
                type: lessonType
            },
            success: function(response) {
                contentDisplay.innerHTML = response;
                // Mark as viewed (you can add your tracking logic here)
                markLessonAsViewed(lessonId);
            },
            error: function() {
                contentDisplay.innerHTML = '<div class="p-4"><div class="alert alert-danger">Error loading content. Please try again.</div></div>';
            }
        });
    }
    
    // Mark lesson as viewed (placeholder)
    function markLessonAsViewed(lessonId) {
        // You can add AJAX call to mark the lesson as viewed here
        console.log('Lesson ' + lessonId + ' marked as viewed');
    }
    
    // Initialize the first subject as open
    document.addEventListener('DOMContentLoaded', function() {
        // Check if there are subjects
        const subjects = document.querySelectorAll('.subject-panel');
        if (subjects.length > 0) {
            // Get the first subject ID from the DOM
            const firstSubjectHeader = subjects[0].querySelector('.subject-header');
            if (firstSubjectHeader) {
                // Trigger a click on the first subject
                firstSubjectHeader.click();
            }
        }
    });
</script>
</body>
</html>
