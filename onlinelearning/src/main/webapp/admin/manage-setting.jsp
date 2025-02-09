<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/6/2025
  Time: 1:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><html>
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
<header class="ttr-header">
    <div class="ttr-header-wrapper">
        <!--sidebar menu toggler start -->
        <div class="ttr-toggle-sidebar ttr-material-button">
            <i class="ti-close ttr-open-icon"></i>
            <i class="ti-menu ttr-close-icon"></i>
        </div>
        <!--sidebar menu toggler end -->
        <!--logo start -->
        <div class="ttr-logo-box">
            <div>
                <a href="index.jsp" class="ttr-logo">
                    <img alt="" class="ttr-logo-mobile" src="assets/images/logo-mobile.png" width="30" height="30">
                    <img alt="" class="ttr-logo-desktop" src="assets/images/logo-white.png" width="160" height="27">
                </a>
            </div>
        </div>
        <!--logo end -->
        <div class="ttr-header-menu">
            <!-- header left menu start -->
            <ul class="ttr-header-navigation">
                <li>
                    <a href="../index.html" class="ttr-material-button ttr-submenu-toggle">HOME</a>
                </li>
                <li>
                    <a href="#" class="ttr-material-button ttr-submenu-toggle">QUICK MENU <i
                            class="fa fa-angle-down"></i></a>
                    <div class="ttr-header-submenu">
                        <ul>
                            <li><a href="../courses.html">Our Courses</a></li>
                            <li><a href="../event.html">New Event</a></li>
                            <li><a href="../membership.html">Membership</a></li>
                        </ul>
                    </div>
                </li>
            </ul>
            <!-- header left menu end -->
        </div>
        <div class="ttr-header-right ttr-with-seperator">
            <!-- header right menu start -->
            <ul class="ttr-header-navigation">
                <li>
                    <a href="#" class="ttr-material-button ttr-search-toggle"><i class="fa fa-search"></i></a>
                </li>
                <li>
                    <a href="#" class="ttr-material-button ttr-submenu-toggle"><i class="fa fa-bell"></i></a>
                    <div class="ttr-header-submenu noti-menu">
                        <div class="ttr-notify-header">
                            <span class="ttr-notify-text-top">9 New</span>
                            <span class="ttr-notify-text">User Notifications</span>
                        </div>
                        <div class="noti-box-list">
                            <ul>
                                <li>
										<span class="notification-icon dashbg-gray">
											<i class="fa fa-check"></i>
										</span>
                                    <span class="notification-text">
											<span>Sneha Jogi</span> sent you a message.
										</span>
                                    <span class="notification-time">
											<a href="#" class="fa fa-close"></a>
											<span> 02:14</span>
										</span>
                                </li>
                                <li>
										<span class="notification-icon dashbg-yellow">
											<i class="fa fa-shopping-cart"></i>
										</span>
                                    <span class="notification-text">
											<a href="#">Your order is placed</a> sent you a message.
										</span>
                                    <span class="notification-time">
											<a href="#" class="fa fa-close"></a>
											<span> 7 Min</span>
										</span>
                                </li>
                                <li>
										<span class="notification-icon dashbg-red">
											<i class="fa fa-bullhorn"></i>
										</span>
                                    <span class="notification-text">
											<span>Your item is shipped</span> sent you a message.
										</span>
                                    <span class="notification-time">
											<a href="#" class="fa fa-close"></a>
											<span> 2 May</span>
										</span>
                                </li>
                                <li>
										<span class="notification-icon dashbg-green">
											<i class="fa fa-comments-o"></i>
										</span>
                                    <span class="notification-text">
											<a href="#">Sneha Jogi</a> sent you a message.
										</span>
                                    <span class="notification-time">
											<a href="#" class="fa fa-close"></a>
											<span> 14 July</span>
										</span>
                                </li>
                                <li>
										<span class="notification-icon dashbg-primary">
											<i class="fa fa-file-word-o"></i>
										</span>
                                    <span class="notification-text">
											<span>Sneha Jogi</span> sent you a message.
										</span>
                                    <span class="notification-time">
											<a href="#" class="fa fa-close"></a>
											<span> 15 Min</span>
										</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li>
                    <a href="#" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar"><img alt=""
                                                                                                                  src="assets/images/testimonials/pic3.jpg"
                                                                                                                  width="32"
                                                                                                                  height="32"></span></a>
                    <div class="ttr-header-submenu">
                        <ul>
                            <li><a href="user-profile.html">My profile</a></li>
                            <li><a href="list-view-calendar.html">Activity</a></li>
                            <li><a href="mailbox.html">Messages</a></li>
                            <li><a href="../login.html">Logout</a></li>
                        </ul>
                    </div>
                </li>
                <li class="ttr-hide-on-mobile">
                    <a href="#" class="ttr-material-button"><i class="ti-layout-grid3-alt"></i></a>
                    <div class="ttr-header-submenu ttr-extra-menu">
                        <a href="#">
                            <i class="fa fa-music"></i>
                            <span>Musics</span>
                        </a>
                        <a href="#">
                            <i class="fa fa-youtube-play"></i>
                            <span>Videos</span>
                        </a>
                        <a href="#">
                            <i class="fa fa-envelope"></i>
                            <span>Emails</span>
                        </a>
                        <a href="#">
                            <i class="fa fa-book"></i>
                            <span>Reports</span>
                        </a>
                        <a href="#">
                            <i class="fa fa-smile-o"></i>
                            <span>Persons</span>
                        </a>
                        <a href="#">
                            <i class="fa fa-picture-o"></i>
                            <span>Pictures</span>
                        </a>
                    </div>
                </li>
            </ul>
            <!-- header right menu end -->
        </div>
        <!--header search panel start -->
        <div class="ttr-search-bar">
            <form class="ttr-search-form">
                <div class="ttr-search-input-wrapper">
                    <input type="text" name="qq" placeholder="search something..." class="ttr-search-input">
                    <button type="submit" name="search" class="ttr-search-submit"><i class="ti-arrow-right"></i>
                    </button>
                </div>
                <span class="ttr-search-close ttr-search-toggle">
						<i class="ti-close"></i>
					</span>
            </form>
        </div>
        <!--header search panel end -->
    </div>
