<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page isELIgnored="false" %>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Order Confirmation - Online Learning</title>

        <!-- All PLUGINS CSS -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <!-- TYPOGRAPHY -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
        <!-- SHORTCODES -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
        <!-- STYLESHEETS -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <style>
            .checkout-container {
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                overflow: hidden;
                margin-top: -50px;
                position: relative;
                z-index: 1;
            }

            .checkout-header {
                background: linear-gradient(135deg, var(--primary) 0%, #4a4aff 100%);
                color: white;
                padding: 20px 30px;
                border-radius: 10px 10px 0 0;
            }

            .checkout-header h3 {
                margin: 0;
                font-weight: 600;
                color: white;
            }

            .checkout-steps {
                display: flex;
                justify-content: center;
                padding: 20px 0;
                border-bottom: 1px solid #eee;
            }

            .step {
                display: flex;
                flex-direction: column;
                align-items: center;
                position: relative;
                width: 150px;
            }

            .step-number {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: #f0f0f0;
                color: #666;
                display: flex;
                justify-content: center;
                align-items: center;
                margin-bottom: 8px;
                font-weight: bold;
                position: relative;
                z-index: 1;
            }

            .step.active .step-number {
                background-color: var(--primary);
                color: white;
            }

            .step:not(:last-child):after {
                content: '';
                position: absolute;
                top: 20px;
                right: -75px;
                width: 150px;
                height: 2px;
                background-color: #f0f0f0;
                z-index: 0;
            }

            .step.active:not(:last-child):after {
                background-color: var(--primary);
            }

            .step-label {
                font-size: 14px;
                color: #666;
                text-align: center;
            }

            .step.active .step-label {
                color: var(--primary);
                font-weight: 600;
            }

            .checkout-body {
                padding: 30px;
            }

            .info-section {
                background-color: #f9f9f9;
                border-radius: 8px;
                padding: 25px;
                margin-bottom: 25px;
            }

            .info-section h4 {
                margin-top: 0;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                color: var(--primary);
                font-weight: 600;
            }

            .info-section h4 i {
                margin-right: 10px;
                background: var(--primary);
                color: white;
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                font-size: 14px;
            }

            .form-group label {
                font-weight: 600;
                color: #444;
                margin-bottom: 8px;
                display: block;
            }

            .form-control {
                height: 45px;
                border-radius: 5px;
                border: 1px solid #ddd;
                padding: 8px 15px;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 0.2rem rgba(var(--primary-rgb), 0.25);
            }

            .form-control[readonly] {
                background-color: #f8f9fa;
            }

            textarea.form-control {
                height: auto;
                resize: none;
            }

            .order-summary {
                background: #f9f9f9;
                border-radius: 8px;
                padding: 25px;
                height: 100%;
            }

            .order-summary h4 {
                margin-top: 0;
                margin-bottom: 20px;
                color: var(--primary);
                font-weight: 600;
                display: flex;
                align-items: center;
            }

            .order-summary h4 i {
                margin-right: 10px;
                background: var(--primary);
                color: white;
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                font-size: 14px;
            }

            .summary-item {
                display: flex;
                justify-content: space-between;
                margin-bottom: 15px;
                padding-bottom: 15px;
                border-bottom: 1px dashed #ddd;
            }

            .summary-item:last-child {
                border-bottom: none;
            }

            .summary-item.total {
                border-top: 2px solid #ddd;
                border-bottom: none;
                padding-top: 15px;
                margin-top: 15px;
                font-weight: bold;
                font-size: 18px;
            }

            .course-info {
                border-left: 4px solid var(--primary);
                padding-left: 15px;
                margin-bottom: 20px;
            }

            .course-info h5 {
                color: #333;
                margin-bottom: 5px;
            }

            .btn-proceed {
                height: 50px;
                font-weight: 600;
                font-size: 16px;
                letter-spacing: 0.5px;
                width: 100%;
                margin-top: 20px;
                background: linear-gradient(135deg, var(--primary) 0%, #4a4aff 100%);
                border: none;
                border-radius: 5px;
                box-shadow: 0 4px 15px rgba(var(--primary-rgb), 0.3);
                transition: all 0.3s ease;
            }

            .btn-proceed:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(var(--primary-rgb), 0.4);
            }

            .secure-badge {
                display: flex;
                align-items: center;
                justify-content: center;
                margin-top: 20px;
                color: #666;
                font-size: 14px;
            }

            .secure-badge i {
                color: green;
                margin-right: 5px;
            }

            .payment-methods {
                margin-top: 20px;
                text-align: center;
            }

            .payment-methods img {
                height: 30px;
                margin: 0 5px;
                opacity: 0.6;
            }

            @media (max-width: 768px) {
                .checkout-steps {
                    display: none;
                }

                .order-summary {
                    margin-top: 30px;
                }
            }
        </style>
    </head>
    <body>
        <div class="page-wraper">
            <!-- Header -->
            <jsp:include page="HeaderTransaction.jsp"></jsp:include>

            <!-- Content -->
            <div class="page-content bg-light">
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner2.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Complete Your Order</h1>
                            <p class="text-white">You're just a few steps away from accessing your course</p>
                        </div>
                    </div>
                </div>

                <c:set value="${sessionScope.account}" var="user"/>
                <c:set value="${requestScope.Course}" var="course"/>
                <c:set value="${requestScope.PricePackage}" var="pricePackage"/>

                <div class="content-block">
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="checkout-container">
                                <div class="checkout-header">
                                    <h3><i class="fa fa-shopping-cart"></i> Order Confirmation</h3>
                                </div>

                                <div class="checkout-steps">
                                    <div class="step">
                                        <div class="step-number">1</div>
                                        <div class="step-label">Select Course</div>
                                    </div>
                                    <div class="step">
                                        <div class="step-number">2</div>
                                        <div class="step-label">Choose Package</div>
                                    </div>
                                    <div class="step active">
                                        <div class="step-number">3</div>
                                        <div class="step-label">Confirm Order</div>
                                    </div>
                                    <div class="step">
                                        <div class="step-number">4</div>
                                        <div class="step-label">Payment</div>
                                    </div>
                                </div>

                                <div class="checkout-body">
                                    <div class="row">
                                        <div class="col-lg-8 col-md-12">
                                            <div class="info-section">
                                                <h4><i class="fas fa-graduation-cap"></i> Course Information</h4>
                                                <div class="course-info">
                                                    <h5>${course.courseName}</h5>
                                                    <p>${course.description}</p>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Price Package</label>
                                                            <input type="text" class="form-control" value="${pricePackage.priceCourseName}" readonly>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Price</label>
                                                            <input type="text" class="form-control" value="$${pricePackage.salePrice}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="info-section">
                                                <h4><i class="fas fa-user"></i> Customer Information</h4>
                                                <form action="payment" method="POST" id="orderForm">
                                                    <input type="hidden" name="courseId" value="${course.courseId}">
                                                    <input type="hidden" name="pricePackageId" value="${pricePackage.priceId}">
                                                    <input type="hidden" name="action" value="processPayment">

                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label>Full Name</label>
                                                                <input type="text" class="form-control" name="fullName" value="${user.firstName} ${user.lastName}" readonly>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label>Email</label>
                                                                <input type="email" class="form-control" name="email" value="${user.email}" readonly>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label>Phone Number</label>
                                                                <input type="tel" class="form-control" name="phone" value="${user.phoneNumber}" readonly>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label>Country</label>
                                                                <select class="form-control" name="country">
                                                                    <option value="Vietnam">Vietnam</option>
                                                                    <option value="USA">United States</option>
                                                                    <option value="UK">United Kingdom</option>
                                                                    <option value="Australia">Australia</option>
                                                                    <option value="Canada">Canada</option>
                                                                    <option value="Singapore">Singapore</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label>Address</label>
                                                        <textarea class="form-control" name="address" rows="3" required placeholder="Enter your full address"></textarea>
                                                    </div>

                                                    <div class="form-group">
                                                        <label>Special Instructions (Optional)</label>
                                                        <textarea class="form-control" name="note" rows="3" placeholder="Any specific requirements or notes for your order"></textarea>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 col-md-12">
                                            <div class="order-summary">
                                                <h4><i class="fas fa-receipt"></i> Order Summary</h4>

                                                <div class="summary-item">
                                                    <span>Course:</span>
                                                    <span><strong>${course.courseName}</strong></span>
                                                </div>

                                                <div class="summary-item">
                                                    <span>Package:</span>
                                                    <span>${pricePackage.priceCourseName }</span>
                                                </div>

                                                <div class="summary-item">
                                                    <span>Original Price:</span>
                                                    <span><del>$${pricePackage.price}</del></span>
                                                </div>

                                                <div class="summary-item">
                                                    <span>Discount:</span>
                                                    <span class="text-success">-$${pricePackage.price - pricePackage.salePrice}</span>
                                                </div>

                                                <div class="summary-item total">
                                                    <span>Total:</span>
                                                    <span class="text-primary">$${pricePackage.salePrice}</span>
                                                </div>

                                                <button type="submit" form="orderForm" class="btn btn-primary btn-proceed">
                                                    <i class="fas fa-credit-card mr-2"></i> Proceed to Payment
                                                </button>

                                                <div class="secure-badge">
                                                    <i class="fas fa-lock"></i> Secure Payment
                                                </div>

                                                <div class="payment-methods">
                                                    <img src="assets/images/payment/visa.png" alt="Visa">
                                                    <img src="assets/images/payment/mastercard.png" alt="Mastercard">
                                                    <img src="assets/images/payment/paypal.png" alt="PayPal">
                                                    <img src="assets/images/payment/vnpay.png" alt="VNPay">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <jsp:include page="FooterTransaction.jsp"></jsp:include>
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