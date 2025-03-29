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
        <style>
        /* Tăng độ mượt cho card */
        .card {
            transition: all 0.3s ease-in-out;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        /* Hiệu ứng overlay cho ảnh */
        .action-box {
            overflow: hidden;
        }
        .action-box img {
            transition: transform 0.3s ease-in-out;
        }
        .action-box:hover img {
            transform: scale(1.1);
        }
        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.2);
            opacity: 0;
            transition: opacity 0.3s ease-in-out;
        }
        .action-box:hover .overlay {
            opacity: 1;
        }

        </style>
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
                            <h1 class="text-white">Blog </h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="home">Home</a></li>
                            <li>Blog </li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->

                <form class="col-2" action="listPost" id="statusForm">
                    <!-- Truyền giá trị cate và search -->
                    <input type="hidden" name="cate" value="${requestScope.cate}">
                    <input type="hidden" name="search" value="${requestScope.search}">

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
                                    <div id="masonry" class="row row-cols-1 row-cols-md-2 g-4">
                                        <c:forEach items="${requestScope.mapRating}" var="post">
                                            <div class="col">
                                                <div class="card h-100 shadow-sm border-0">
                                                    <!-- Ảnh bài viết -->
                                                    <div class="action-box position-relative">
                                                        <img src="assets/images/blog/latest-blog/pic1.jpg" class="card-img-top img-fluid rounded-top" alt="Blog Image">
                                                        <div class="overlay"></div>
                                                    </div>

                                                    <!-- Nội dung bài viết -->
                                                    <div class="card-body d-flex flex-column">
                                                        <!-- Thông tin bài viết -->
                                                        <ul class="list-inline text-muted small mb-2">
                                                            <li class="list-inline-item">
                                                                <i class="fa fa-calendar"></i> ${post.key.updateDate}
                                                            </li>
                                                            <li class="list-inline-item">
                                                                <i class="fa fa-user"></i> ${post.key.marketing.user.userName}
                                                            </li>
                                                        </ul>

                                                        <!-- Tiêu đề bài viết -->
                                                        <h5 class="card-title">
                                                            <a href="blogDetail?postId=${post.key.postId}" class="text-dark text-decoration-none">${post.key.title}</a>
                                                        </h5>

                                                        <!-- Rating -->
                                                        <div class="d-flex align-items-center">
                                                            <span class="text-warning me-2">
                                                                <i class="fa fa-star"></i> ${post.value}
                                                            </span>
                                                        </div>

                                                        <!-- Nút điều hướng -->
                                                        <div class="mt-auto d-flex justify-content-between">
                                                            <a href="#" class="btn btn-outline-primary btn-sm">READ MORE</a>
                                                            <a href="#" class="comments-bx text-muted">
                                                                <i class="fa fa-comments"></i> ${post.value}
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
                                                    <a class="page-link m-lg-1" href="listPost?page=${i}&arrange=${requestScope.arrange}&cate=${requestScope.cate}&search=${requestScope.search}">${i}</a>
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
            <%@include file="footer.jsp" %>
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