<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 3/24/2025
  Time: 9:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            border: none;
        }

        /* Video lesson container */
        .video-lesson-container {
            padding: 15px;
        }

        .video-controls {
            background-color: #f8f8f8;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .video-info {
            color: #666;
            font-size: 14px;
        }

        .video-duration {
            margin-right: 15px;
        }

        /* Transcript styles */
        .transcript-container {
            margin-top: 20px;
        }

        .transcript-content {
            max-height: 300px;
            overflow-y: auto;
            line-height: 1.6;
            font-size: 15px;
        }

        .btn-link:hover, .btn-link:focus {
            text-decoration: none;
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

        /* Progress bar styles */
        .course-progress {
            padding: 15px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .progress {
            height: 10px;
            border-radius: 5px;
            background-color: #e9e9e9;
        }

        .progress-bar {
            background-color: #4c1864;
            border-radius: 5px;
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
            .video-controls {
                flex-direction: column;
            }
            .video-info {
                margin-bottom: 10px;
            }
        }

        /* Quiz styles */
        .quiz-container {
            padding: 20px;
        }

        .quiz-question {
            margin-bottom: 25px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
        }

        .question-text {
            font-size: 16px;
            font-weight: 500;
        }

        .answer-options {
            margin-top: 15px;
        }

        .form-check {
            padding: 10px;
            border-radius: 4px;
            transition: background-color 0.2s;
        }

        .form-check:hover {
            background-color: #f8f9fa;
        }

        .form-check-input {
            margin-top: 0.3rem;
        }

        .form-check-label {
            margin-left: 10px;
            cursor: pointer;
        }

        /* Improved question image styles */
        .question-image {
            margin-bottom: 15px;
            text-align: center;
            max-width: 600px; /* Limit container width */
            height: 300px; /* Fixed height for rectangular frame */
            margin-left: auto;
            margin-right: auto;
            overflow: hidden; /* Hide overflow */
            border-radius: 6px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            background-color: #f9f9f9;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .question-image img {
            max-width: 100%;
            max-height: 100%;
            width: auto;
            height: auto;
            object-fit: contain; /* Maintain aspect ratio while fitting in container */
            display: block;
        }

        .question-audio {
            width: 100%;
            max-width: 500px;
            margin: 0 auto 15px;
        }

        .question-audio audio {
            width: 100%;
        }

        /* Essay question styles */
        .essay-answer textarea {
            width: 100%;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 4px;
            resize: vertical;
        }

        .essay-answer textarea:focus {
            border-color: #4c1864;
            box-shadow: 0 0 0 0.2rem rgba(76, 24, 100, 0.25);
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

                            <!-- Progress bar -->
                            <div class="course-progress mb-4">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <h5 class="m-0">Your Progress</h5>
                                    <c:set var="completedCount" value="0" />
                                    <c:set var="totalLessons" value="0" />

                                    <c:forEach items="${listSubject}" var="subject">
                                        <c:forEach items="${subjectLessonsMap[subject.subjectId]}" var="lesson">
                                            <c:set var="totalLessons" value="${totalLessons + 1}" />
                                            <c:if test="${lesson.completed}">
                                                <c:set var="completedCount" value="${completedCount + 1}" />
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>

                                    <c:set var="progressPercentage" value="${totalLessons > 0 ? (completedCount * 100) / totalLessons : 0}" />
                                    <span class="progress-text">${completedCount}/${totalLessons} completed (<fmt:formatNumber value="${progressPercentage}" pattern="#0" />%)</span>
                                </div>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar"
                                         style="width: ${progressPercentage}%"
                                         aria-valuenow="${progressPercentage}"
                                         aria-valuemin="0"
                                         aria-valuemax="100"></div>
                                </div>
                            </div>

                            <!-- Content display area -->
                            <div class="content-display" id="lesson-content">
                                <!-- Check if questions attribute exists (for quiz) -->
                                <c:if test="${not empty questions}">
                                    <div class="quiz-container">
                                        <h3 class="mb-4">Quiz</h3>

                                        <p>Time left: <strong id="time"></strong></p>
                                        <form id="quiz-form" method="post" action="submit-quiz">
                                            <input type="hidden" name="lessonId" value="${param.lessonId}" />

                                            <c:forEach items="${questions}" var="question" varStatus="qStatus">
                                                <div class="card mb-4 quiz-question">
                                                    <div class="card-header bg-light">
                                                        <h5 class="mb-0">Question ${qStatus.index + 1}</h5>
                                                    </div>
                                                    <div class="card-body">
                                                        <!-- Question content -->
                                                        <p class="question-text mb-3">${question.content}</p>

                                                        <!-- Display question image if available -->
                                                        <c:if test="${not empty question.questionImage}">
                                                            <div class="question-image mb-3">
                                                                <c:forEach items="${question.questionImage}" var="image">
                                                                    <img src="${pageContext.request.contextPath}/${image.imageURL}"  alt="${image.imageTitle}" class="img-fluid mb-2">
                                                                </c:forEach>
                                                            </div>
                                                        </c:if>

                                                        <!-- Display audio if available -->
                                                        <c:if test="${not empty question.mp3}">
                                                            <div class="question-audio mb-3">
                                                                <audio controls>
                                                                    <source src="${pageContext.request.contextPath}/uploads/audio/${question.mp3}" type="audio/mpeg">
                                                                    Your browser does not support the audio element.
                                                                </audio>
                                                            </div>
                                                        </c:if>

                                                        <!-- Answer options based on question type -->
                                                        <div class="answer-options">
                                                            <c:choose>
                                                                <%-- Multiple choice question (type 1) --%>
                                                                <c:when test="${question.questionType.questionTypeId == 1}">
                                                                    <c:forEach items="${questionAnswersMap[question.questionId]}" var="answer">
                                                                        <div class="form-check mb-2">
                                                                            <input class="form-check-input"
                                                                                   type="${question.questionType.questionTypeId == 1 ? 'radio' : 'checkbox'}"
                                                                                   name="question_${question.questionId}"
                                                                                   id="answer_${answer.answerId}"
                                                                                   value="${answer.answerId}">
                                                                            <label class="form-check-label" for="answer_${answer.answerId}">
                                                                                    ${answer.content}
                                                                            </label>
                                                                        </div>
                                                                    </c:forEach>
                                                                </c:when>

                                                                <%-- Essay/fill-in-the-blank question (type 2) --%>
                                                                <c:when test="${question.questionType.questionTypeId == 2}">
                                                                    <div class="essay-answer mt-3">
                                                                        <label for="essay_${question.questionId}" class="form-label">Your Answer:</label>
                                                                        <textarea class="form-control"
                                                                                  id="essay_${question.questionId}"
                                                                                  name="question_${question.questionId}"
                                                                                  rows="4"
                                                                                  placeholder="Type your answer here..."></textarea>
                                                                    </div>
                                                                </c:when>

                                                                <%-- Default case for other question types --%>
                                                                <c:otherwise>
                                                                    <div class="alert alert-warning">
                                                                        <p>This question type is not currently supported.</p>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                            <div class="text-center mt-4">
                                                <button type="submit" class="btn">Submit Quiz</button>
                                            </div>
                                        </form>
                                    </div>
                                </c:if>

                                <!-- Display video content if available -->
                                <c:if test="${not empty lessonVideo}">
                                    <div class="video-lesson-container">
                                        <h3 class="mb-3">${lesson.lessonName}</h3>

                                        <!-- Video player -->
                                        <div class="video-container mb-4">
                                            <iframe src="${lessonVideo.videoUrl}"
                                                    frameborder="0"
                                                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                                    allowfullscreen></iframe>
                                        </div>

                                        <!-- Video controls and info -->
                                        <div class="video-controls d-flex justify-content-between align-items-center mb-4">
                                            <div class="video-info">
                                                <span class="video-duration"><i class="fa fa-clock-o"></i> Duration: ${lessonVideo.videoDuration} minutes</span>
                                            </div>
                                            <div class="video-actions">
                                                <c:if test="${lessonVideo.downloadAllowed}">
                                                    <a href="${lessonVideo.videoUrl}" download class="btn btn-sm btn-outline-primary mr-2">
                                                        <i class="fa fa-download"></i> Download Video
                                                    </a>
                                                </c:if>
                                                <button class="btn" onclick="markLessonAsCompleted(${lesson.lessonId})">
                                                    <i class="fa fa-check-circle"></i> Mark as Completed
                                                </button>
                                            </div>
                                        </div>

                                        <!-- Video transcript if available -->
                                        <c:if test="${not empty lessonVideo.transcript}">
                                            <div class="transcript-container">
                                                <div class="card">
                                                    <div class="card-header bg-light">
                                                        <h5 class="mb-0">
                                                            <button class="btn btn-link text-dark p-0" type="button"
                                                                    data-toggle="collapse" data-target="#transcriptCollapse"
                                                                    aria-expanded="false" aria-controls="transcriptCollapse">
                                                                <i class="fa fa-file-text-o"></i> Transcript <i class="fa fa-chevron-down ml-2"></i>
                                                            </button>
                                                        </h5>
                                                    </div>
                                                    <div id="transcriptCollapse" class="collapse">
                                                        <div class="card-body transcript-content">
                                                                ${lessonVideo.transcript}
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:if>

                                <!-- Default content when no lesson is selected -->
                                <c:if test="${empty questions && empty lessonVideo}">
                                    <div class="text-center p-5">
                                        <h3>Select a lesson to start learning</h3>
                                        <p>Click on any lesson from the sidebar to view its content</p>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-5 col-sm-12">
                            <div class="course-sidebar">
                                <div class="widget widget-newslatter">
                                    <h6 class="widget-title">Course Content</h6>
                                    <div class="course-lessons">
                                        <!-- Subject Sidebar -->
                                        <c:forEach items="${listSubject}" var="subject" varStatus="subjectStatus">
                                            <div class="subject-panel">
                                                <div class="subject-header" onclick="toggleSubject('${subject.subjectId}')">
                                                    <h6 class="m-0">${subject.subjectName}</h6>
                                                    <button class="toggle-btn">
                                                        <i id="icon-${subject.subjectId}" class="fa fa-plus"></i>
                                                    </button>
                                                </div>
                                                <div class="subject-content" id="subject-${subject.subjectId}">
                                                    <c:forEach items="${subjectLessonsMap[subject.subjectId]}" var="lesson">
                                                        <div class="lesson-item" onclick="loadLessonContent('${lesson.lessonId}')">
                                                            <div class="lesson-icon">
                                                                <c:choose>
                                                                    <c:when test="${lesson.type eq 'TEXT' || lesson.type eq 'text'}">
                                                                        <i class="fa fa-file-text-o"></i>
                                                                    </c:when>
                                                                    <c:when test="${lesson.type eq 'VIDEO' || lesson.type eq 'video'}">
                                                                        <i class="fa fa-play-circle-o"></i>
                                                                    </c:when>
                                                                    <c:when test="${lesson.type eq 'FILE' || lesson.type eq 'file'}">
                                                                        <i class="fa fa-file-o"></i>
                                                                    </c:when>
                                                                    <c:when test="${lesson.type eq 'QUIZ' || lesson.type eq 'quiz'}">
                                                                        <i class="fa fa-question-circle-o"></i>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i class="fa fa-file-o"></i>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <!-- Lesson Title -->
                                                            <div class="lesson-title">
                                                                    ${lesson.lessonName}
                                                                <!-- Lesson Duration -->
                                                                <div class="lesson-duration">
                                                                        ${lesson.duration} minutes
                                                                </div>
                                                            </div>
                                                            <!-- Completed Lesson Indicator -->
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
    function loadLessonContent(lessonId) {
        // Show loading indicator with spinner animation
        document.getElementById('lesson-content').innerHTML = `
                    <div class="text-center p-5">
                        <div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;">
                            <span class="sr-only">Loading...</span>
                        </div>
                        <p class="mt-3">Loading lesson content...</p>
                    </div>
                `;

        // Navigate to the lesson page
        try {
            window.location.href = 'lesson?lessonId=' + lessonId;
        } catch (error) {
            // Show error message if navigation fails
            document.getElementById('lesson-content').innerHTML = `
                        <div class="alert alert-danger p-4">
                            <h4 class="alert-heading">Error Loading Lesson</h4>
                            <p>There was a problem loading the lesson content. Please try again or contact support.</p>
                            <hr>
                            <p class="mb-0">Error details: ${error.message || 'Unknown error'}</p>
                        </div>
                        <div class="text-center mt-3">
                            <button class="btn" onclick="loadLessonContent('${lessonId}')">Try Again</button>
                        </div>
                    `;
        }
    }

    // Track video progress for video lessons
    function trackVideoProgress() {
        const videoIframe = document.querySelector('.video-container iframe');
        if (!videoIframe)
            return;

        // Set up variables for tracking
        let currentLessonId = null;
        let watchedDuration = 0;
        let lessonDuration = 0;
        let isMarkedComplete = false;

        // Get the lesson ID from the URL
        const urlParams = new URLSearchParams(window.location.search);
        currentLessonId = urlParams.get('lessonId');

        // Check if this lesson is already marked as complete - use more precise selector
        const currentLessonItem = document.querySelector(`.lesson-item[onclick="loadLessonContent('${currentLessonId}')"]`);
        if (currentLessonItem && currentLessonItem.querySelector('.completed-lesson')) {
            isMarkedComplete = true;
        }

        // Get the video duration
        const durationText = document.querySelector('.video-duration');
        if (durationText) {
            const durationMatch = durationText.textContent.match(/Duration: (\d+)/);
            if (durationMatch && durationMatch[1]) {
                lessonDuration = parseInt(durationMatch[1]);
            }
        }

        // Check if we have a saved progress for this video in localStorage
        if (currentLessonId) {
            const savedProgress = localStorage.getItem(`videoProgress_${currentLessonId}`);
            if (savedProgress) {
                watchedDuration = parseInt(savedProgress);
                console.log(`Restored saved progress: ${watchedDuration} seconds for lesson ${currentLessonId}`);

                // Show resume message if we have watched more than 30 seconds
                if (watchedDuration > 30 && !isMarkedComplete) {
                    const videoContainer = document.querySelector('.video-container');
                    if (videoContainer) {
                        const resumeMessage = document.createElement('div');
                        resumeMessage.className = 'alert alert-info mt-2';
                        resumeMessage.innerHTML = `You previously watched ${Math.floor(watchedDuration/60)} minutes and ${watchedDuration % 60} seconds of this video.`;
                        videoContainer.insertAdjacentElement('afterend', resumeMessage);

                        // Remove the message after 10 seconds
                        setTimeout(() => {
                            resumeMessage.style.display = 'none';
                        }, 10000);
                    }
                }
            }
        }

        // Set up an interval to check progress
        if (currentLessonId && lessonDuration > 0 && !isMarkedComplete) {
            console.log('Tracking video progress for lesson:', currentLessonId);

            // This is a simple implementation - in reality, you'd want to use
            // video player API events to track actual watching progress
            const trackingInterval = setInterval(() => {
                // Increment watched time (every 5 seconds)
                watchedDuration += 5;

                // Save progress to localStorage every 30 seconds
                if (watchedDuration % 30 === 0) {
                    localStorage.setItem(`videoProgress_${currentLessonId}`, watchedDuration.toString());
                    console.log(`Saved progress: ${watchedDuration} seconds for lesson ${currentLessonId}`);
                }

                // Check if we've watched enough (70% of the video)
                const requiredWatchTime = Math.floor(lessonDuration * 0.7 * 60); // 70% of duration in seconds
                if (watchedDuration >= requiredWatchTime) {
                    console.log('Video watched enough to mark as complete');

                    // Clear the interval
                    clearInterval(trackingInterval);

                    // Mark the lesson as complete
                    markLessonAsCompleted(currentLessonId);

                    // Update localStorage to indicate completion
                    localStorage.setItem(`videoCompleted_${currentLessonId}`, 'true');
                }
            }, 5000); // Check every 5 seconds
        }
    }

    // Function to mark a lesson as completed
    function markLessonAsCompleted(lessonId) {
        // Check if this lesson is already marked as complete
        // Use a more specific selector to avoid matching partial lessonIds
        const lessonItem = document.querySelector(`.lesson-item[onclick="loadLessonContent('${lessonId}')"]`);
        if (lessonItem && lessonItem.querySelector('.completed-lesson')) {
            console.log('Lesson already marked as complete');
            return;
        }

        // Send AJAX request to mark lesson as completed
        $.ajax({
            url: 'lesson',
            type: 'POST',
            data: {lessonId: lessonId},
            dataType: 'json',
            success: function (response) {
                if (!response.success) {
                    console.error('Error:', response.message);
                    alert(response.message);
                    return;
                }

                console.log('Lesson marked as completed:', response);

                // Add completion indicator to the sidebar
                if (lessonItem) {
                    // Check if completion indicator already exists
                    if (!lessonItem.querySelector('.completed-lesson')) {
                        const completionIndicator = document.createElement('i');
                        completionIndicator.className = 'fa fa-check-circle completed-lesson';
                        lessonItem.appendChild(completionIndicator);
                    }
                }

                // Show success message
                const successMessage = document.createElement('div');
                successMessage.className = 'alert alert-success mt-3';
                successMessage.innerHTML = 'Lesson marked as completed!';

                // Find appropriate container to add message to
                const container = document.querySelector('.video-lesson-container') ||
                    document.querySelector('.quiz-container') ||
                    document.getElementById('lesson-content');

                if (container) {
                    container.appendChild(successMessage);

                    // Remove the message after 3 seconds
                    setTimeout(function () {
                        successMessage.style.display = 'none';
                    }, 3000);
                }

                // Update progress if there's a progress bar
                updateProgressBar();
            },
            error: function (xhr, status, error) {
                console.error('Error marking lesson as completed:', error);
                alert('Error marking lesson as completed. Please try again.');
            }
        });
    }

    // Update progress bar
    function updateProgressBar() {
        // Count completed lessons
        const completedLessons = document.querySelectorAll('.completed-lesson').length;
        const totalLessons = document.querySelectorAll('.lesson-item').length;

        // Calculate percentage
        let progressPercentage = 0;
        if (totalLessons > 0) {
            progressPercentage = Math.floor((completedLessons * 100) / totalLessons);
        }

        // Update progress bar
        const progressBar = document.querySelector('.progress-bar');
        if (progressBar) {
            progressBar.style.width = progressPercentage + '%';
            progressBar.setAttribute('aria-valuenow', progressPercentage);

            // Update text if needed
            const progressText = document.querySelector('.progress-text');
            if (progressText) {
                progressText.textContent = `${completedLessons}/${totalLessons} completed (${progressPercentage}%)`;
            }
        }
    }

    // Initialize the first subject as open
    document.addEventListener('DOMContentLoaded', function () {
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

        // Add CSS for active lesson
        const style = document.createElement('style');
        style.textContent = `
                    .lesson-item.active {
                        background-color: #f1f1f1;
                        border-left: 3px solid #4c1864;
                    }
                    .completed-lesson {
                        color: #28a745;
                        margin-left: 10px;
                    }
                `;
        document.head.appendChild(style);

        // Initialize video tracking if video exists
        trackVideoProgress();

        // Initialize progress bar
        updateProgressBar();

        // Highlight current lesson in sidebar if one is selected
        highlightCurrentLesson();
    });

    // Highlight current lesson in sidebar
    function highlightCurrentLesson() {
        // Get lesson ID from URL
        const urlParams = new URLSearchParams(window.location.search);
        const currentLessonId = urlParams.get('lessonId');

        if (currentLessonId) {
            // Find and highlight the lesson item
            const lessonItems = document.querySelectorAll('.lesson-item');
            lessonItems.forEach(item => {
                // Remove active class from all items
                item.classList.remove('active');

                // Check if this is the current lesson using a more precise match
                const onclickValue = item.getAttribute('onclick') || '';
                // Check for exact match with the lessonId surrounded by quotes
                if (onclickValue.includes(`'${currentLessonId}'`)) {
                    item.classList.add('active');

                    // Ensure the parent subject is expanded
                    const parentSubject = item.closest('.subject-content');
                    if (parentSubject) {
                        parentSubject.style.display = 'block';

                        // Update the icon
                        const subjectId = parentSubject.id.replace('subject-', '');
                        const icon = document.getElementById('icon-' + subjectId);
                        if (icon) {
                            icon.className = 'fa fa-minus';
                        }
                    }
                }
            });
        }
    }

    // Handle quiz submission
    document.addEventListener('DOMContentLoaded', function () {
        const quizForm = document.getElementById('quiz-form');
        if (quizForm) {
            quizForm.addEventListener('submit', function (e) {
                e.preventDefault();

                // Get the lesson ID directly from the URL parameter
                const urlParams = new URLSearchParams(window.location.search);
                const lessonId = urlParams.get('lessonId');

                if (!lessonId) {
                    alert('Error: Lesson ID is missing. Please reload the page and try again.');
                    return;
                }

                // Create a new FormData object from the form
                const formData = new FormData(quizForm);

                // Remove any existing lessonId to avoid duplicates
                formData.delete('lessonId');

                // Add the lessonId parameter explicitly
                formData.append('lessonId', lessonId);

                // Log form data for debugging
                console.log('Submitting form with lessonId:', lessonId);

                // Try a different approach using URLSearchParams instead of FormData
                const searchParams = new URLSearchParams();

                // Add the lessonId parameter
                searchParams.append('lessonId', lessonId);

                // Add all form fields to the search params
                for (const pair of formData.entries()) {
                    searchParams.append(pair[0], pair[1]);
                }

                // Submit quiz via AJAX with URLSearchParams
                fetch('submit-quiz', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: searchParams.toString()
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            // Show success message and score
                            const resultHtml =
                                '<div class="alert alert-success">' +
                                '<h4>Quiz Completed!</h4>' +
                                '<p>Your score: ' + data.score + '%</p>' +
                                '<p>Correct answers: ' + data.correctAnswers + '/' + data.totalQuestions + '</p>' +
                                '<p>' + data.message + '</p>' +
                                '</div>';
                            document.querySelector('.quiz-container').innerHTML = resultHtml;

                            // Mark lesson as completed if passed
                            if (data.passed) {
                                markLessonAsCompleted(lessonId);
                            }
                        } else {
                            console.error('Quiz submission error:', data.message);
                            alert('Error submitting quiz: ' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('An error occurred while submitting the quiz. Please try again.');
                    });
            });
        }
    });
</script>
<script type="text/javascript">
        window.onload = function() {
    // Lấy giá trị TimeLimit từ request (giả sử giá trị là 5 phút){quiz.timeLimit}
    var timeLimitInMinutes = ${quiz.timeLimit};  // Ví dụ: 5 phút
    var timeLimitInSeconds = timeLimitInMinutes * 60; // Chuyển đổi sang giây

    // Hiển thị TimeLimit ban đầu (chuyển đổi từ giây sang phút và giây)
    function formatTime(seconds) {
        var minutes = Math.floor(seconds / 60);
        var remainingSeconds = seconds % 60;
        return minutes + "m " + remainingSeconds + "s";
    }

    document.getElementById("time").innerText = formatTime(timeLimitInSeconds);

    // Đếm ngược
    var countdown = setInterval(function() {
        timeLimitInSeconds--; // Giảm giá trị thời gian đi 1 giây
        document.getElementById("time").innerText = formatTime(timeLimitInSeconds);

        // Nếu thời gian hết, dừng đếm ngược và hiển thị thông báo
        if (timeLimitInSeconds <= 0) {
            clearInterval(countdown);
            alert("Time's up! Please submit your quiz!!!!!!!!!!");
        }
    }, 1000);  // Mỗi giây (1000ms) đếm ngược 1 lần
};
     </script>
</body>
</html>
