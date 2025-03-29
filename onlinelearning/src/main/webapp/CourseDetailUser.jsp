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

        .question-image img {
            max-width: 100%;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        .question-audio {
            width: 100%;
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
                                    <h5>Your Progress</h5>
                                </div>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar"

                                         aria-valuemin="0"
                                         aria-valuemax="100"></div>
                                </div>
                            </div>

                            <!-- Content display area -->
                            <div class="content-display" id="lesson-content">
                                <!-- Check if questions attribute exists (for quiz) -->
                                <c:if test="${not empty questions}">
                                    <div class="quiz-container">
                                        <h3 class="mb-4">Quiz </h3>

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
                                                                    <img src="${image.imageTitle}" alt="Question Image" class="img-fluid mb-2">
                                                                </c:forEach>
                                                            </div>
                                                        </c:if>

                                                        <!-- Display audio if available -->
                                                        <c:if test="${not empty question.mp3}">
                                                            <div class="question-audio mb-3">
                                                                <audio controls>
                                                                    <source src="${question.mp3}" type="audio/mpeg">
                                                                    Your browser does not support the audio element.
                                                                </audio>
                                                            </div>
                                                        </c:if>

                                                        <!-- Answer options based on question type -->
                                                        <c:choose>
                                                            <%-- Multiple choice question (type 1) --%>
                                                            <c:when test="${question.questionType.questionTypeId == 1}">
                                                                <div class="answer-options">
                                                                    <c:forEach items="${questionAnswersMap[question.questionId]}" var="answer">
                                                                        <div class="form-check mb-2">
                                                                            <input class="form-check-input"
                                                                                   type="radio"
                                                                                   name="question_${question.questionId}"
                                                                                   id="answer_${answer.answerId}"
                                                                                   value="${answer.answerId}">
                                                                            <label class="form-check-label" for="answer_${answer.answerId}">
                                                                                ${answer.content}
                                                                            </label>
                                                                        </div>
                                                                    </c:forEach>
                                                                </div>
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
                                                                    Unsupported question type
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                            <div class="text-center mt-4">
                                                <button type="submit" class="btn">Submit Quiz</button>
                                            </div>
                                        </form>
                                    </div>
                                </c:if>

                                <!-- Default content when no lesson is selected -->
                                <c:if test="${empty questions}">
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
                                                            <!-- Lesson Title -->
                                                            <div class="lesson-title">
                                                                ${lesson.lessonName}
                                                                <!-- Lesson Duration -->
                                                                <div class="lesson-duration">
                                                                    <c:choose>
                                                                        <c:when test="${lesson.type == 'VIDEO'}">
                                                                            <i class="fa fa-clock-o"></i> ${lesson.duration} min
                                                                        </c:when>
                                                                        <c:when test="${lesson.type == 'QUIZ'}">
                                                                            <i class="fa fa-question-circle"></i> Quiz
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <i class="fa fa-clock-o"></i> ${lesson.duration} min
                                                                        </c:otherwise>
                                                                    </c:choose>
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
    function loadLessonContent(lessonId, lessonType) {
        //base on lessonType, send request to controller
        window.location.href = 'lesson?lessonId=' + lessonId;
    }

    // Mark lesson as viewed
    function markLessonAsViewed(lessonId) {
        // Log to console (in a real app, this would call the server)
        console.log('Lesson ' + lessonId + ' viewed');
    }

    // Mark lesson as completed
    function markLessonAsCompleted(lessonId) {
        // AJAX request to mark lesson as completed
        $.ajax({
            url: 'mark-lesson-completed',
            type: 'POST',
            data: {
                lessonId: lessonId
            },
            success: function(response) {
                // Add completion indicator to lesson in sidebar
                const lessonItem = document.querySelector(`.lesson-item[onclick*="${lessonId}"]`);
                if (lessonItem && !lessonItem.querySelector('.completed-lesson')) {
                    const completionIndicator = document.createElement('div');
                    completionIndicator.innerHTML = '<i class="fa fa-check-circle completed-lesson"></i>';
                    lessonItem.appendChild(completionIndicator);
                }

                // Show success message
                const successMessage = document.createElement('div');
                successMessage.className = 'alert alert-success mt-3';
                successMessage.innerHTML = 'Lesson marked as completed!';
                document.getElementById('lesson-content').appendChild(successMessage);

                // Remove the message after 3 seconds
                setTimeout(function() {
                    successMessage.style.display = 'none';
                }, 3000);
            },
            error: function() {
                alert('Error marking lesson as completed. Please try again.');
            }
        });
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
    });

    // Handle quiz submission
    document.addEventListener('DOMContentLoaded', function() {
        const quizForm = document.getElementById('quiz-form');
        if (quizForm) {
            quizForm.addEventListener('submit', function(e) {
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
