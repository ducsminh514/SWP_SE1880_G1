<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

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
				<a href="home" class="ttr-logo">
					<img class="ttr-logo-mobile" alt="" src="assets/images/logo-mobile.png" width="30" height="30">
					<img class="ttr-logo-desktop" alt="" src="assets/images/logo-white.png" width="160" height="27">
				</a>
			</div>
		</div>
		<!--logo end -->
		<div class="ttr-header-menu">
			<!-- header left menu start -->
			<ul class="ttr-header-navigation">
				<li>
					<a href="home" class="ttr-material-button ttr-submenu-toggle">HOME</a>
				</li>
				<li>
					<a href="#" class="ttr-material-button ttr-submenu-toggle">QUICK MENU <i class="fa fa-angle-down"></i></a>
					<div class="ttr-header-submenu">
						<ul>
							<li><a href="listCourse">Our Courses</a></li>
							<li><a href="event.jsp">Events</a></li>
							<li><a href="listPost">Blog</a></li>
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
										<span>New User</span> sent you a message.
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
										<a href="#">New course enrollment</a> received.
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
										<span>New blog post</span> published.
									</span>
									<span class="notification-time">
										<a href="#" class="fa fa-close"></a>
										<span> 2 May</span>
									</span>
								</li>
							</ul>
						</div>
					</div>
				</li>
				<c:if test="${sessionScope.account!=null}">
					<c:set value="${sessionScope.account}" var="account" />
					<li>
						<a href="#" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar"><img alt="" src="assets/images/testimonials/pic3.jpg" width="32" height="32"></span></a>
						<div class="ttr-header-submenu">
							<ul>
								<li><a href="profile?id=${sessionScope.account.userId}">My profile</a></li>
								<li><a href="ChangePassword.jsp">Change Password</a></li>
								<li><a href="logout">Logout</a></li>
							</ul>
						</div>
					</li>
				</c:if>
				<li class="ttr-hide-on-mobile">
					<a href="#" class="ttr-material-button"><i class="ti-layout-grid3-alt"></i></a>
					<div class="ttr-header-submenu ttr-extra-menu">
						<a href="listCourse">
							<i class="fa fa-book"></i>
							<span>Courses</span>
						</a>
						<a href="listPost">
							<i class="fa fa-file-text-o"></i>
							<span>Blog</span>
						</a>
						<a href="profile?id=${sessionScope.account.userId}">
							<i class="fa fa-user"></i>
							<span>Profile</span>
						</a>
						<c:choose>
							<c:when test="${account.role.roleId==1}">
								<a href="manage-account">
									<i class="fa fa-dashboard"></i>
									<span>Dashboard</span>
								</a>
							</c:when>
							<c:when test="${account.role.roleId==3}">
								<a href="manage-account">
									<i class="fa fa-dashboard"></i>
									<span>Dashboard</span>
								</a>
							</c:when>
							<c:when test="${account.role.roleId==4}">
								<a href="postList">
									<i class="fa fa-dashboard"></i>
									<span>Dashboard</span>
								</a>
							</c:when>
						</c:choose>
					</div>
				</li>
			</ul>
			<!-- header right menu end -->
		</div>
		<!--header search panel start -->
		<div class="ttr-search-bar">
			<form class="ttr-search-form" action="search" method="get">
				<div class="ttr-search-input-wrapper">
					<input type="text" name="query" placeholder="Search..." class="ttr-search-input">
					<button type="submit" class="ttr-search-submit"><i class="ti-arrow-right"></i></button>
				</div>
				<span class="ttr-search-close ttr-search-toggle">
					<i class="ti-close"></i>
				</span>
			</form>
		</div>
		<!--header search panel end -->
	</div>
</header>
