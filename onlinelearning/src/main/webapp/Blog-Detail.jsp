<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<head>
    <!-- META ============================================= -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="keywords" content="" />
    <meta name="author" content="" />
    <meta name="robots" content="" />

    <!-- DESCRIPTION -->
    <meta name="description" content="${requestScope.post.title}" />

    <!-- OG -->
    <meta property="og:title" content="${requestScope.post.title}" />
    <meta property="og:description" content="${requestScope.post.title}" />
    <meta property="og:image" content="" />
    <meta name="format-detection" content="telephone=no">

    <!-- FAVICONS ICON ============================================= -->
    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

    <!-- PAGE TITLE HERE ============================================= -->
    <title>${requestScope.post.title} - Blog Detail</title>

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
        .reply-box {
            border: 1px solid #ccc;
            padding: 10px;
            background: #f9f9f9;
            border-radius: 5px;
        }

        .reply-box textarea {
            width: 100%;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .reply-box .submit-reply {
            background: red;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        /* Thêm CSS mới cho trang blog chi tiết */
        .post-content {
            font-size: 16px;
            line-height: 1.8;
            color: #505050;
            margin-bottom: 30px;
        }
        
        .post-brief {
            font-size: 1.2rem;
            line-height: 1.8;
            font-weight: 500;
            color: #555;
            border-left: 4px solid #f7b205;
            padding-left: 15px;
            margin-bottom: 30px;
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
        }

        .post-title {
            font-size: 2.5rem;
            line-height: 1.3;
            color: #333;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .post-content img {
            max-width: 100%;
            height: auto;
            margin: 20px 0;
            border-radius: 5px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .post-meta {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .post-meta .author-img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 15px;
            object-fit: cover;
        }
        
        .post-meta .author-info {
            line-height: 1.2;
        }
        
        .post-meta .author-name {
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .social-share {
            margin: 20px 0;
        }
        
        .social-share a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #f0f0f0;
            color: #505050;
            margin-right: 10px;
            transition: all 0.3s ease;
        }
        
        .social-share a:hover {
            transform: translateY(-3px);
        }
        
        .social-share .facebook:hover {
            background: #3b5998;
            color: #fff;
        }
        
        .social-share .twitter:hover {
            background: #1da1f2;
            color: #fff;
        }
        
        .social-share .linkedin:hover {
            background: #0077b5;
            color: #fff;
        }

        .tag-cloud a {
            display: inline-block;
            padding: 5px 15px;
            background: #f0f0f0;
            color: #505050;
            border-radius: 20px;
            margin: 0 5px 10px 0;
            transition: all 0.3s ease;
        }
        
        .tag-cloud a:hover {
            background: #f7b205;
            color: #fff;
        }
        
        /* CSS cho các loại nội dung PostContent */
        .post-content-text {
            margin-bottom: 1.5rem;
            text-align: justify;
        }
        
        .post-content-image {
            margin: 2rem 0;
        }
        
        .post-content-image img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        
        .post-content-image img:hover {
            transform: scale(1.02);
        }
        
        .image-caption, .video-caption, .code-caption {
            font-size: 0.9rem;
            color: #6c757d;
            margin-top: 0.5rem;
        }
        
        .post-content-video {
            margin: 2rem 0;
        }
        
        .post-content-code {
            margin: 2rem 0;
        }
        
        .post-content-code pre {
            background-color: #f8f9fa;
            padding: 1.25rem;
            border-radius: 8px;
            border-left: 4px solid #f7b205;
            font-family: 'Courier New', Courier, monospace;
            overflow-x: auto;
            font-size: 0.9rem;
            line-height: 1.5;
        }
        
        .post-content-quote {
            margin: 2rem 0;
            padding: 1.5rem;
            background-color: #f8f9fa;
            border-left: 4px solid #f7b205;
            border-radius: 8px;
        }
        
        .post-content-quote .blockquote {
            margin-bottom: 0;
            font-size: 1.1rem;
            font-style: italic;
        }
        
        .post-content-quote .blockquote-footer {
            margin-top: 0.5rem;
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        /* Cải thiện trải nghiệm người dùng cho phần comment */
        .comment {
            transition: all 0.3s ease;
        }
        
        .comment:hover {
            background-color: #f9f9f9;
        }
        
        .comment-body {
            padding: 15px;
            border-radius: 8px;
        }
        
        .comment-author img {
            border-radius: 50%;
            margin-right: 10px;
        }
        
        .comment-meta {
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        .reply a {
            display: inline-block;
            padding: 5px 10px;
            background-color: #f0f0f0;
            border-radius: 20px;
            font-size: 0.9rem;
            color: #505050;
            transition: all 0.3s ease;
        }
        
        .reply a:hover {
            background-color: #f7b205;
            color: #fff;
            text-decoration: none;
        }
        
        /* Fix for smaller devices */
        @media (max-width: 767.98px) {
            .post-content-image img {
                max-width: 100%;
            }
            
            .post-content {
                font-size: 15px;
            }
            
            .post-title {
                font-size: 1.8rem;
            }
            
            .post-content-quote {
                padding: 1rem;
            }
            
            .post-content-code pre {
                padding: 1rem;
                font-size: 0.8rem;
            }
        }
    </style>
</head>
<body id="bg">
    <div class="page-wraper">
        <div id="loading-icon-bx"></div>

        <!-- Header Top ==== -->
        <%@include file="header.jsp" %>
        <!-- header END ==== -->

        <!-- Content -->
        <div class="page-content bg-white">
            <!-- inner page banner -->
            <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner2.jpg);">
                <div class="container">
                    <div class="page-banner-entry">
                        <h1 class="text-white">Blog Details</h1>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb row -->
            <div class="breadcrumb-row">
                <div class="container">
                    <ul class="list-inline">
                        <li><a href="home">Home</a></li>
                        <li><a href="listPost">Blog</a></li>
                        <li><a href="listPost?cate=${requestScope.post.categoryBlog.categoryBlogId}">${requestScope.post.categoryBlog.categoryBlogName}</a></li>
                        <li>${requestScope.post.title}</li>
                    </ul>
                </div>
            </div>
            <!-- Breadcrumb row END -->
            <div class="content-block">
                <div class="section-area section-sp1">
                    <div class="container">
                        <div class="row">
                            <!-- Left part start -->
                            <div class="col-lg-8 col-xl-8">
                                <!-- blog start -->
                                <div class="recent-news blog-lg">
                                    <div class="action-box blog-lg">
                                        <img src="${empty requestScope.post.thumbnail ? 'assets/images/blog/default/thum1.jpg' : requestScope.post.thumbnail}" alt="${requestScope.post.title}">
                                    </div>
                                    <div class="info-bx">
                                        <ul class="media-post">
                                            <li><a href="#"><i class="fa fa-calendar"></i>${requestScope.post.createDate}</a></li>
                                            <li><a href="#"><i class="fa fa-user"></i>${requestScope.post.marketing.user.firstName} {requestScope.post.marketing.user.lastName}</a></li>
                                            <li><a href="#"><i class="fa fa-comments-o"></i>${requestScope.cntAll} Comments</a></li>
                                            <li><a href="#"><i class="fa fa-tag"></i>${requestScope.post.categoryBlog.categoryBlogName}</a></li>
                                        </ul>
                                        <div class="post-meta">
                                            <img src="assets/images/testimonials/pic1.jpg" alt="Author" class="author-img">
                                            <div class="author-info">
                                                <div class="author-name">${requestScope.post.marketing.user.firstName} ${requestScope.post.marketing.user.lastName}</div>
                                                <div class="post-date">Published on ${requestScope.post.createDate}</div>
                                            </div>
                                        </div>
                                        <h2 class="post-title mb-4">${requestScope.post.title}</h2>
                                        
                                        <!-- Hiển thị nội dung bài viết từ các PostContent -->
                                        <div class="post-content">
                                            <!-- Hiển thị brief của bài viết nếu có -->

                                            <c:forEach items="${requestScope.listPostContent}" var="postContent" varStatus="loop">
                                                <c:choose>
                                                    <c:when test="${postContent.contentType eq 'TEXT'}">
                                                        <div class="post-content-text">
                                                            ${postContent.content}
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${postContent.contentType eq 'IMAGE'}">
                                                        <div class="post-content-image text-center my-4">
                                                            <img src="${postContent.content}" alt="Post image" class="img-fluid rounded">
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${postContent.contentType eq 'VIDEO'}">
                                                        <div class="post-content-video text-center my-4">
                                                            <div class="embed-responsive embed-responsive-16by9">
                                                                <iframe class="embed-responsive-item" src="${postContent.content}" allowfullscreen></iframe>
                                                            </div>
                                                        </div>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <div class="post-content-text">
                                                            ${postContent.content}
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                        
                                        <div class="ttr-divider bg-gray"><i class="icon-dot c-square"></i></div>
                                        <div class="widget_tag_cloud">
                                            <h6>TAGS</h6>
                                            <div class="tagcloud tag-cloud">
                                                <c:if test="${not empty requestScope.post.categoryBlog}">
                                                    <a href="listPost?cate=${requestScope.post.categoryBlog.categoryBlogId}">${requestScope.post.categoryBlog.categoryBlogName}</a>
                                                </c:if>
                                                <a href="#">Web Design</a>
                                                <a href="#">Development</a>
                                                <a href="#">Learning</a>
                                                <a href="#">Education</a>
                                            </div>
                                        </div>
                                        <div class="ttr-divider bg-gray"><i class="icon-dot c-square"></i></div>
                                        <h6>SHARE </h6>
                                        <div class="social-share">
                                            <a href="javascript:void(0)" onclick="window.open('https://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(location.href), 'facebook-share-dialog', 'width=626,height=436'); return false;" class="facebook"><i class="fa fa-facebook"></i></a>
                                            <a href="javascript:void(0)" onclick="window.open('https://twitter.com/intent/tweet?text=${requestScope.post.title}&url='+encodeURIComponent(location.href), 'twitter-share-dialog', 'width=626,height=436'); return false;" class="twitter"><i class="fa fa-twitter"></i></a>
                                            <a href="javascript:void(0)" onclick="window.open('https://www.linkedin.com/sharing/share-offsite/?url='+encodeURIComponent(location.href), 'linkedin-share-dialog', 'width=626,height=436'); return false;" class="linkedin"><i class="fa fa-linkedin"></i></a>
                                            <a href="javascript:void(0)" onclick="window.open('https://pinterest.com/pin/create/button/?url='+encodeURIComponent(location.href)+'&media=&description=${requestScope.post.title}', 'pinterest-share-dialog', 'width=626,height=436'); return false;"><i class="fa fa-pinterest"></i></a>
                                        </div>
                                        <div class="ttr-divider bg-gray"><i class="icon-dot c-square"></i></div>
                                    </div>
                                </div>
                                <div class="clear" id="comment-list">
                                    <div class="comments-area" id="comments">
                                        <h2 class="comments-title">${requestScope.cntAll} Comments</h2>
                                        <div class="clearfix m-b20">
                                            <!-- comment list END -->
                                            <ol class="comment-list">
                                                <c:forEach items= "${requestScope.listComment}"  var ="parent">
                                                    <li class="comment">
                                                        <div class="comment-body">
                                                            <div class="comment-author vcard"> <img  class="avatar photo" src="assets/images/testimonials/pic1.jpg" alt=""> <cite class="fn">${parent.user.firstName}</cite> <span class="says">says:</span> </div>
                                                            <div class="comment-meta"> <a href="#">${parent.createDate}</a> </div>
                                                            <p>${parent.content} </p>
                                                            <div class="reply">
                                                                <a href="#" class="comment-reply-link" onclick="toggleReplyBox(event, this)">Reply</a>
                                                            </div>
                                                            <form action="addCommentPost" method="post">
                                                                <div class="reply-box" style="display: none; margin-top: 10px; margin-bottom : 10px">
                                                                    <input type="hidden" name="parentId" value="${parent.commentPostId}">
                                                                    <input type="hidden" name="postId" value="${parent.post.postId}">
                                                                    <textarea placeholder="Nhập nội dung bình luận" rows="3" name="content" required></textarea>
                                                                    <button type="submit" class="submit-reply">Gửi</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                        <ol class="children">
                                                            <c:if test="${not empty parent.children}">
                                                                <c:set var="childComments" value="${parent.children}" scope="request"/>
                                                                <jsp:include page="comment-recursive-post.jsp"/>
                                                            </c:if>
                                                            <!-- list END -->
                                                        </ol>
                                                    </li>
                                                </c:forEach>
                                            </ol>
                                            <script>
                                                function toggleReplyBox(event, element) {
                                                    event.preventDefault(); // Chặn hành vi mặc định của thẻ <a>

                                                    // Tìm phần tử cha gần nhất có class .comment
                                                    let commentContainer = element.closest('.comment');

                                                    // Tìm phần tử .reply-box bên trong comment đó
                                                    let replyBox = commentContainer.querySelector('.reply-box');

                                                    // Hiển thị hoặc ẩn phần nhập comment
                                                    if (replyBox.style.display === "none") {
                                                        replyBox.style.display = "block";
                                                    } else {
                                                        replyBox.style.display = "none";
                                                    }
                                                }
                                            </script>
                                            <!-- comment list END -->
                                            <!-- Form -->
                                            <div class="comment-respond" id="respond">
                                                <h4 class="comment-reply-title" id="reply-title">Để lại bình luận <small> <a style="display:none;" href="#" id="cancel-comment-reply-link" rel="nofollow">Hủy phản hồi</a> </small> </h4>
                                                <form class="comment-form" id="commentform" action="addCommentPost" method="post">
                                                    <input type="hidden" name="parentId" value="0">
                                                    <input type="hidden" name="postId" value="${requestScope.post.postId}">
                                                    <c:choose>
                                                        <c:when test="${empty sessionScope.account}">
                                                            <div class="alert alert-warning">
                                                                Bạn cần <a href="login">đăng nhập</a> để bình luận.
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="comment-user-info mb-3">
                                                                <span>Bình luận với tên: <strong>${sessionScope.account.firstName}</strong></span>
                                                            </div>
                                                            <p class="comment-form-comment">
                                                                <label for="comment">Nội dung bình luận</label>
                                                                <textarea rows="8" name="content" placeholder="Nhập nội dung bình luận của bạn" id="comment" required></textarea>
                                                            </p>
                                                            <p class="form-submit">
                                                                <input type="submit" value="Gửi bình luận" class="submit" id="submit" name="submit">
                                                            </p>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </form>
                                            </div>
                                            <!-- Form -->
                                        </div>
                                    </div>
                                </div>
                                <!-- blog END -->
                            </div>
                            <!-- Left part END -->

                            <!-- Side bar start -->
                            <div class="col-lg-4 col-xl-4">
                                <aside  class="side-bar sticky-top">
                                    <div class="widget">
                                        <h6 class="widget-title">Search</h6>
                                        <div class="search-bx style-1">
                                            <form action="listPost">
                                                <div class="input-group">
                                                    <input name="search" class="form-control" placeholder="Enter your keywords..." type="text">
                                                    <span class="input-group-btn">
                                                        <button type="submit" class="fa fa-search text-primary"></button>
                                                    </span>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <div class="widget recent-posts-entry">
                                        <h6 class="widget-title">Recent Posts</h6>
                                        <div class="widget-post-bx">
                                            <c:forEach items ="${requestScope.listRecentPost}" var="post">
                                                <div class="widget-post clearfix">
                                                    <div class="ttr-post-media"> <img src="assets/images/blog/recent-blog/pic1.jpg" width="200" height="143" alt=""> </div>
                                                    <div class="ttr-post-info">
                                                        <div class="ttr-post-header">
                                                            <h6 class="post-title"><a href="blogDetail?postId=${post.key.postId}">${post.key.title}</a></h6>
                                                        </div>
                                                        <ul class="media-post">
                                                            <li><a href="#"><i class="fa fa-calendar"></i>${post.key.updateDate}</a></li>
                                                            <li><a href="#"><i class="fa fa-comments-o"></i>${post.value}</a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="widget widget_archive">
                                        <h5 class="widget-title style-1">Category Course</h5>
                                        <ul>
                                            <c:forEach items="${requestScope.listCategory}" var="cate">
                                                <li class="active">
                                                    <a
                                                        href="listPost?cate=${cate.categoryBlogId}">${cate.categoryBlogName}
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                    <div class="widget widget-newslatter">
                                        <h6 class="widget-title">Newsletter</h6>
                                        <div class="news-box">
                                            <p>Enter your e-mail and subscribe to our newsletter.</p>
                                            <form class="subscription-form" action="http://educhamp.themetrades.com/demo/assets/script/mailchamp.php" method="post">
                                                <div class="ajax-message"></div>
                                                <div class="input-group">
                                                    <input name="dzEmail" required="required" type="email" class="form-control" placeholder="Your Email Address"/>
                                                    <button name="submit" value="Submit" type="submit" class="btn black radius-no">
                                                        <i class="fa fa-paper-plane-o"></i>
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <div class="widget widget_gallery gallery-grid-4">
                                        <h6 class="widget-title">Our Gallery</h6>
                                        <ul>
                                            <li><div><a href="#"><img src="assets/images/gallery/pic2.jpg" alt=""></a></div></li>
                                            <li><div><a href="#"><img src="assets/images/gallery/pic1.jpg" alt=""></a></div></li>
                                            <li><div><a href="#"><img src="assets/images/gallery/pic5.jpg" alt=""></a></div></li>
                                            <li><div><a href="#"><img src="assets/images/gallery/pic7.jpg" alt=""></a></div></li>
                                            <li><div><a href="#"><img src="assets/images/gallery/pic8.jpg" alt=""></a></div></li>
                                            <li><div><a href="#"><img src="assets/images/gallery/pic9.jpg" alt=""></a></div></li>
                                            <li><div><a href="#"><img src="assets/images/gallery/pic3.jpg" alt=""></a></div></li>
                                            <li><div><a href="#"><img src="assets/images/gallery/pic4.jpg" alt=""></a></div></li>
                                        </ul>
                                    </div>
                                    <div class="widget widget_tag_cloud">
                                        <h6 class="widget-title">Tags</h6>
                                        <div class="tagcloud">
                                            <a href="#">Design</a>
                                            <a href="#">User interface</a>
                                            <a href="#">SEO</a>
                                            <a href="#">WordPress</a>
                                            <a href="#">Development</a>
                                            <a href="#">Joomla</a>
                                            <a href="#">Design</a>
                                            <a href="#">User interface</a>
                                            <a href="#">SEO</a>
                                            <a href="#">WordPress</a>
                                            <a href="#">Development</a>
                                            <a href="#">Joomla</a>
                                            <a href="#">Design</a>
                                            <a href="#">User interface</a>
                                            <a href="#">SEO</a>
                                            <a href="#">WordPress</a>
                                            <a href="#">Development</a>
                                            <a href="#">Joomla</a>
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
        <!-- Content END-->
        <!-- Footer ==== -->
        <footer>
            <div class="footer-top">
                <div class="pt-exebar">
                    <div class="container">
                        <div class="d-flex align-items-stretch">
                            <div class="pt-logo mr-auto">
                                <a href="index.html"><img src="assets/images/logo-white.png" alt=""/></a>
                            </div>
                            <div class="pt-social-link">
                                <ul class="list-inline m-a0">
                                    <li><a href="#" class="btn-link"><i class="fa fa-facebook"></i></a></li>
                                    <li><a href="#" class="btn-link"><i class="fa fa-twitter"></i></a></li>
                                    <li><a href="#" class="btn-link"><i class="fa fa-linkedin"></i></a></li>
                                    <li><a href="#" class="btn-link"><i class="fa fa-google-plus"></i></a></li>
                                </ul>
                            </div>
                            <div class="pt-btn-join">
                                <a href="#" class="btn ">Join Now</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-lg-4 col-md-12 col-sm-12 footer-col-4">
                            <div class="widget">
                                <h5 class="footer-title">Sign Up For A Newsletter</h5>
                                <p class="text-capitalize m-b20">Weekly Breaking news analysis and cutting edge advices on job searching.</p>
                                <div class="subscribe-form m-b20">
                                    <form class="subscription-form" action="http://educhamp.themetrades.com/demo/assets/script/mailchamp.php" method="post">
                                        <div class="ajax-message"></div>
                                        <div class="input-group">
                                            <input name="email" required="required"  class="form-control" placeholder="Your Email Address" type="email">
                                            <span class="input-group-btn">
                                                <button name="submit" value="Submit" type="submit" class="btn"><i class="fa fa-arrow-right"></i></button>
                                            </span>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-lg-5 col-md-7 col-sm-12">
                            <div class="row">
                                <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                    <div class="widget footer_widget">
                                        <h5 class="footer-title">Company</h5>
                                        <ul>
                                            <li><a href="index.html">Home</a></li>
                                            <li><a href="about-1.jsp">About</a></li>
                                            <li><a href="faq-1.html">FAQs</a></li>
                                            <li><a href="contact-1.html">Contact</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                    <div class="widget footer_widget">
                                        <h5 class="footer-title">Get In Touch</h5>
                                        <ul>
                                            <li><a href="http://educhamp.themetrades.com/admin/index.html">Dashboard</a></li>
                                            <li><a href="blog-classic-grid.jsp">Blog</a></li>
                                            <li><a href="portfolio.html">Portfolio</a></li>
                                            <li><a href="event.html">Event</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                    <div class="widget footer_widget">
                                        <h5 class="footer-title">Courses</h5>
                                        <ul>
                                            <li><a href="courses.html">Courses</a></li>
                                            <li><a href="courses-details.html">Details</a></li>
                                            <li><a href="membership.html">Membership</a></li>
                                            <li><a href="profile.html">Profile</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-lg-3 col-md-5 col-sm-12 footer-col-4">
                            <div class="widget widget_gallery gallery-grid-4">
                                <h5 class="footer-title">Our Gallery</h5>
                                <ul class="magnific-image">
                                    <li><a href="assets/images/gallery/pic1.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic1.jpg" alt=""></a></li>
                                    <li><a href="assets/images/gallery/pic2.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic2.jpg" alt=""></a></li>
                                    <li><a href="assets/images/gallery/pic3.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic3.jpg" alt=""></a></li>
                                    <li><a href="assets/images/gallery/pic4.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic4.jpg" alt=""></a></li>
                                    <li><a href="assets/images/gallery/pic5.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic5.jpg" alt=""></a></li>
                                    <li><a href="assets/images/gallery/pic6.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic6.jpg" alt=""></a></li>
                                    <li><a href="assets/images/gallery/pic7.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic7.jpg" alt=""></a></li>
                                    <li><a href="assets/images/gallery/pic8.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic8.jpg" alt=""></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 text-center"> <a target="_blank" href="https://www.templateshub.net">Templates Hub</a></div>
                    </div>
                </div>
            </div>
        </footer>
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