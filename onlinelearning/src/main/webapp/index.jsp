<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp : Education HTML Template </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
<script src="assets/js/html5shiv.min.js"></script>
<script src="assets/js/respond.min.js"></script>
<![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <!-- REVOLUTION SLIDER CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/layers.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/settings.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/navigation.css">
        <!-- REVOLUTION SLIDER END -->
    </head>

    <body id="bg">
        <div class="page-wraper">
            <div id="container-xxl">
            <!-- Header Top ==== -->
            <%@include file="header.jsp" %>
            <!-- Header Top END ==== -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- Main Slider -->
                <div class="section-area section-sp1 ovpr-dark bg-fix online-cours"
                     style="background-image:url(assets/images/background/bg1.jpg);">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12 text-center text-white">
                                <h2>Online Courses To Learn</h2>
                                <h5>Own Your Feature Learning New Skills Online</h5>
                                <form class="cours-search">
                                    <div class="input-group">
                                        <input type="text" class="form-control"
                                               placeholder="What do you want to learn today?	">
                                        <div class="input-group-append">
                                            <button class="btn" type="submit">Search</button>
                                        </div>
                                    </div>
                                </form>a
                            </div>
                        </div>
                        <div class="mw800 m-auto">
                            <div class="row">
                                <div class="col-md-4 col-sm-6">
                                    <div class="cours-search-bx m-b30">
                                        <div class="icon-box">
                                            <h3><i class="ti-user"></i><span class="counter">5</span>M</h3>
                                        </div>
                                        <span class="cours-search-text">Over 5 million student</span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-sm-6">
                                    <div class="cours-search-bx m-b30">
                                        <div class="icon-box">
                                            <h3><i class="ti-book"></i><span class="counter">30</span>K</h3>
                                        </div>
                                        <span class="cours-search-text">30,000 Courses.</span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-sm-12">
                                    <div class="cours-search-bx m-b30">
                                        <div class="icon-box">
                                            <h3><i class="ti-layout-list-post"></i><span
                                                    class="counter">20</span>K</h3>
                                        </div>
                                        <span class="cours-search-text">Learn Anythink Online.</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Main Slider -->
            </div>


            <div class="row">
                <div class="col-lg-8 col-xl-8 col-md-7">
                    <div class="content-block">

                        <!-- Popular Courses -->
                        <div class="section-area section-sp2 popular-courses-bx">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-12 heading-bx left">
                                        <h2 class="title-head">Popular <span>Courses</span></h2>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="courses-carousel owl-carousel owl-btn-1 col-12 p-lr0">
                                        <c:forEach items="${requestScope.mapRatingCourse}" var="cou">
                                            <div class="item">
                                                <div class="cours-bx">
                                                    <div class="action-box">
                                                        <img src="${cou.key.thumbnail}" alt="">
                                                        <a href="#" class="btn">Read More</a>
                                                    </div>
                                                    <div class="info-bx text-center">
                                                        <h5><a href="#">${cou.key.courseName}</a></h5>
                                                    </div>
                                                    <div class="cours-more-info">
                                                        <div class="review">
                                                            <span>3 Review</span>
                                                            <ul class="cours-star">
                                                                <li class="active"><i class="fa fa-star"></i></li>
                                                                <li class="active"><i class="fa fa-star"></i></li>
                                                                <li class="active"><i class="fa fa-star"></i></li>
                                                                <li><i class="fa fa-star"></i></li>
                                                                <li><i class="fa fa-star"></i></li>
                                                            </ul>
                                                            <span> ${cou.value}</span>
                                                        </div>
                                                        <div class="price">
                                                            <del>$${cou.key.price}</del>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Popular Courses END -->

                        <div class="section-area section-sp2">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-12 heading-bx left text-center">
                                        <h2 class="title-head text-uppercase">Hot <span>Blogs</span></h2>
                                    </div>
                                </div>
                                <div class="row">
                                    <c:forEach items="${requestScope.mapRatingPost}" var="post">
                                        <div class="col-lg-4 col-md-6 col-sm-6 mb-3">
                                            <div class="recent-news d-flex flex-column shadow rounded overflow-hidden"
                                                 style="height: 220px; font-size: 14px; padding: 8px;">

                                                <!-- Ảnh bài viết -->
                                                <div class="action-box" style="height: 140px; overflow: hidden; border-radius: 8px;">
                                                    <img src="assets/images/blog/latest-blog/pic1.jpg" class="img-fluid w-100"
                                                         style="height: 100%; object-fit: cover;" alt="Blog Image">
                                                </div>

                                                <!-- Thông tin bài viết -->
                                                <div class="info-bx flex-grow-1 d-flex flex-column px-2 py-1">
                                                    <h6 class="post-title mb-1 text-truncate" style="max-height: 40px; font-size: 14px;">
                                                        <a href="blog-details.html" class="text-dark">${post.key.title}</a>
                                                    </h6>
                                                    <div class="post-extra mt-auto d-flex justify-content-between align-items-center">
                                                        <a href="#" class="text-muted"><i class="fa fa-calendar"></i> ${post.key.updateDate}</a>
                                                        <span class="comments-bx text-primary font-weight-bold">${post.value}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                            </div>
                            <div class="text-center mt-4">
                                <a href="listPost" class="btn btn-primary px-4 py-2"
                                   style="border-radius: 8px; font-size: 16px; font-weight: 600; transition: 0.3s;">
                                    View More Blogs
                                </a>
                            </div>

                        </div>

                        <!-- Testimonials END ==== -->
                    </div>
                    <!-- contact area END -->
                    <!-- Content END-->
                </div>

                <!-- Side bar-->
                <div class="col-lg-3 col-xl-3 col-md-4 sticky-top">
                    <aside class="side-bar sticky-top">

                        <!-- Recent Posts Widget -->
                        <div class="widget recent-posts-entry">
                            <h6 class="widget-title">Recent Posts</h6>
                            <div class="widget-post-bx">
                                <c:forEach var="recentPost" items="${requestScope.recentPost}">
                                    <div class="widget-post clearfix">
                                        <div class="ttr-post-media">
                                            <img src="assets/images/blog/recent-blog/${recentPost.thumbnail}" width="200" height="143" alt="">
                                        </div>
                                        <div class="ttr-post-info">
                                            <div class="ttr-post-header">
                                                <h6 class="post-title">
                                                    <a href="blog-details.html">${recentPost.title}</a>
                                                </h6>
                                            </div>
                                            <ul class="media-post">
                                                <li><a href="#"><i class="fa fa-calendar"></i> ${recentPost.updateDate}</a></li>
                                                <li><a href="#"><i class="fa fa-comments-o"></i> Comments</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </aside>
                </div>
            </div>

            <!-- Footer ==== -->
            <%@include file="Footer.jsp" %>
            <!-- Footer END ==== -->
            <button class="back-to-top fa fa-chevron-up"></button>
            </div>
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
        <script src='assets/vendors/switcher/switcher.js'></script>
    </body>
</html>

