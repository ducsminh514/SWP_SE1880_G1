<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 3/29/2025
  Time: 11:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <title>Admin - Manage Quiz Questions</title>

    <!-- MOBILE SPECIFIC ============================================= -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- All PLUGINS CSS ============================================= -->
    <jsp:include page="../common/common_admin_css.jsp"></jsp:include>

    <style>
        /* Toast notification styles */
        .toast-container {
            position: fixed;
            top: 80px;
            right: 20px;
            z-index: 9999;
        }

        .toast {
            min-width: 250px;
            margin-bottom: 10px;
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            opacity: 0;
            transition: opacity 0.3s ease-in-out;
        }

        .toast.show {
            opacity: 1;
        }

        .toast-header {
            display: flex;
            align-items: center;
            padding: 0.5rem 0.75rem;
            background-color: rgba(0,0,0,0.03);
            border-bottom: 1px solid rgba(0,0,0,0.1);
        }

        .toast-body {
            padding: 0.75rem;
        }

        .toast-success .toast-header {
            background-color: #d4edda;
            color: #155724;
        }

        .toast-error .toast-header {
            background-color: #f8d7da;
            color: #721c24;
        }

        .quiz-info-card {
            border-left: 4px solid #4c1864;
            background-color: #f8f9fa;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }

        .quiz-info-card h5 {
            margin-bottom: 10px;
            color: #4c1864;
        }

        .quiz-info-card p {
            margin-bottom: 5px;
        }

        .question-card {
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 15px;
            margin-bottom: 15px;
            position: relative;
        }

        .question-card .actions {
            position: absolute;
            top: 15px;
            right: 15px;
        }

        .answer-option {
            margin-bottom: 8px;
            padding: 8px;
            border-radius: 4px;
        }

        .answer-option.correct {
            background-color: rgba(40, 167, 69, 0.1);
            border-left: 3px solid #28a745;
        }

        .answer-option.incorrect {
            background-color: rgba(255, 255, 255, 0.5);
            border-left: 3px solid #ddd;
        }
    </style>
</head>

<body class="ttr-opened-sidebar ttr-pinned-sidebar">

<!-- Toast notifications container -->
<div class="toast-container">
    <c:if test="${not empty sessionScope.toastMessage}">
        <div class="toast toast-${sessionScope.toastType} show" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <strong class="mr-auto">
                    <c:choose>
                        <c:when test="${sessionScope.toastType eq 'success'}">Success</c:when>
                        <c:otherwise>Error</c:otherwise>
                    </c:choose>
                </strong>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="toast-body">
                    ${sessionScope.toastMessage}
            </div>
        </div>
        <c:remove var="toastMessage" scope="session" />
        <c:remove var="toastType" scope="session" />
    </c:if>
</div>

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
            <h4 class="breadcrumb-title">Manage Quiz Questions</h4>
            <ul class="db-breadcrumb-list">
                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                <li><a href="${pageContext.request.contextPath}/admin-manage-lesson-quiz">Manage Lesson Quizzes</a></li>
                <li>Manage Quiz Questions</li>
            </ul>
        </div>

        <div class="row">
            <!-- Your Profile Views Chart -->
            <div class="col-lg-12 m-b30">
                <div class="widget-box">
                    <div class="wc-title">
                        <h4>Quiz Information</h4>
                    </div>
                    <div class="widget-body">
                        <div class="quiz-info-card">
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>Quiz Details</h5>
                                    <p><strong>Lesson Name:</strong> ${quiz.lesson.lessonName}</p>
                                    <p><strong>Subject:</strong> ${subject.subjectName}</p>
                                    <p><strong>Course:</strong> ${subject.course.courseName}</p>
                                </div>
                                <div class="col-md-4">
                                    <h5>Settings</h5>
                                    <p><strong>Pass Percentage:</strong> ${quiz.passPercentage}%</p>
                                    <p><strong>Time Limit:</strong> ${quiz.timeLimit} minutes</p>
                                    <p><strong>Attempts Allowed:</strong> ${quiz.attemptAllowed}</p>
                                </div>
                                <div class="col-md-4">
                                    <h5>Status</h5>
                                    <p><span class="btn ${quiz.status ? 'green' : 'red'} radius-xl outline">
                                        ${quiz.status ? 'Active' : 'Inactive'}
                                    </span></p>
                                    <c:if test="${not empty quiz.imageUrl || not empty quiz.mp3Url}">
                                        <p><strong>Media:</strong>
                                            <c:if test="${not empty quiz.imageUrl}">Image</c:if>
                                            <c:if test="${not empty quiz.imageUrl && not empty quiz.mp3Url}">, </c:if>
                                            <c:if test="${not empty quiz.mp3Url}">Audio</c:if>
                                        </p>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Questions Section -->
            <div class="col-lg-12 m-b30">
                <div class="widget-box">
                    <div class="wc-title">
                        <h4>Quiz Questions</h4>
                    </div>
                    <div class="widget-body">
                        <div id="questions-container">
                            <!-- Questions will be loaded here -->
                            <c:if test="${empty questions}">
                                <div class="alert alert-info">
                                    <p>No questions added to this quiz yet.</p>
                                </div>
                            </c:if>

                            <c:forEach items="${questions}" var="question" varStatus="loop">
                                <div class="question-card">
                                    <div class="actions">
                                        <a href="${pageContext.request.contextPath}/manage-question?action=edit&questionId=${question.questionId}" class="btn button-sm blue radius-xl" title="View Details">
                                            <i class="fa fa-eye"></i>
                                        </a>
                                    </div>
                                    <h5 class="mb-3">Question ${loop.index + 1}: ${question.content}</h5>
                                    <div class="answer-options">
                                        <c:forEach items="${question.options}" var="option">
                                            <div class="answer-option ${option.isCorrect ? 'correct' : 'incorrect'}">
                                                <div class="d-flex align-items-center">
                                                    <div class="mr-2">
                                                        <c:if test="${option.isCorrect}">
                                                            <i class="fa fa-check-circle text-success"></i>
                                                        </c:if>
                                                        <c:if test="${!option.isCorrect}">
                                                            <i class="fa fa-circle-o"></i>
                                                        </c:if>
                                                    </div>
                                                    <div>${option.content}</div>
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
            <!-- Your Profile Views Chart END-->
        </div>
    </div>
</main>

<div class="ttr-overlay"></div>

<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>

<!-- External JavaScripts -->
<jsp:include page="../common/common_admin_js.jsp"></jsp:include>

<script>
    $(document).ready(function() {
        // Toast notification auto-hide
        setTimeout(function() {
            $('.toast').fadeOut('slow');
        }, 5000);

        // Close toast when close button is clicked
        $('.close').on('click', function() {
            $(this).closest('.toast').fadeOut('slow');
        });
    });
</script>

</body>
</html>
