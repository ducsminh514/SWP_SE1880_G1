<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page isELIgnored="false" %>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Payment QR Code - Online Learning</title>

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
    </head>
    <body>
        <div class="page-wraper">
            <!-- Header -->
            <jsp:include page="header.jsp"></jsp:include>

            <!-- Content -->
            <div class="page-content bg-white">
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner2.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Payment QR Code</h1>
                        </div>
                    </div>
                </div>

                <div class="content-block">
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-8 col-md-12">
                                    <div class="payment-qr text-center">
                                        <h4>Scan QR Code to Pay</h4>
                                        <div class="qr-code-container">
                                            <img src="${qrCodeUrl}" alt="Payment QR Code" class="img-fluid">
                                        </div>

                                        <div class="payment-info mt-4">
                                            <p>Order ID: <strong>${orderId}</strong></p>
                                            <p>Amount: <strong>$${amount}</strong></p>
                                            <p>Course: <strong>${courseName}</strong></p>
                                        </div>

                                        <div class="payment-instructions mt-4">
                                            <h5>Payment Instructions:</h5>
                                            <ol class="text-left">
                                                <li>Open your VNPay app</li>
                                                <li>Scan the QR code above</li>
                                                <li>Confirm the payment amount</li>
                                                <li>Enter your PIN to complete the payment</li>
                                                <li>Wait for the confirmation message</li>
                                            </ol>
                                        </div>

                                        <div class="mt-4">
                                            <p class="text-muted">Please complete the payment within 15 minutes</p>
                                            <div id="countdown" class="h4 text-danger"></div>
                                        </div>

                                        <div class="mt-4">
                                            <a href="check-payment-status?orderId=${orderId}" class="btn btn-primary">I've Completed the Payment</a>
                                            <a href="javascript:history.back()" class="btn btn-secondary">Cancel</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <jsp:include page="footer.jsp"></jsp:include>
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

        <!-- Countdown Timer -->
        <script>
            // Set the countdown time to 15 minutes
            let timeLeft = 15 * 60; // 15 minutes in seconds

            function updateCountdown() {
                const minutes = Math.floor(timeLeft / 60);
                const seconds = timeLeft % 60;
                document.getElementById('countdown').innerHTML =
                    `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;

                if (timeLeft <= 0) {
                    clearInterval(timer);
                    document.getElementById('countdown').innerHTML = 'Time expired';
                    window.location.href = 'payment-failure.jsp';
                }
                timeLeft--;
            }

            const timer = setInterval(updateCountdown, 1000);
            updateCountdown();
        </script>
    </body>
</html>