<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="Express Checkout, Quick Payment, Online Learning" />
        <meta name="author" content="EduChamp" />
        <meta name="robots" content="index, follow" />

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp - Quick Checkout for Online Courses" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp - Express Checkout" />
        <meta property="og:description" content="Complete your purchase quickly without registration" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp - Express Checkout </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
        
        <style>
            .express-checkout-container {
                max-width: 900px;
                margin: 0 auto;
                padding: 30px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
            }
            
            .checkout-header {
                text-align: center;
                margin-bottom: 30px;
            }
            
            .checkout-header h2 {
                font-size: 28px;
                font-weight: 600;
                color: #333;
                margin-bottom: 10px;
            }
            
            .checkout-header p {
                color: #777;
                font-size: 16px;
            }
            
            .express-message {
                background-color: #e6f7ff;
                border-left: 4px solid #1890ff;
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 4px;
                font-size: 15px;
                color: #333;
            }
            
            .checkout-process-steps {
                display: flex;
                justify-content: space-between;
                margin-bottom: 30px;
                position: relative;
            }
            
            .checkout-process-steps:before {
                content: '';
                position: absolute;
                top: 20px;
                left: 0;
                right: 0;
                height: 2px;
                background: #f0f0f0;
                z-index: 1;
            }
            
            .step {
                position: relative;
                z-index: 2;
                text-align: center;
                width: 30%;
            }
            
            .step-number {
                width: 40px;
                height: 40px;
                line-height: 40px;
                background: #f7b205;
                color: #fff;
                border-radius: 50%;
                margin: 0 auto 10px;
                font-weight: 600;
            }
            
            .step.active .step-number {
                background: #f7b205;
            }
            
            .step.completed .step-number {
                background: #4caf50;
            }
            
            .step-name {
                font-size: 14px;
                color: #777;
            }
            
            .step.active .step-name {
                color: #333;
                font-weight: 600;
            }
            
            .checkout-summary {
                display: flex;
                background: #f8f9fa;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 30px;
            }
            
            .course-thumbnail {
                width: 25%;
                padding-right: 20px;
            }
            
            .course-thumbnail img {
                width: 100%;
                border-radius: 6px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            
            .course-info {
                flex: 1;
            }
            
            .course-info h3 {
                margin-top: 0;
                margin-bottom: 10px;
                font-size: 20px;
                font-weight: 600;
            }
            
            .course-meta {
                display: flex;
                margin-bottom: 10px;
                color: #777;
                font-size: 14px;
            }
            
            .meta-item {
                margin-right: 20px;
                display: flex;
                align-items: center;
            }
            
            .meta-item i {
                margin-right: 5px;
                color: #f7b205;
            }
            
            .price {
                font-size: 24px;
                font-weight: 600;
                color: #333;
            }
            
            .discount {
                display: flex;
                align-items: center;
                margin-top: 10px;
            }
            
            .original-price {
                text-decoration: line-through;
                color: #999;
                margin-right: 10px;
            }
            
            .discount-percentage {
                background: #f44336;
                color: #fff;
                padding: 3px 8px;
                border-radius: 4px;
                font-size: 12px;
            }
            
            .checkout-form {
                padding: 0 20px;
            }
            
            .form-row {
                display: flex;
                margin: 0 -10px;
                flex-wrap: wrap;
            }
            
            .form-group {
                padding: 0 10px;
                margin-bottom: 20px;
                width: 100%;
            }
            
            .form-group.half {
                width: 50%;
            }
            
            @media (max-width: 767px) {
                .form-group.half {
                    width: 100%;
                }
            }
            
            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #333;
            }
            
            .form-group input, .form-group select {
                width: 100%;
                height: 50px;
                padding: 0 15px;
                border: 1px solid #e1e1e1;
                border-radius: 4px;
                font-size: 15px;
                transition: all 0.3s;
            }
            
            .form-group input:focus, .form-group select:focus {
                border-color: #f7b205;
                box-shadow: 0 0 0 2px rgba(247, 178, 5, 0.2);
                outline: none;
            }
            
            .form-group small {
                display: block;
                margin-top: 6px;
                color: #777;
                font-size: 12px;
            }
            
            .form-action {
                margin-top: 30px;
                text-align: center;
            }
            
            .form-action button {
                height: 50px;
                padding: 0 30px;
                font-size: 16px;
                font-weight: 600;
                border-radius: 4px;
                background: #f7b205;
                color: #fff;
                border: none;
                cursor: pointer;
                transition: all 0.3s;
            }
            
            .form-action button:hover {
                background: #e0a200;
            }
            
            .secure-payment {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 15px;
                color: #777;
                font-size: 14px;
            }
            
            .secure-payment i {
                margin-right: 5px;
                color: #4caf50;
            }
            
            .login-option {
                text-align: center;
                margin-top: 20px;
                padding-top: 20px;
                border-top: 1px solid #f0f0f0;
                color: #777;
            }
            
            .login-option a {
                margin-left: 5px;
                color: #f7b205;
                font-weight: 500;
            }
            
            .alerts {
                margin-bottom: 20px;
            }
            
            .alert {
                padding: 15px;
                border-radius: 4px;
                margin-bottom: 15px;
            }
            
            .alert-success {
                background-color: #e8f5e9;
                color: #2e7d32;
                border: 1px solid #c8e6c9;
            }
            
            .alert-error {
                background-color: #ffebee;
                color: #c62828;
                border: 1px solid #ffcdd2;
            }
        </style>
    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            
            <!-- Header Top ==== -->
            <%@include file="HeaderTransaction.jsp" %>
            <!-- header END ==== -->
            
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner1.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Express Checkout</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="home">Home</a></li>
                            <li>Express Checkout</li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                
                <!-- Main content -->
                <div class="content-block">
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="express-checkout-container">
                                <div class="checkout-header">
                                    <h2>Express Checkout</h2>
                                    <p>Complete your purchase quickly without registration</p>
                                </div>
                                
                                <c:if test="${not empty expressCheckoutMessage}">
                                    <div class="express-message">
                                        <i class="fa fa-info-circle mr-2"></i> ${expressCheckoutMessage}
                                    </div>
                                </c:if>
                                
                                <div class="checkout-process-steps">
                                    <div class="step active">
                                        <div class="step-number">1</div>
                                        <div class="step-name">Your Information</div>
                                    </div>
                                    <div class="step">
                                        <div class="step-number">2</div>
                                        <div class="step-name">Payment</div>
                                    </div>
                                    <div class="step">
                                        <div class="step-number">3</div>
                                        <div class="step-name">Confirmation</div>
                                    </div>
                                </div>
                                
                                <!-- Alerts -->
                                <div class="alerts">
                                    <c:if test="${not empty requestScope.error}">
                                        <div class="alert alert-error">
                                            ${requestScope.error}
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty requestScope.success}">
                                        <div class="alert alert-success">
                                            ${requestScope.success}
                                        </div>
                                    </c:if>
                                </div>
                                
                                <!-- Course Summary -->
                                <div class="checkout-summary">
                                    <div class="course-thumbnail">
                                        <img src="${course.thumbnail != null ? course.thumbnail : 'assets/images/courses/pic1.jpg'}" alt="${course.courseName}">
                                    </div>
                                    <div class="course-info">
                                        <h3>${course.courseName}</h3>
                                        <div class="course-meta">
                                            <div class="meta-item">
                                                <i class="fa fa-user"></i> ${course.expert.user.firstName} ${course.expert.user.lastName}
                                            </div>
                                            <div class="meta-item">
                                                <i class="fa fa-clock"></i> ${course.createDate}
                                            </div>
                                            <div class="meta-item">
                                                <i class="fa fa-users"></i>Level:  ${course.level} 
                                            </div>
                                        </div>
                                        <div class="price">
                                            ${pricePackage.salePrice}đ
                                            <c:if test="${pricePackage.price > pricePackage.salePrice}">
                                                <div class="discount">
                                                    <span class="original-price">${pricePackage.price}đ</span>
                                                    <span class="discount-percentage">
                                                        ${Math.round((1 - pricePackage.salePrice / pricePackage.price) * 100)}% OFF
                                                    </span>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Checkout Form -->
                                <form class="checkout-form" action="express-checkout" method="post" id="expressCheckoutForm">
                                    <input type="hidden" name="courseId" value="${requestScope.course.courseId}">
                                    <input type="hidden" name="pricePackageId" value="${requestScope.pricePackage.priceId}">
                                    
                                    <div class="form-row">
                                        <div class="form-group half">
                                            <label for="firstName">First Name*</label>
                                            <input type="text" name="firstName" id="firstName" required 
                                                   placeholder="Enter your first name" value="${param.firstName}">
                                        </div>
                                        <div class="form-group half">
                                            <label for="lastName">Last Name*</label>
                                            <input type="text" name="lastName" id="lastName" required 
                                                   placeholder="Enter your last name" value="${param.lastName}">
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="email">Email*</label>
                                        <input type="email" name="email" id="email" required 
                                               placeholder="Enter your email address" value="${param.email}">
                                        <small>This will be used to send your course access details and receipt</small>
                                    </div>
                                    
                                    <div class="form-row">
                                        <div class="form-group half">
                                            <label for="phoneNumber">Phone Number*</label>
                                            <input type="tel" name="phoneNumber" id="phoneNumber" required 
                                                   placeholder="Enter your phone number" value="${param.phoneNumber}">
                                        </div>
                                        <div class="form-group half">
                                            <label for="gender">Gender*</label>
                                            <select name="gender" id="gender" required>
                                                <option value="" disabled selected>Select gender</option>
                                                <option value="Male" ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                <option value="Female" ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="password">Create Password (Optional)</label>
                                        <input type="password" name="password" id="password" 
                                               placeholder="Create a password for your account">
                                        <small>Leave blank if you want us to generate a secure password for you</small>
                                    </div>
                                    
                                    <div class="form-action">
                                        <button type="submit" class="btn btn-primary btn-block">
                                            Continue to Payment
                                        </button>
                                        <div class="secure-payment">
                                            <i class="fa fa-lock"></i> Your information is secure
                                        </div>
                                    </div>
                                    
                                    <div class="login-option">
                                        <span>Already have an account?</span>
                                        <a href="login?redirect=payment&courseId=${param.courseId}&pricePackageId=${param.priceId}">Sign in</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Main content END -->
            </div>
            <!-- Content END-->
            
            <!-- Footer ==== -->
            <%@include file="FooterTransaction.jsp" %>
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
    </body>
</html> 