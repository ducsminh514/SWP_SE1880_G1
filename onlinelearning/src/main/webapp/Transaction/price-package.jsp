<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page isELIgnored="false" %>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Select Price Package - Online Learning</title>

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
                            <h1 class="text-white">Select Price Package</h1>
                        </div>
                    </div>
                </div>

                <div class="content-block">
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-8 col-md-12">
                                    <div class="course-info">
                                        <h3>${course.courseName}</h3>
                                        <p>${course.description}</p>
                                    </div>

                                    <div class="price-packages mt-4">
                                        <h4>Available Price Packages</h4>
                                        <form action="select-price-package" method="POST">
                                            <input type="hidden" name="courseId" value="${course.courseId}">

                                            <c:forEach items="${pricePackages}" var="package">
                                                <div class="price-package-item">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio"
                                                               name="pricePackageId"
                                                               id="package${package.priceCourseId}"
                                                               value="${package.priceCourseId}"
                                                               required>
                                                        <label class="form-check-label" for="package${package.priceCourseId}">
                                                            <div class="package-details">
                                                                <h5>${package.name}</h5>
                                                                <p>${package.description}</p>
                                                                <div class="price-info">
                                                                    <span class="original-price">$${package.price}</span>
                                                                    <span class="sale-price">$${package.salePrice}</span>
                                                                </div>
                                                            </div>
                                                        </label>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                            <div class="mt-4">
                                                <button type="submit" class="btn btn-primary">Continue to Order</button>
                                                <a href="javascript:history.back()" class="btn btn-secondary">Back</a>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <div class="col-lg-4 col-md-12">
                                    <div class="course-summary">
                                        <h4>Course Summary</h4>
                                        <ul>
                                            <li><i class="fa fa-clock-o"></i> Duration: ${course.duration} hours</li>
                                            <li><i class="fa fa-book"></i> Lessons: ${course.lessons}</li>
                                            <li><i class="fa fa-users"></i> Students: ${course.students}</li>
                                            <li><i class="fa fa-language"></i> Language: ${course.language}</li>
                                        </ul>
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
    </body>
</html>