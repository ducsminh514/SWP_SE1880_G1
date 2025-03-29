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

    <!-- Bootstrap Select CSS -->
</head>
<body class="ttr-opened-sidebar ttr-pinned-sidebar">

<!-- header start -->
<jsp:include page="../common/common_admin_header.jsp"></jsp:include>
<!-- header end -->
<!-- Left sidebar menu start -->
<jsp:include page="../common/common_admin_sidebar_menu.jsp"></jsp:include>
<!-- Left sidebar menu end -->


<c:url value="/manage-account" var="paginationUrl">
    <c:param name="action" value="list"/>
    <c:if test="${not empty param.role}">
        <c:param name="role" value="${param.role}"/>
    </c:if>
    <c:if test="${not empty param.gender}">
        <c:param name="gender" value="${param.gender}"/>
    </c:if>
    <c:if test="${not empty param.status}">
        <c:param name="status" value="${param.status}"/>
    </c:if>
    <c:if test="${not empty param.search}">
        <c:param name="search" value="${param.search}"/>
    </c:if>
</c:url>

<!--Main container start -->
<main class="ttr-wrapper">
    <div class="container-fluid">
        <div class="db-breadcrumb">
            <h4 class="breadcrumb-title">Manage Account</h4>
            <ul class="db-breadcrumb-list">
                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                <li>Manage Account</li>
            </ul>
        </div>
        <div class="row">
            <!-- Your Profile Views Chart -->
            <div class="col-lg-12 m-b30">
                <div class="widget-box">
                    <div class="wc-title">
                        <h4>Manage account</h4>
                    </div>
                    <div class="widget-box">
                        <div class="widget-inner ">
                            <form action="${pageContext.request.contextPath}/manage-account" method="GET"
                                  class="mb-4" class="">
                                <div class="row mb-3" style="justify-content: flex-end">
                                    <div class="col-md-2">
                                        <select class="form-control" id="genderFilter" name="gender">
                                            <option value="">Gender</option>
                                            <option value="Male" ${param.gender=='Male' ? 'selected' : '' }>Male</option>
                                            <option value="Female" ${param.gender=='Female' ? 'selected' : '' }>Female</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-control" id="roleFilter" name="role">
                                            <option value="">All Roles</option>
                                            <option value="2" ${param.role=='2' ? 'selected' : '' }>Expert</option>
                                            <option value="3" ${param.role=='3' ? 'selected' : '' }>Marketing</option>
                                            <option value="4" ${param.role=='4' ? 'selected' : '' }>Sale</option>
                                            <option value="5" ${param.role=='5' ? 'selected' : '' }>Customer</option>
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
                                    <div class="col-md-4">
                                        <input type="text" class="form-control" id="searchFilter"
                                               name="search" placeholder="Search by name"
                                               value="${param.search}">
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn-outline-primary form-control ">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="widget-inner">
                            <table class="table table-striped table-bordered table-hover table-responsive-xl">
                                <!-- ... table header ... -->
                                <thead>
                                <tr>
                                    <th>Account ID</th>
                                    <th>Full Name</th>
                                    <th>Gender</th>
                                    <th>Email</th>
                                    <th>Moble</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th style="text-align: center;">Action</th>
                                </tr>
                                </thead>
                                <c:forEach var="acc" items="${userList}">
                                    <tr>
                                        <td>
                                            <p>${acc.getUserId()}</p>
                                        </td>
                                        <td>
                                            <p>${acc.getFirstName()} ${acc.getLastName()}</p>
                                        </td>
                                        <td>
                                            <p>${acc.gender}</p>
                                        </td>
                                        <td>
                                            <p>${acc.getEmail()}</p>
                                        </td>
                                        <td>
                                            <p>${acc.getPhoneNumber()}</p>
                                        </td>
                                        <td>
                                            <p>${acc.getRole().getRoleName()}</p>
                                        </td>
                                        <td>
                                            <span
                                                    <c:if test="${acc.status}">
                                                        class="btn green radius-xl outline"
                                                    </c:if>
                                                <c:if test="${!acc.status}">
                                                    class="btn red radius-xl outline"
                                                </c:if>>
                                                    ${acc.status ? 'Active' : 'Non-active'}
                                            </span>
                                        </td>
                                        <td>
                                            <div style="text-align: center; display: flex; justify-content: space-evenly; align-items: center;">
                                                <a class="btn button-sm green radius-xl"
                                                   style="display: flex; align-items: center"
                                                   href="${pageContext.request.contextPath}/manage-account?action=edit&userId=${acc.getUserId()}"
                                                   title="Edit">
                                                    <i class="fa-solid fa-pen-to-square"></i>
                                                </a>
                                                <a class="btn button-sm red radius-xl" href="#"
                                                   style="display: flex; align-items: center"
                                                   onclick="confirmDeactive(${acc.getUserId()})" title="deactive">
                                                    <i class="fa-solid fa-trash"></i>
                                                </a>
                                            </div>
                                        </td>
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
<div class="ttr-overlay"></div>
<div style="padding-top: 80px;" >
    <jsp:include page="../footer.jsp"></jsp:include>
</div>
<!-- External JavaScripts -->
<jsp:include page="../common/common_admin_js.jsp"></jsp:include>


<%--<script>--%>
<%--    function confirmDeactive(userId) {--%>
<%--        if (confirm('Are you sure you want to deactivate this user?')) {--%>
<%--            window.location.href = '${pageContext.request.contextPath}/manage-account?action=deactive&userId=' + userId;--%>
<%--        }--%>
<%--    }--%>

<%--    $(document).ready(function() {--%>
<%--        // Khởi tạo selectpicker--%>
<%--        $('.selectpicker').selectpicker({--%>
<%--            style: 'btn-default',--%>
<%--            size: 4--%>
<%--        });--%>
<%--        --%>
<%--        // Đảm bảo rằng selectpicker được refresh sau khi trang đã tải xong--%>
<%--        setTimeout(function() {--%>
<%--            $('.selectpicker').selectpicker('refresh');--%>
<%--        }, 100);--%>
<%--    });--%>
<%--</script>--%>

<!-- Thêm vào phần cuối trang, trước thẻ </body> -->

</body>

</html>