</header>
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
        <nav class="ttr-sidebar-navi">
            <ul>
                <li>
                    <a href="index.jsp" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-home"></i></span>
                        <span class="ttr-label">Dashborad</span>
                    </a>
                </li>
                <li>
                    <a href="courses.html" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-book"></i></span>
                        <span class="ttr-label">Courses</span>
                    </a>
                </li>
                <li>
                    <a href="#" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-email"></i></span>
                        <span class="ttr-label">Mailbox</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul>
                        <li>
                            <a href="mailbox.html" class="ttr-material-button"><span
                                    class="ttr-label">Mail Box</span></a>
                        </li>
                        <li>
                            <a href="mailbox-compose.html" class="ttr-material-button"><span
                                    class="ttr-label">Compose</span></a>
                        </li>
                        <li>
                            <a href="mailbox-read.html" class="ttr-material-button"><span
                                    class="ttr-label">Mail Read</span></a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-calendar"></i></span>
                        <span class="ttr-label">Calendar</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul>
                        <li>
                            <a href="basic-calendar.html" class="ttr-material-button"><span class="ttr-label">Basic Calendar</span></a>
                        </li>
                        <li>
                            <a href="list-view-calendar.html" class="ttr-material-button"><span class="ttr-label">List View</span></a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="bookmark.html" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-bookmark-alt"></i></span>
                        <span class="ttr-label">Bookmarks</span>
                    </a>
                </li>
                <li>
                    <a href="review.html" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-comments"></i></span>
                        <span class="ttr-label">Review</span>
                    </a>
                </li>
                <li>
                    <a href="add-listing.html" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-layout-accordion-list"></i></span>
                        <span class="ttr-label">Add listing</span>
                    </a>
                </li>
                <li>
                    <a href="#" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-user"></i></span>
                        <span class="ttr-label">My Profile</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul>
                        <li>
                            <a href="user-profile.html" class="ttr-material-button"><span
                                    class="ttr-label">User Profile</span></a>
                        </li>
                        <li>
                            <a href="teacher-profile.html" class="ttr-material-button"><span class="ttr-label">Teacher Profile</span></a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/manage-account" class="ttr-material-button">
                        <span class="ttr-icon"><i class="fa-solid fa-users"></i></span>
                        <span class="ttr-label">Manage account</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/manage-setting" class="ttr-material-button">
                        <span class="ttr-icon"><i class="fa-solid fa-gear"></i></span>
                        <span class="ttr-label">Setting list</span>
                    </a>
                </li>
                <li class="ttr-seperate"></li>
            </ul>
            <!-- sidebar menu end -->
        </nav>
        <!-- sidebar menu end -->
    </div>
