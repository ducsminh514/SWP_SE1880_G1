<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/6/2025
  Time: 1:12 PM
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
        </head>

        <body class="ttr-opened-sidebar ttr-pinned-sidebar">

            <!-- header start -->

        <jsp:include page="../common/common_admin_header.jsp"></jsp:include>
            <!-- header end -->
            <!-- Left sidebar menu start -->
            <div class="ttr-sidebar">
                <div class="ttr-sidebar-wrapper content-scroll">
                    <!-- side menu logo start -->
                    <div class="ttr-sidebar-logo">
                        <a href="#"><img alt="" src="assets/images/logo.png" width="122" height="27"></a>
                        <!-- <div class="ttr-sidebar-pin-button" title="Pin/Unpin Menu">
                            <i class="material-icons ttr-fixed-icon">gps_fixed</i>
                            <i class="material-icons ttr-not-fixed-icon">gps_not_fixed</i>
                        </div> -->
                        <div class="ttr-sidebar-toggle-button">
                            <i class="ti-arrow-left"></i>
                        </div>
                    </div>
                    <!-- side menu logo end -->
                    <!-- sidebar menu start -->
                <jsp:include page="../common/common_admin_sidebar_menu.jsp"></jsp:include>
                    <!-- sidebar menu end -->
                </div>
            </div>
            <!-- Left sidebar menu end -->

        <c:url value="/manage-setting" var="paginationUrl">
            <c:param name="action" value="list"/>
            <c:if test="${not empty param.type}">
                <c:param name="type" value="${param.type}"/>
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
                    <h4 class="breadcrumb-title">Manage Setting</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Manage Setting</li>
                    </ul>
                </div>
                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Manage setting</h4>
                            </div>
                            <div class="widget-body ">
                                <div class="widget-inner ">
                                    <form action="${pageContext.request.contextPath}/manage-setting" method="GET"
                                          class="mb-4">
                                        <div class="row mb-3" style="justify-content: space-between">
                                            <div class="col-md-2">
                                                <select class="form-control" id="typeFilter" name="type">
                                                    <option value="">All type</option>
                                                    <option value="system" ${param.type == "system" ? "selected" : ""} >System
                                                    </option>
                                                    <option value="user" ${param.type == "user" ? "selected" : ""} >User
                                                    </option>
                                                    <option value="payment" ${param.type == "payment" ? "selected" : ""}>
                                                        Payment
                                                    </option>
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

                                <div class="widget-inner ">
                                    <table class="table table-striped table-bordered table-hover table-responsive-xl">
                                        <!-- ... table header ... -->
                                        <thead>
                                            <tr>
                                                <th>Setting ID</th>
                                                <th>Type</th>
                                                <th>Value</th>
                                                <th>Order</th>
                                                <th>Status</th>
                                                <th style="text-align: center;">Action</th>
                                            </tr>
                                        </thead>
                                        <c:forEach items="${settingList}" var="setting">
                                            <tr>
                                                <td>
                                                    <p>${setting.settingId}</p>
                                                </td>
                                                <td>
                                                    <p>${setting.type}</p>
                                                </td>
                                                <td>
                                                    <p>${setting.value}</p>
                                                </td>

                                                <td>
                                                    <p>${setting.order}</p>
                                                </td>
                                                <td>
                                                    <span <c:if test="${setting.isStatus()}">
                                                            class="btn green radius-xl outline"
                                                        </c:if>
                                                        <c:if test="${!setting.isStatus()}">
                                                            class="btn red radius-xl outline"
                                                        </c:if>>
                                                        ${setting.status? 'Active' : 'Non-active'}
                                                    </span>
                                                </td>
                                                <td>
                                                    <div  style="text-align: center; display: flex; justify-content: space-evenly; align-items: center;">
                                                        <a class="btn button-sm green radius-xl" style="display: flex; align-items: center"
                                                           href="${pageContext.request.contextPath}/manage-setting?action=edit&settingId=${setting.getSettingId()}"
                                                           title="Edit"><i class="fa-solid fa-pen-to-square"></i></a>
                                                        <span class="btn button-sm red radius-xl" data-toggle="modal"
                                                              data-target="#delete-product-modal"
                                                              onclick="deleteSettingModel(${setting.settingId});"
                                                              title="deactive" style="display: flex; align-items: center">
                                                            <i class="fa-solid fa-trash"></i>
                                                        </span>

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
        <jsp:include page="../admin/deleteSetting.jsp"></jsp:include>

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

                function confirmDeactive(settingId) {
                    if (confirm('Are you sure you want to deactivate this setting?')) {
                        window.location.href = '${pageContext.request.contextPath}/manage-setting?action=deactive&settingId=' + settingId;
                    }
                }
        </script>
    </body>
</html>
