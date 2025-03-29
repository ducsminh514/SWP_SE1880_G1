<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 3/29/2025
  Time: 11:26 AM
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
    <title>Admin - Manage Lesson Quizzes</title>

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
            <h4 class="breadcrumb-title">Manage Lesson Quizzes</h4>
            <ul class="db-breadcrumb-list">
                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                <li>Manage Lesson Quizzes</li>
            </ul>
        </div>

        <div class="row">
            <!-- Your Profile Views Chart -->
            <div class="col-lg-12 m-b30">
                <div class="widget-box">
                    <div class="wc-title">
                        <h4>Manage Lesson Quizzes</h4>
                    </div>

                    <div class="widget-body">
                        <div class="widget-inner">
                            <div class="d-flex justify-content-between mb-3">
                                <div></div>
                                <a href="admin-manage-lesson-quiz?action=add" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Add New Quiz
                                </a>
                            </div>

                            <table class="table table-striped table-bordered table-hover table-responsive-xl">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Course</th>
                                    <th>Subject</th>
                                    <th>Lesson Name</th>
                                    <th>Pass (%)</th>
                                    <th>Time (min)</th>
                                    <th>Attempts</th>
                                    <th>Status</th>
                                    <th>Media</th>
                                    <th style="text-align: center;">Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${lessonQuizzes}" var="quiz">
                                    <tr>
                                        <td><c:out value="${quiz.lessonQuizID}" /></td>
                                        <td><c:out value="${subjectMap[quiz.lesson.subjectId].course.courseName}" /></td>
                                        <td><c:out value="${subjectMap[quiz.lesson.subjectId].subjectName}" /></td>
                                        <td><c:out value="${quiz.lesson.lessonName}" /></td>
                                        <td><c:out value="${quiz.passPercentage}" />%</td>
                                        <td><c:out value="${quiz.timeLimit}" /></td>
                                        <td><c:out value="${quiz.attemptAllowed}" /></td>
                                        <td>
                                                <span class="btn ${quiz.status ? 'green' : 'red'} radius-xl outline">
                                                        ${quiz.status ? 'Active' : 'Inactive'}
                                                </span>
                                        </td>
                                        <td>
                                            <div class="d-flex">
                                                <c:if test="${not empty quiz.imageUrl}">
                                                    <div class="mr-2">
                                                        <img src="${pageContext.request.contextPath}${quiz.imageUrl}"
                                                             alt="Quiz Image" style="max-width: 50px; max-height: 50px;">
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty quiz.mp3Url}">
                                                    <div>
                                                        <audio controls style="max-width: 150px; height: 30px;">
                                                            <source src="${pageContext.request.contextPath}${quiz.mp3Url}" type="audio/mpeg">
                                                            Your browser does not support audio.
                                                        </audio>
                                                    </div>
                                                </c:if>
                                                <c:if test="${empty quiz.imageUrl && empty quiz.mp3Url}">
                                                    <span class="text-muted">None</span>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>
                                            <div style="text-align: center; display: flex; justify-content: space-evenly; align-items: center;">
                                                <a href="admin-manage-lesson-quiz?action=edit&id=${quiz.lessonQuizID}" class="btn button-sm green radius-xl" style="display: flex; align-items: center" title="Edit">
                                                    <i class="fa-solid fa-pen-to-square"></i>
                                                </a>
                                                <a href="admin-manage-lesson-quiz?action=manage&id=${quiz.lessonQuizID}" class="btn button-sm blue radius-xl" style="display: flex; align-items: center" title="Manage Questions">
                                                    <i class="fa-solid fa-list-check"></i>
                                                </a>
                                                <c:if test="${quiz.status}">
                                                    <a href="#" class="btn button-sm red radius-xl" style="display: flex; align-items: center"
                                                       onclick="confirmDeactivate(${quiz.lessonQuizID})" title="deactivate">
                                                        <i class="fa-solid fa-ban"></i>
                                                    </a>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Your Profile Views Chart END-->
        </div>

    </div>
</main>

<!-- Deactivate Confirmation Modal -->
<div class="modal fade" id="deactivateModal" tabindex="-1" role="dialog" aria-labelledby="deactivateModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deactivateModalLabel">Confirm Deactivation</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Are you sure you want to deactivate this quiz? It will no longer be accessible to users.</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                <a class="btn btn-danger" id="confirmDeactivateBtn" href="#">Deactivate</a>
            </div>
        </div>
    </div>
</div>

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

        // This is kept for backward compatibility if needed
        $('.delete-btn').on('click', function() {
            var quizId = $(this).data('id');
            $('#confirmDeactivateBtn').attr('href', 'admin-manage-lesson-quiz?action=deactivate&id=' + quizId);
        });
    });

    function confirmDeactivate(quizId) {
        $('#confirmDeactivateBtn').attr('href', 'admin-manage-lesson-quiz?action=deactivate&id=' + quizId);
        $('#deactivateModal').modal('show');
    }
</script>

</body>
</html>