</div>
<!-- Left sidebar menu end -->


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
                            <form action="${pageContext.request.contextPath}/manage-account" method="GET"
                                  class="mb-4" class="cours-search">
                                <div class="row mb-3" style="justify-content: space-between">
                                    <div class="col-md-3">
                                        <select class="form-select" id="typeFilter" name="type">
                                            <option value="">All type</option>
                                            <option value="system" >System</option>
                                            <option value="user">User</option>
                                            <option value="payment">Payment</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <select class="form-select" id="statusFilter" name="status">
                                            <option value="">All Status</option>
                                            <option value="true" >
                                                Active
                                            </option>
                                            <option value="false" >Non-active
                                            </option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="searchFilter"
                                               name="search" placeholder="Search by name"
                                               value="">
                                    </div>
                                    <div class="col-md-1">
                                        <button type="submit"
                                                style="width: 60%; background-color: #ffcc41 ;border-radius: 50%; display: flex; align-items: center; text-align: center"
                                                class="form-control text-light">
                                            <i class="fa fa-search mr-4"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="widget-inner ">
                            <table class="manage-acc-css table table-borderless ">
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

                                    <tr>
                                        <td>
                                            <p>id</p>
                                        </td>
                                        <td>
                                            <p>full nam</p>
                                        </td>
                                        <td>
                                            <p>a</p>
                                        </td>
                                        <td>
                                            <p>b</p>
                                        </td>
                                        <td>
                                        <span >
                                               active</span>
                                        </td>
                                        <td>
                                            <div style="text-align: center;">
                                                <a class="btn button-sm green radius-xl"
                                                   href=""
                                                   title="Edit"><i class="fa-solid fa-pen-to-square"></i></a>
                                                <a class="btn button-sm red radius-xl" href="#"
                                                   onclick="" title="deactive"><i
                                                        class="fa-solid fa-trash"></i></a>
                                            </div>
                                        </td>
                                    </tr>
                            </table>
                        </div>
                    </div>
<%--                    <div class="pagination-bx rounded-sm gray clearfix">--%>
<%--                        <ul class="pagination" style="justify-content: center;">--%>
<%--                            <c:if test="${currentPage > 1}">--%>
<%--                                <li class="previous">--%>
<%--                                    <a href="${paginationUrl}&page=${currentPage - 1}">--%>
<%--                                        <i class="ti-arrow-left"></i> Prev--%>
<%--                                    </a>--%>
<%--                                </li>--%>
<%--                            </c:if>--%>

<%--                            <c:forEach begin="1" end="${totalPage}" var="i">--%>
<%--                                <li class="${currentPage == i ? 'active' : ''}">--%>
<%--                                    <a href="${paginationUrl}&page=${i}">${i}</a>--%>
<%--                                </li>--%>
<%--                            </c:forEach>--%>

<%--                            <c:if test="${currentPage < totalPage}">--%>
<%--                                <li class="next">--%>
<%--                                    <a href="${paginationUrl}&page=${currentPage + 1}">--%>
<%--                                        Next <i class="ti-arrow-right"></i>--%>
<%--                                    </a>--%>
<%--                                </li>--%>
<%--                            </c:if>--%>
<%--                        </ul>--%>
<%--                    </div>--%>
                </div>
            </div>
            <!-- Your Profile Views Chart END-->
        </div>
    </div>
</main>
<div class="ttr-overlay"></div>

<!-- External JavaScripts -->
<jsp:include page="../common/common_admin_js.jsp"></jsp:include>

<script>
    function confirmDeactive(userId) {
        if (confirm('Are you sure you want to deactivate this user?')) {
            window.location.href = '${pageContext.request.contextPath}/manage-account?action=deactive&userId=' + userId;
        }
    }
</script>
</body>
</html>
