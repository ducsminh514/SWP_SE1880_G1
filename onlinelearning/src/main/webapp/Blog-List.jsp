<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="Blog, Online Learning, Education Articles, Learning Resources" />
        <meta name="author" content="EduChamp" />
        <meta name="robots" content="index, follow" />

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp - Blog Articles and Learning Resources" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp - Blog Articles and Learning Resources" />
        <meta property="og:description" content="Discover top-quality educational articles and learning resources" />
        <meta property="og:image" content="assets/images/blog/latest-blog/pic1.jpg" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp - Blog Articles </title>

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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            /* Custom Styles for Blog List */
            body {
                font-family: 'Roboto', sans-serif;
            }

            /* Blog Card Styles */
            .blog-card {
                transition: all 0.3s ease;
                border-radius: 8px;
                overflow: hidden;
                margin-bottom: 30px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                background: #fff;
                border: none;
                height: 100%;
            }

            .blog-card:hover {
                transform: translateY(-7px);
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            }

            .blog-card .action-box {
                position: relative;
                overflow: hidden;
                height: 220px;
            }

            .blog-card .action-box img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: all 0.5s ease;
            }

            .blog-card:hover .action-box img {
                transform: scale(1.1);
            }

            .blog-card .action-box .post-date {
                position: absolute;
                top: 15px;
                right: 15px;
                background-color: rgba(247, 178, 5, 0.9);
                color: #fff;
                padding: 6px 12px;
                border-radius: 30px;
                font-size: 12px;
                font-weight: 600;
                z-index: 1;
            }

            .blog-card .action-box .category-badge {
                position: absolute;
                bottom: 15px;
                left: 15px;
                background: rgba(0, 0, 0, 0.7);
                color: #fff;
                padding: 6px 12px;
                border-radius: 4px;
                font-size: 12px;
                font-weight: 500;
                z-index: 1;
            }

            .blog-card .info-bx {
                padding: 20px;
            }

            .blog-card .post-title {
                font-size: 18px;
                line-height: 1.4;
                margin-bottom: 15px;
                font-weight: 600;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                height: 50px;
            }

            .blog-card .post-title a {
                color: #333;
                transition: all 0.3s ease;
            }

            .blog-card .post-title a:hover {
                color: #f7b205;
                text-decoration: none;
            }

            .blog-meta {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
                font-size: 13px;
                color: #777;
            }

            .blog-meta .meta-item {
                margin-right: 15px;
                display: flex;
                align-items: center;
            }

            .blog-meta i {
                margin-right: 5px;
                color: #f7b205;
            }

            .blog-excerpt {
                color: #666;
                font-size: 14px;
                line-height: 1.6;
                margin-bottom: 15px;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
                height: 65px;
            }

            .blog-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-top: 1px solid #eee;
                padding-top: 15px;
            }

            .read-more {
                font-size: 14px;
                font-weight: 600;
                color: #f7b205;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
            }

            .read-more i {
                margin-left: 5px;
                transition: all 0.3s ease;
            }

            .read-more:hover {
                color: #333;
                text-decoration: none;
            }

            .read-more:hover i {
                transform: translateX(3px);
            }

            .rating-box {
                display: flex;
                align-items: center;
            }

            .rating-stars {
                color: #f7b205;
                margin-right: 5px;
            }

            .rating-value {
                font-weight: 600;
                color: #555;
            }

            /* Sidebar Styles */
            .side-bar {
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                padding: 30px;
                margin-bottom: 30px;
            }




            .search-bx .form-control {
                height: 50px;
                border-radius: 30px;
                padding-left: 20px;
                font-size: 14px;
                border: 1px solid #eee;
                box-shadow: none;
            }

            .search-bx button {
                width: 50px;
                height: 50px;
                border-radius: 30px;
                background: #f7b205;
                color: #fff;
                border: none;
            }


            .widget-post:hover {
                box-shadow: none;
                transform: none;
                background: transparent;
            }


            .tagcloud {
                display: flex;
                flex-wrap: wrap;
            }

            .tagcloud a {
                display: inline-block;
                padding: 6px 15px;
                background: #f5f5f5;
                color: #555;
                border-radius: 30px;
                margin: 0 8px 10px 0;
                font-size: 13px;
                transition: all 0.3s ease;
            }

            .tagcloud a:hover {
                background: #f7b205;
                color: #fff;
                text-decoration: none;
            }

            /* Pagination Styles */
            .pagination-bx {
                margin-top: 30px;
            }

            .pagination {
                box-shadow: 0 0 30px rgba(0, 0, 0, 0.05);
                border-radius: 30px;
                overflow: hidden;
            }

            .pagination .page-item .page-link {
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #555;
                font-weight: 600;
                border: none;
                background: #fff;
                transition: all 0.3s ease;
            }

            .pagination .page-item.active .page-link,
            .pagination .page-item .page-link:hover {
                background: #f7b205;
                color: #fff;
            }

            /* Arrange Dropdown */
            .arrange-form {
                margin-bottom: 30px;
                position: relative;
                z-index: 5;
            }

            .arrange-form select {
                height: 45px;
                border-radius: 30px;
                padding: 0 20px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                border: 1px solid #eee;
                font-size: 14px;
                color: #555;
                font-weight: 500;
                width: 100%;
                background-color: #fff;
            }

            /* Banner section */
            .page-banner {
                position: relative;
                text-align: center;
                height: 300px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .page-banner-entry h1 {
                font-size: 40px;
                font-weight: 700;
                margin-bottom: 10px;
                text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
            }

            .breadcrumb-row {
                background: #f7f7f7;
                padding: 15px 0;
            }

            .breadcrumb-row ul {
                margin: 0;
            }

            .breadcrumb-row ul li {
                padding: 0;
                margin-right: 5px;
                font-size: 14px;
                position: relative;
            }

            .breadcrumb-row ul li:after {
                content: "/";
                margin-left: 7px;
                color: #ccc;
            }

            .breadcrumb-row ul li:last-child:after {
                display: none;
            }

            .breadcrumb-row ul li a {
                color: #555;
                transition: all 0.3s ease;
            }

            .breadcrumb-row ul li a:hover {
                color: #f7b205;
                text-decoration: none;
            }

            /* Category Badge */
            .category-badge {
                background: #f7b205;
                color: #fff;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 500;
                display: inline-block;
                margin-bottom: 10px;
                transition: all 0.3s ease;
            }

            .category-badge:hover {
                background: #e0a200;
                color: #fff;
                text-decoration: none;
            }

            /* Responsive Adjustments */
            @media (max-width: 991px) {
                .blog-card .action-box {
                    height: 200px;
                }

                .side-bar {
                    margin-top: 30px;
                }

                .page-banner {
                    height: 250px;
                }

                .page-banner-entry h1 {
                    font-size: 32px;
                }
            }

            @media (max-width: 767px) {
                .blog-card .action-box {
                    height: 180px;
                }

                .page-banner {
                    height: 200px;
                }

                .page-banner-entry h1 {
                    font-size: 24px;
                }
            }

            .ttr-post-info .post-title {
                font-size: 16px;
                font-weight: 500;
                line-height: 1.4;
                margin-top: 0;
                margin-bottom: 8px;
                overflow: visible;
                display: block;
                -webkit-line-clamp: initial;
                -webkit-box-orient: initial;
                color: #333;
                font-family: 'Roboto', sans-serif;
            }

            .ttr-post-info .post-title a {
                color: #333;
                transition: all 0.3s ease;
            }

            .media-post {
                font-size: 13px;
                color: #777;
                margin: 0;
                padding: 0;
                list-style: none;
                display: flex;
                align-items: center;
            }

            .media-post li {
                display: inline-flex;
                align-items: center;
                margin-right: 15px;
                background: transparent;
                padding: 0;
                border-radius: 0;
                color: #777;
                font-family: 'Roboto', sans-serif;
                font-weight: 400;
            }

            .media-post i {
                font-size: 14px;
                margin-right: 5px;
                color: #f7b205;
            }

            .widget-title {
                position: relative;
                font-size: 20px;
                font-weight: 600;
                padding-bottom: 15px;
                margin-bottom: 25px;
                color: #333;
                border-bottom: 2px solid #f0f0f0;
                text-transform: capitalize;
                font-family: 'Roboto', sans-serif;
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
                            <h1 class="text-white">Our Blog Articles</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="home">Home</a></li>
                            <li><a href="listPost">Blog Articles</a></li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->

                <div class="content-block">
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row">
                                <!-- Left part start -->
                                <div class="col-lg-8 col-xl-8 col-md-7">
                                    <!-- Arrange Dropdown -->
                                    <div class="arrange-form mb-4">
                                        <form action="listPost" id="statusForm" class="mb-4">
                                            <!-- Truyền giá trị cate và search -->
                                            <input type="hidden" name="cate" value="${requestScope.cate}">
                                            <input type="hidden" name="search" value="${requestScope.search}">
                                            
                                            <div class="form-group">
                                                <select class="form-control" name="arrange" onchange="document.getElementById('statusForm').submit();">
                                                    <option value="" selected>Arrange Posts</option>
                                                    <option value="rating" ${requestScope.arrange == 'rating' ? 'selected' : ''}>Highest Rating</option>
                                                    <option value="date-soon" ${requestScope.arrange == 'date-soon' ? 'selected' : ''}>Earliest Date</option>
                                                    <option value="date-late" ${requestScope.arrange == 'date-late' ? 'selected' : ''}>Latest Date</option>
                                                </select>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    <!-- Blog Grid -->
                                    <div class="row">
                                        <c:forEach items="${requestScope.mapRating}" var="post">
                                            <div class="col-md-6">
                                                <div class="blog-card">
                                                    <!-- Ảnh bài viết -->
                                                    <div class="action-box">
                                                        <img src="${empty post.key.thumbnail ? 'assets/images/blog/default/thum1.jpg' : post.key.thumbnail}" alt="${post.key.title}">
                                                        <span class="post-date"><i class="fa fa-calendar"></i> ${post.key.updateDate}</span>
                                                        <c:if test="${not empty post.key.categoryBlog}">
                                                            <a href="listPost?cate=${post.key.categoryBlog.categoryBlogId}" class="category-badge">${post.key.categoryBlog.categoryBlogName}</a>
                                                        </c:if>
                                                    </div>

                                                    <!-- Nội dung bài viết -->
                                                    <div class="info-bx">
                                                        <div class="blog-meta">
                                                            <div class="meta-item">
                                                                <i class="fa fa-user"></i> ${post.key.marketing.user.firstName}
                                                            </div>
                                                            <div class="meta-item">
                                                                <i class="fa fa-comments"></i> Comments
                                                            </div>
                                                        </div>
                                                        
                                                        <h5 class="post-title">
                                                            <a href="blogDetail?postId=${post.key.postId}">${post.key.title}</a>
                                                        </h5>
                                                        
                                                        <div class="blog-footer">
                                                            <a href="blogDetail?postId=${post.key.postId}" class="read-more">Read More <i class="fa fa-arrow-right"></i></a>
                                                            <div class="rating-box">
                                                                <div class="rating-stars">
                                                                    <c:forEach begin="1" end="5" var="i">
                                                                        <c:choose>
                                                                            <c:when test="${i <= post.value}">
                                                                                <i class="fa fa-star"></i>
                                                                            </c:when>
                                                                            <c:when test="${i - 0.5 <= post.value}">
                                                                                <i class="fa fa-star-half-alt"></i>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <i class="far fa-star"></i>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </c:forEach>
                                                                </div>
                                                                <span class="rating-value">${post.value}</span>
                                                            </div>
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
                                                    <a class="page-link" href="listPost?page=${i}&arrange=${requestScope.arrange}&cate=${requestScope.cate}&search=${requestScope.search}">${i}</a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                    <!-- Pagination END -->
                                </div>
                                <!-- Left part END -->

                                <!-- Side bar start -->
                                <div class="col-lg-4 col-xl-4 col-md-5">
                                    <aside class="side-bar sticky-top">
                                        <!-- Search Widget -->
                                        <div class="widget">
                                            <h6 class="widget-title">Search</h6>
                                            <div class="search-bx style-1">
                                                <form action="listPost" method="get">
                                                    <div class="input-group">
                                                        <input class="form-control" placeholder="Enter your keywords..." type="text" name="search" value="${requestScope.search}">
                                                        <div class="input-group-append">
                                                            <button type="submit" class="fa fa-search"></button>
                                                        </div>
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
                                                            <a href="blogDetail?postId=${recentPost.postId}">
                                                                <img src="${empty recentPost.thumbnail ? 'assets/images/blog/default/thum1.jpg' : recentPost.thumbnail}" alt="${recentPost.title}">
                                                            </a>
                                                        </div>
                                                        <div class="ttr-post-info">
                                                            <h6 class="post-title">
                                                                <a href="blogDetail?postId=${recentPost.postId}">${recentPost.title}</a>
                                                            </h6>
                                                            <ul class="media-post">
                                                                <li><i class="fa fa-calendar"></i> ${recentPost.updateDate}</li>
                                                                <li><i class="fa fa-comments"></i> 15 Comment</li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <!-- Category Widget -->
                                        <div class="widget widget_tag_cloud">
                                            <h6 class="widget-title">Categories</h6>
                                            <div class="tagcloud">
                                                <c:forEach items="${requestScope.listCategoryBlog}" var="cateBlog">
                                                    <a href="listPost?cate=${cateBlog.categoryBlogId}" class="${requestScope.cate eq cateBlog.categoryBlogId ? 'active' : ''}">${cateBlog.categoryBlogName}</a>
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