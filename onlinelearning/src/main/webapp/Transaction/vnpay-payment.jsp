<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page isELIgnored="false" %>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>VNPay Payment - Online Learning</title>

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
            .payment-container {
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                overflow: hidden;
                margin-top: -50px;
                position: relative;
                z-index: 1;
            }

            .payment-header {
                background: linear-gradient(135deg, #009edb 0%, #0072bc 100%);
                color: white;
                padding: 20px 30px;
                border-radius: 10px 10px 0 0;
                text-align: center;
            }

            .payment-header h3 {
                margin: 0;
                font-weight: 600;
                color: white;
            }

            .payment-header .vnpay-logo {
                max-height: 40px;
                margin-bottom: 10px;
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

            .step.active .step-number,
            .step.completed .step-number {
                background-color: #0072bc;
                color: white;
            }

            .step.completed .step-number:after {
                content: '✓';
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

            .step.completed:not(:last-child):after,
            .step.active:not(:last-child):after {
                background-color: #0072bc;
            }

            .step-label {
                font-size: 14px;
                color: #666;
                text-align: center;
            }

            .step.active .step-label,
            .step.completed .step-label {
                color: #0072bc;
                font-weight: 600;
            }

            .payment-body {
                padding: 30px;
            }

            .qr-section {
                text-align: center;
                padding: 20px;
                border-radius: 8px;
                background-color: #f9f9f9;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            }

            .qr-container {
                display: inline-block;
                padding: 20px;
                border: 2px dashed #ddd;
                border-radius: 10px;
                background: white;
                margin: 20px 0;
            }

            .qr-code {
                height: 250px;
                width: 250px;
                margin: 0 auto;
            }

            .order-info {
                max-width: 500px;
                margin: 0 auto;
                background: white;
                padding: 20px;
                border-radius: 8px;
                border: 1px solid #eee;
                margin-bottom: 20px;
            }

            .info-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
                padding-bottom: 10px;
                border-bottom: 1px dashed #eee;
            }

            .info-row:last-child {
                border-bottom: none;
            }

            .info-label {
                font-weight: 600;
                color: #555;
            }

            .info-value {
                text-align: right;
                color: #111;
            }

            .info-value.highlight {
                color: #0072bc;
                font-weight: 600;
            }

            .payment-instructions {
                margin-top: 30px;
                padding: 0 20px;
            }

            .payment-instructions h4 {
                color: #333;
                margin-bottom: 15px;
                text-align: center;
            }

            .instruction-steps {
                list-style-type: none;
                padding: 0;
                counter-reset: step-counter;
            }

            .instruction-steps li {
                position: relative;
                padding-left: 35px;
                margin-bottom: 15px;
                color: #555;
            }

            .instruction-steps li:before {
                counter-increment: step-counter;
                content: counter(step-counter);
                position: absolute;
                left: 0;
                top: 0;
                width: 25px;
                height: 25px;
                background-color: #0072bc;
                border-radius: 50%;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 12px;
                font-weight: bold;
            }

            .timer-container {
                margin: 30px 0;
                text-align: center;
            }

            .timer-label {
                display: block;
                font-size: 14px;
                color: #666;
                margin-bottom: 10px;
            }

            .countdown {
                font-size: 24px;
                font-weight: bold;
                color: #e74c3c;
                display: inline-block;
                padding: 10px 20px;
                background: #f9f9f9;
                border-radius: 5px;
                border: 1px solid #eee;
            }

            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-top: 30px;
            }

            .btn-check-payment {
                background: #0072bc;
                color: white;
                padding: 12px 25px;
                border-radius: 5px;
                font-weight: 600;
                border: none;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-check-payment:hover {
                background: #005a99;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0,114,188,0.3);
            }

            .btn-cancel {
                background: #f5f5f5;
                color: #666;
                padding: 12px 25px;
                border-radius: 5px;
                font-weight: 600;
                border: 1px solid #ddd;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-cancel:hover {
                background: #e9e9e9;
            }

            .vnpay-badge {
                text-align: center;
                margin-top: 20px;
                color: #666;
                font-size: 14px;
            }

            .vnpay-badge img {
                height: 30px;
                margin-right: 10px;
                vertical-align: middle;
            }

            @media (max-width: 768px) {
                .checkout-steps {
                    display: none;
                }

                .qr-code {
                    height: 200px;
                    width: 200px;
                }

                .action-buttons {
                    flex-direction: column;
                    gap: 10px;
                }

                .btn-check-payment, .btn-cancel {
                    width: 100%;
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
                            <h1 class="text-white">VNPay Payment</h1>
                            <p class="text-white">Scan the QR code to complete your payment</p>
                        </div>
                    </div>
                </div>

                <c:set value="${sessionScope.account}" var="user"/>
                <c:set value="${sessionScope.selectedCourse}" var="course"/>
                <c:set value="${sessionScope.selectedPricePackage}" var="pricePackage"/>
                <c:set value="${requestScope.orderId}" var="orderId"/>
                <c:set value="${requestScope.qrCodeUrl}" var="qrCodeUrl"/>
                <c:set value="${requestScope.amount}" var="amount"/>

                <div class="content-block">
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="payment-container">
                                <div class="payment-header">
                                    <img src="assets/images/payment/vnpay-logo.png" alt="VNPay Logo" class="vnpay-logo">
                                    <h3>QR Code Payment</h3>
                                </div>

                                <div class="checkout-steps">
                                    <div class="step completed">
                                        <div class="step-number"></div>
                                        <div class="step-label">Select Course</div>
                                    </div>
                                    <div class="step completed">
                                        <div class="step-number"></div>
                                        <div class="step-label">Choose Package</div>
                                    </div>
                                    <div class="step completed">
                                        <div class="step-number"></div>
                                        <div class="step-label">Confirm Order</div>
                                    </div>
                                    <div class="step active">
                                        <div class="step-number">4</div>
                                        <div class="step-label">Payment</div>
                                    </div>
                                </div>

                                <div class="payment-body">
                                    <div class="row">
                                        <div class="col-lg-6 col-md-12">
                                            <div class="qr-section">
                                                <h4>Scan QR Code with VNPay App</h4>
                                                <div class="qr-container">
                                                    <a href="${qrCodeUrl}" target="_blank" class="btn btn-primary">
                                                        <i class="fas fa-external-link-alt"></i> Mở VNPay để thanh toán
                                                    </a>
                                                    <p class="mt-3">Hoặc quét mã QR bằng ứng dụng ngân hàng hỗ trợ VNPay</p>
                                                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=${qrCodeUrl}" alt="VNPay QR Code" class="qr-code">
                                                </div>

                                                <div class="timer-container">
                                                    <span class="timer-label">This QR code will expire in:</span>
                                                    <div class="countdown" id="countdown">15:00</div>
                                                </div>

                                                <div class="vnpay-badge">
                                                    <img src="assets/images/payment/vnpay-badge.png" alt="VNPay Secure">
                                                    Secured by VNPay
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-lg-6 col-md-12">
                                            <div class="order-info">
                                                <h4>Payment Information</h4>
                                                <div class="info-row">
                                                    <span class="info-label">Order ID:</span>
                                                    <span class="info-value">${orderId}</span>
                                                </div>
                                                <div class="info-row">
                                                    <span class="info-label">Course:</span>
                                                    <span class="info-value">${course.courseName}</span>
                                                </div>
                                                <div class="info-row">
                                                    <span class="info-label">Price Package:</span>
                                                    <span class="info-value">${pricePackage.priceCourseName}</span>
                                                </div>
                                                <div class="info-row">
                                                    <span class="info-label">Amount:</span>
                                                    <span class="info-value highlight">$${amount}</span>
                                                </div>
                                            </div>

                                            <div class="payment-instructions">
                                                <h4>How to Pay with VNPay</h4>
                                                <ol class="instruction-steps">
                                                    <li>Open the VNPay application on your smartphone</li>
                                                    <li>Select "Scan QR" option in the VNPay app</li>
                                                    <li>Scan the QR code displayed on this page</li>
                                                    <li>Verify the payment amount: $${amount}</li>
                                                    <li>Confirm the payment in your VNPay app</li>
                                                    <li>Wait for payment confirmation</li>
                                                </ol>
                                            </div>

                                            <div class="action-buttons">
                                                <form action="check-payment" method="POST">
                                                    <input type="hidden" name="orderId" value="${orderId}">
                                                    <button type="submit" class="btn-check-payment">
                                                        <i class="fas fa-check-circle mr-2"></i> I've Completed Payment
                                                    </button>
                                                </form>
                                                <a href="javascript:history.back()" class="btn-cancel">
                                                    <i class="fas fa-times-circle mr-2"></i> Cancel
                                                </a>
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

        <script>
            // Countdown timer
            function startCountdown(duration, display) {
                var timer = duration, minutes, seconds;
                var interval = setInterval(function () {
                    minutes = parseInt(timer / 60, 10);
                    seconds = parseInt(timer % 60, 10);

                    minutes = minutes < 10 ? "0" + minutes : minutes;
                    seconds = seconds < 10 ? "0" + seconds : seconds;

                    display.textContent = minutes + ":" + seconds;

                    if (--timer < 0) {
                        clearInterval(interval);
                        display.textContent = "Expired";
                        // Redirect to expired payment page or show message
                        alert("QR code has expired. Please try again.");
                        window.location.href = "payment-failure.jsp";
                    }
                }, 1000);
            }

            window.onload = function () {
                var fifteenMinutes = 60 * 15,
                    display = document.querySelector('#countdown');
                startCountdown(fifteenMinutes, display);
            };
        </script>
    </body>
</html>