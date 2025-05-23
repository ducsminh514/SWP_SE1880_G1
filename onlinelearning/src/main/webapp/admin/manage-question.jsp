<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 1/30/2025
  Time: 5:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
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
    <title>EduChamp : Education HTML Template </title>

    <!-- MOBILE SPECIFIC ============================================= -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- All PLUGINS CSS ============================================= -->
    <jsp:include page="../common/common_admin_css.jsp"></jsp:include>

    <style>
        .dropdown-menu.open.show {
            max-height: 200px;
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

<c:url value="/manage-question" var="paginationUrl">
    <c:param name="action" value="list"/>
    <c:if test="${not empty param.subject}">
        <c:param name="subject" value="${param.subject}"/>
    </c:if>
    <c:if test="${not empty param.level}">
        <c:param name="level" value="${param.level}"/>
    </c:if>
    <c:if test="${not empty param.status}">
        <c:param name="status" value="${param.status}"/>
    </c:if>
    <c:if test="${not empty param.search}">
        <c:param name="search" value="${param.search}"/>
    </c:if>
    <c:if test="${not empty param.pageSize}">
        <c:param name="pageSize" value="${param.pageSize}"/>
    </c:if>
    <c:if test="${not empty paramValues.optionChoice}">
        <c:forEach items="${paramValues.optionChoice}" var="colum">
            <c:param name="optionChoice" value="${colum}"/>
        </c:forEach>
    </c:if>
</c:url>


<!--Main container start -->
<main class="ttr-wrapper">
    <div class="container-fluid">
        <div class="db-breadcrumb">
            <h4 class="breadcrumb-title">Manage Question</h4>
            <ul class="db-breadcrumb-list">
                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                <li>Manage Question</li>
            </ul>
        </div>
        <div class="row">
            <!-- Your Profile Views Chart -->
            <div class="col-lg-12 m-b30">
                <div class="widget-box">
                    <div class="wc-title">
                        <h4>Manage Question</h4>
                    </div>
                    <div class="widget-body ">
                        <div class="widget-inner ">
                            <form action="${paginationUrl}" method="GET"
                                  class="mb-4" class="cours-search">
                                <div class="row mb-3" style="justify-content: flex-end">
                                    <div class="col-md-2" >
                                        <select class="form-control" id="subjectFilter" name="subject" style="max-height: 100px; overflow-y: auto;">
                                            <option value="">All Subjects</option>
                                            <c:forEach items="${subjectList}" var="subject">
                                                <option value="${subject.subjectId}" ${param.subject == subject.subjectId ? "selected":"" }>${subject.subjectName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-control" id="levelFilter" name="level">
                                            <option value="">Level</option>
                                            <option value="1"  ${param.level == 1 ? "selected":"" }>Easy</option>
                                            <option value="2"  ${param.level == 2 ? "selected":"" }>Medium</option>
                                            <option value="3"  ${param.level == 3 ? "selected":"" }>Hard</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-control" id="statusFilter" name="status">
                                            <option value="">All Status</option>
                                            <option value="true" ${param.status=='true' ? 'selected' : '' }>
                                                Active
                                            </option>
                                            <option value="false" ${param.status=='false' ? 'selected' : ''
                                                    }>Non-active
                                            </option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="searchFilter"
                                               name="search" placeholder="Search by name"
                                               value="${param.search}">
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn-outline-primary form-control">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                    <div class="col-md-1">
                                        <button type="button" class="btn btn-primary" data-toggle="modal"
                                                data-target="#settingModal">
                                            Setting
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="widget-inner ">
                            <table class="table table-striped table-bordered table-hover table-responsive-xl">
                                <!-- ... table header ... -->
                                <thead>
                                <tr>
                                    <c:if test="${not empty listColum && listColum.contains('idChoice')}">
                                        <th>ID</th>
                                    </c:if>
                                    <c:if test="${not empty listColum && listColum.contains('contentChoice')}">
                                        <th>Content</th>
                                    </c:if>
                                    <c:if test="${not empty listColum && listColum.contains('subjectChoice')}">
                                        <th>Subject</th>
                                    </c:if>
                                    <c:if test="${not empty listColum && listColum.contains('levelChoice')}">
                                        <th>Level</th>
                                    </c:if>
                                    <c:if test="${not empty listColum && listColum.contains('typeChoice')}">
                                        <th>Type</th>
                                    </c:if>
                                    <c:if test="${not empty listColum && listColum.contains('statusChoice')}">
                                        <th>Status</th>
                                    </c:if>
                                    <c:if test="${not empty listColum && listColum.contains('actionChoice')}">
                                        <th style="text-align: center;">Action</th>
                                    </c:if>
                                </tr>
                                </thead>
                                <c:forEach items="${questionList}" var="question">
                                    <tr>
                                        <c:if test="${not empty listColum && listColum.contains('idChoice')}">
                                            <td>
                                                <p>${question.questionId}</p>
                                            </td>
                                        </c:if>
                                        <c:if test="${not empty listColum && listColum.contains('contentChoice')}">
                                            <td>
                                                <p>${question.content}</p>
                                            </td>
                                        </c:if>
                                        <c:if test="${not empty listColum && listColum.contains('subjectChoice')}">
                                            <td>
                                                <p>${question.subject.subjectName}</p>
                                            </td>
                                        </c:if>
                                        <c:if test="${not empty listColum && listColum.contains('levelChoice')}">
                                            <td>
                                                <c:if test="${question.level == 1}">
                                                    <p>Easy</p>
                                                </c:if>
                                                <c:if test="${question.level == 2}">
                                                    <p>Medium</p>
                                                </c:if>
                                                <c:if test="${question.level == 3}">
                                                    <p>Hard</p>
                                                </c:if>
                                            </td>
                                        </c:if>
                                        <c:if test="${not empty listColum && listColum.contains('typeChoice')}">
                                            <td>
                                                <p>${question.questionType.questionTypeName}</p>
                                            </td>
                                        </c:if>
                                        <c:if test="${not empty listColum && listColum.contains('statusChoice')}">
                                            <td>
                                            <span
                                                    <c:if
                                                            test="${question.status}">
                                                        class="btn green radius-xl outline"
                                                    </c:if>
                                            <c:if test="${!question.status}">
                                                class="btn red radius-xl outline"
                                            </c:if>>
                                                    ${question.status ? "Active" : "Inactive"}
                                            </span>
                                            </td>
                                        </c:if>
                                        <c:if test="${not empty listColum && listColum.contains('actionChoice')}">
                                            <td>
                                                <div style="text-align: center; display: flex; justify-content: space-evenly; align-items: center;">
                                                  
                                                    <a class="btn button-sm green radius-xl "
                                                       style="display: flex; align-items: center"
                                                       href="${pageContext.request.contextPath}/manage-question?action=edit&questionId=${question.questionId}"
                                                       title="Edit"><i class="fa-solid fa-pen-to-square"></i></a>
                                                    <a style="display: flex; align-items: center"
                                                       class="btn button-sm red radius-xl" href="#"
                                                       onclick="confirmDeactive(${question.questionId})"
                                                       title="deactive"><i
                                                            class="fa-solid fa-trash"></i></a>
                                                </div>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>

                    <div class="pagination-bx rounded-sm gray clearfix">
                        <ul class="pagination" style="justify-content: center;">
                            <c:if test="${currentPage > 1}">
                                <li class="previous">
                                    <a href="${paginationUrl}&page=${currentPage - 1}">
                                        <i class="ti-arrow-left"></i> Prev
                                    </a>
                                </li>
                            </c:if>


                            <c:forEach begin="1" end="${totalPage}" var="i">
                                <li class="${currentPage == i ? 'active' : ''}">
                                    <a href="${paginationUrl}&page=${i}">${i}</a>
                                </li>
                            </c:forEach>


                            <c:if test="${currentPage < totalPage}">
                                <li class="next">
                                    <a href="${paginationUrl}&page=${currentPage + 1}">
                                        Next <i class="ti-arrow-right"></i>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- Your Profile Views Chart END-->
        </div>
    </div>
</main>

<!-- Deactive Confirmation Modal -->
<div class="modal fade" id="deactiveModal" tabindex="-1" role="dialog" aria-labelledby="deactiveModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deactiveModalLabel">Confirm Deactivation</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Are you sure you want to deactivate this question? This will mark it as inactive and it will no longer be available for quizzes.</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                <a class="btn btn-danger" id="confirmDeactiveBtn" href="#">Deactivate</a>
            </div>
        </div>
    </div>
</div>

<div class="ttr-overlay"></div>

<!-- External JavaScripts -->
<jsp:include page="../admin/setting-in-page.jsp"></jsp:include>

<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
<jsp:include page="../common/common_admin_js.jsp"></jsp:include>

<!-- Script cuối trang -->
<script>
    // Toast message display
    var toastMessage = "${sessionScope.toastMessage}";
    var toastType = "${sessionScope.toastType}";
    if (toastMessage) {
        iziToast.show({
            title: toastType === 'success' ? 'Success' : 'Error',
            message: toastMessage,
            position: 'topRight',
            color: toastType === 'success' ? 'green' : 'red',
            timeout: 5000,
            onClosing: function () {
                // Remove toast attributes from the session after displaying
                fetch('${pageContext.request.contextPath}/remove-toast', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                }).then(response => {
                    if (!response.ok) {
                        console.error('Failed to remove toast attributes');
                    }
                }).catch(error => {
                    console.error('Error:', error);
                });
            }
        });
    }

    function confirmDeactive(questionId) {
        $('#confirmDeactiveBtn').attr('href', '${pageContext.request.contextPath}/manage-question?action=deactive&questionId=' + questionId);
        $('#deactiveModal').modal('show');
    }
</script>

</body>

</html>
