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

    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <!-- Header Top ==== -->
            <%@include file="header.jsp" %>
            <!-- header END -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner1.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Blog Classic Sidebar</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="#">Home</a></li>
                            <li>Blog Classic Sidebar</li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->

                <form class="col-2" action="listPost" id="statusForm">
                    <select class="form-select form-select-sm" aria-label="Small select example" name="arrange" onchange="document.getElementById('statusForm').submit();">
                        <option selected>Arrange</option>
                        <option value="rating">Highest Rating</option>
                        <option value="date-soon">Earliest Date</option>
                        <option value="date-late">Latest Date</option>
                    </select>
                </form>

                <div class="content-block">
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row">
                                <!-- Left part start -->
                                <div class="col-lg-8 col-xl-8 col-md-7">
                                    <!-- Blog Grid -->
                                    <div id="masonry" class="ttr-blog-grid-3 row">
                                        <c:forEach items="${requestScope.mapRating}" var="post">
                                            <div class="col-md-6 col-lg-6 mb-4">
                                                <div class="recent-news d-flex flex-column h-100">
                                                    <div class="action-box">
                                                        <img src="assets/images/blog/latest-blog/pic1.jpg" alt="Blog Image">
                                                    </div>
                                                    <div class="info-bx flex-grow-1 d-flex flex-column">
                                                        <ul class="media-post">
                                                            <li><a href="#"><i class="fa fa-calendar"></i> ${post.key.updateDate}</a></li>
                                                            <li><a href="#"><i class="fa fa-user"></i> ${post.key.marketing.user.userName}</a></li>
                                                        </ul>
                                                        <h5 class="post-title">
                                                            <a href="blog-details.html">${post.key.title}</a>
                                                        </h5>
                                                        <p>Knowing that, you’ve optimised your pages countless amount of times, written tons.</p>
                                                        <div class="post-extra mt-auto d-flex justify-content-between">
                                                            <a href="#" class="btn-link">READ MORE</a>
                                                            <a href="#" class="comments-bx">
                                                                 ${post.value}
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <!-- Blog Grid END -->

                                    <!-- Pagination -->
                                    <div class="pagination-bx rounded-sm gray clearfix">
                                        <ul class="pagination justify-content-center">
                                            <c:forEach begin="1" end="${requestScope.pageNum}" var="i">
                                                <li class="page-item ${i == requestScope.currentPage ? 'active' : ''}">
                                                    <a class="page-link m-lg-1" href="home?page=${i}">${i}</a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                    <!-- Pagination END -->
                                </div>
                                <!-- Left part END -->

                                <!-- Side bar start -->
                                <div class="col-lg-4 col-xl-4 col-md-5 sticky-top">
                                    <aside class="side-bar sticky-top">
                                        <!-- Search Widget -->
                                        <div class="widget">
                                            <h6 class="widget-title">Search</h6>
                                            <div class="search-bx style-1">
                                                <form action="listPost" method="get">
                                                    <div class="input-group">
                                                        <input class="form-control" placeholder="Enter your keywords..." type="text" name="search">
                                                        <button type="submit" class="btn btn-primary">
                                                            <i class="fa fa-search"></i>
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

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

                                        <!-- Category Widget -->
                                        <div class="widget widget_tag_cloud">
                                            <h6 class="widget-title">Category Blog</h6>
                                            <div class="tagcloud">
                                                <c:forEach items="${requestScope.listCategoryBlog}" var="cateBlog">
                                                    <a href="listPost?cate=${cateBlog.categoryBlogId}">${cateBlog.categoryBlogName}</a>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </aside>
                                </div>
                                <!-- Side bar END -->
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Left & right section END -->
            <!-- Content END-->
            <!-- Footer ==== -->
            <%@include file="Footer.jsp" %>
            <!-- Footer END ==== -->
            <!-- scroll top button -->
            <button class="back-to-top fa fa-chevron-up" ></button>
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