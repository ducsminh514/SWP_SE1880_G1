<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/12/2025
  Time: 10:17 PM
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
<jsp:include page="../common/common_admin_sidebar_menu.jsp"></jsp:include>
<!-- Left sidebar menu end -->

<main class="ttr-wrapper">
    <div class="container-fluid">
        <div class="db-breadcrumb">
            <h4 class="breadcrumb-title">Edit Setting</h4>
            <ul class="db-breadcrumb-list">
                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                <li>Edit Setting</li>
            </ul>
        </div>
        <div class="row">
            <!-- Your Profile Views Chart -->
            <div class="col-lg-12 m-b30">
                <div class="widget-box">
                    <div class="wc-title">
                        <h4>Setting List</h4>

                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <a href="${pageContext.request.contextPath}/manage-setting" class="btn btn-search">Back</a>
                            <form action="${pageContext.request.contextPath}/manage-setting" method="get">
                                <input type="hidden" name="action" value="add">
                                <input type="submit" class="btn btn-secondary" value="Add new Setting">
                            </form>
                        </div>
                    </div>
                    <div class="widget-inner">
                        <div class="row">
                            <div class="col-12">
                                <form action="${pageContext.request.contextPath}/manage-setting" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="settingId" value="${setting.settingId}">

                                    <div class="form-group">
                                        <label for="type">Type</label>
                                        <select id="type" name="type" class="form-control">
                                            <option value="user" ${setting.type == "user" ? "selected" : ""}>user</option>
                                            <option value="system"  ${setting.type == "system" ? "selected" : ""}>system</option>
                                            <option value="payment"  ${setting.type == "payment" ? "selected" : ""}>payment</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="value">value</label>
                                        <input class="form-control" type="text" id="value" name="value"
                                               value="${setting.value}">
                                    </div>
                                    <div class="form-group">
                                        <label for="order">Order</label>
                                        <input class="form-control" type="text" id="order" name="order"
                                               value="${setting.order}">
                                    </div>
                                    <div class="form-group">
                                        <label for="status">Status</label>
                                        <select class="form-control" id="status" name="status">
                                            <option value="true" ${setting.status ? 'selected' : ''}>Active</option>
                                            <option value="false" ${!setting.status  ? 'selected' : ''}>Inactive
                                            </option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="description">Description</label>
                                        <input class="form-control" type="text" id="description" name="description"
                                               value="${setting.description}">
                                    </div>
                                    <div class="form-group">
                                        <label for="createAt">Create At:</label>
                                        <input class="form-control" type="datetime-local" id="createAt" name="createAt" value="${setting.createdAt}" />
                                    </div>
                                    <div class="form-group">
                                        <label for="updateAt">Update At:</label>
                                        <input class="form-control" type="datetime-local" id="updateAt" name="updateAt" value="${currentTime}" readonly />
                                    </div>

                                    <div style="display:flex;justify-content: space-evenly;">
                                        <button class="btn" type="submit">Update Setting</button>
                                    </div>
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
