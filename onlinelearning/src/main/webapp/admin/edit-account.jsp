<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/2/2025
  Time: 10:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<jsp:include page="../common/common_admin_sidebar_menu.jsp"></jsp:include>
<!-- Left sidebar menu end -->

<!--Main container start -->
<main class="ttr-wrapper">
    <div class="container-fluid">
        <div class="db-breadcrumb">
            <h4 class="breadcrumb-title">Edit Profile</h4>
            <ul class="db-breadcrumb-list">
                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                <li>Edit User Profile</li>
            </ul>
        </div>
        <div class="row">
            <!-- Your Profile Views Chart -->
            <div class="col-lg-12 m-b30">
                <div class="widget-box">
                    <div class="wc-title">
                        <h4>User Profile</h4>
                    </div>
                    <div class="widget-inner">
                        <div class="row">
                            <div class="col-12">
                                <form action="${pageContext.request.contextPath}/manage-account" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="userId" value="${user.userId}">
                                    <div class="form-group">
                                        <label for="avatar">Avatar</label>
                                        <div class="ttr-user-avatar-profile " id="avatar"><img alt=""
                                                                                              src="assets/images/testimonials/pic3.jpg"
                                                                                              style="border-radius: 50%"
                                                                                              width="100" height="100">
                                        </div>
                                    </div >
                                    <div class="form-group">
                                        <label for="firstName">Fist Name</label>
                                        <input  class="form-control"  type="text"  id="firstName" name="firstName"
                                               value="${user.getFirstName()}" >
                                    </div>
                                    <div class="form-group">
                                        <label for="lastName">Last Name</label>
                                        <input  class="form-control"  type="text"  id="lastName" name="lastName"
                                                value="${user.getLastName()}" >
                                    </div>
                                    <div class="form-group">
                                        <label for="gender">Gender</label>
                                        <select id="gender" name="gender" class="form-control" >
                                            <option value="Male" ${user.gender eq "Male" ? "selected" : ""}>Male</option>
                                            <option value="Female" ${user.gender eq "Female" ? "selected" : ""}>Female</option>

                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input class="form-control"  type="email" id="email" name="email"
                                               value="${user.email}" >
                                    </div>
                                    <div class="form-group">
                                        <label for="phone">Phone Number</label>
                                        <input class="form-control"  type="text"  id="phone" name="phone" pattern="\d{10}" title="Số điện thoại phải chứa đúng 10 chữ số" required
                                               value="${user.phoneNumber}">
                                    </div>
                                    <div class="form-group">
                                        <label for="role">Role</label>
                                        <select class="form-control" id="role" name="role">
                                            <option value="2" ${user.role.getRoleId() == 2 ? 'selected' : ''}>Expert</option>
                                            <option value="3" ${user.role.getRoleId() == 3 ? 'selected' : ''}>Marketing</option>
                                            <option value="4" ${user.role.getRoleId() == 4 ? 'selected' : ''}>Sales</option>
                                            <option value="5" ${user.role.getRoleId() == 5 ? 'selected' : ''}>Customer</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="status">Status</label>
                                        <select class="form-control"  id="status" name="status">
                                            <option value="true" ${user.status ? 'selected' : ''}>Active</option>
                                            <option value="false" ${!user.status ? 'selected' : ''}>Inactive</option>
                                        </select>
                                    </div>
                                    <button class="btn-group btn btn-outline-dark" type="submit" >Update Account</button>
                                </form>
                            </div>
                        </div>
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
</script>
</body>

</html>
