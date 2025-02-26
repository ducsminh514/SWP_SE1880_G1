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
            body {
                font-family: Arial, sans-serif;
            }

            .open-popup-btn {
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
                background-color: #6c5ce7;
                color: white;
                border: none;
                border-radius: 5px;
                margin: 20px;
            }

            .popup {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }

            .popup-content {
                display: flex;
                background-color: #f9f4e7;
                padding: 20px;
                border-radius: 10px;
                width: 60%;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                position: relative;
                overflow: auto;
                flex-direction: row;
            }
            .popup form {
                display: flex;
                flex-direction: column;
                gap: 15px; /* Thêm khoảng cách giữa các phần tử */
            }
            .divider {
                width: 2px;
                background-color: #ddd;
                margin: 0 20px;
                height: auto;
                border-radius: 10px;
            }

            .popup h2 {
                margin-top: 0;
                font-size: 20px;
                color: #333;
            }

            label {
                display: block;
                margin: 10px 0 5px;
            }

            input[type="checkbox"] {
                margin-right: 10px;
            }

            input[type="number"] {
                padding: 8px;
                width: 100%;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            .left-side, .right-side {
                flex: 1; /* Đảm bảo các phần tử chiếm đều không gian */
            }

            .left-side {
                margin-right: 20px; /* Khoảng cách giữa hai phần */
            }

            .right-side {
                margin-left: 20px; /* Khoảng cách giữa hai phần */
            }

            .popup-buttons {
                display: flex;
                justify-content: flex-end;
                margin-top: 20px;
            }

            button {
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
                border: none;
                border-radius: 5px;
                margin-top: 10px;
            }

            .clear-btn {
                background-color: #ff6b6b;
                color: white;
                margin-right: 10px;
            }

            .apply-btn {
                background-color: #6c5ce7;
                color: white;
            }

            button:hover {
                opacity: 0.8;
            }

            .close-btn {
                position: absolute;
                top: 10px;
                right: 10px;
                font-size: 20px;
                background-color: transparent;
                border: none;
                color: #333;
                cursor: pointer;
            }

            .close-btn:hover {
                color: #ff6b6b;
            }

            .review[style*="display: none"],
            .course-author[style*="display: none"],
            .original-price[style*="display: none"],
            .lowest-price[style*="display: none"] {
                opacity: 0;
                height: 0;
                padding: 0;
                margin: 0;
            }

            /* Đảm bảo phần tử hoạt động tốt trên các kích thước màn hình khác nhau */
            @media (max-width: 768px) {
                .cours-more-info {
                    flex-direction: column;
                    gap: 15px;
                }

                .cours-more-info .review,
                .cours-more-info .price {
                    width: 100%; /* Chiếm toàn bộ chiều rộng */
                }
            }
        </style>
    </head>

    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>

            <!-- Header Top ==== -->
            <header class="header rs-nav">
                <div class="top-bar">
                    <div class="container">
                        <div class="row d-flex justify-content-between">
                            <div class="topbar-left">
                                <ul>
                                    <li><a href="faq-1.jsp"><i class="fa fa-question-circle"></i>Ask a
                                            Question</a></li>
                                    <li><a href="javascript:;"><i
                                                class="fa fa-envelope-o"></i>Support@website.com</a></li>
                                </ul>
                            </div>
                            <div class="topbar-right">
                                <ul>
                                    <li>
                                        <select class="header-lang-bx">
                                            <option data-icon="flag flag-uk">English UK</option>
                                            <option data-icon="flag flag-us">English US</option>
                                        </select>
                                    </li>
                                    <li><a href="login.html">Login</a></li>
                                    <li><a href="register.html">Register</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sticky-header navbar-expand-lg">
                    <div class="menu-bar clearfix">
                        <div class="container clearfix">
                            <!-- Header Logo ==== -->
                            <div class="menu-logo">
                                <a href="index.html"><img src="assets/images/logo.png" alt=""></a>
                            </div>
                            <!-- Mobile Nav Button ==== -->
                            <button class="navbar-toggler collapsed menuicon justify-content-end" type="button"
                                    data-toggle="collapse" data-target="#menuDropdown" aria-controls="menuDropdown"
                                    aria-expanded="false" aria-label="Toggle navigation">
                                <span></span>
                                <span></span>
                                <span></span>
                            </button>
                            <!-- Author Nav ==== -->
                            <div class="secondary-menu">
                                <div class="secondary-inner">
                                    <ul>
                                        <li><a href="javascript:;" class="btn-link"><i
                                                    class="fa fa-facebook"></i></a></li>
                                        <li><a href="javascript:;" class="btn-link"><i
                                                    class="fa fa-google-plus"></i></a></li>
                                        <li><a href="javascript:;" class="btn-link"><i
                                                    class="fa fa-linkedin"></i></a></li>
                                        <!-- Search Button ==== -->
                                        <li class="search-btn"><button id="quik-search-btn" type="button"
                                                                       class="btn-link"><i class="fa fa-search"></i></button></li>
                                    </ul>
                                </div>
                            </div>
                            <!-- Search Box ==== -->
                            <div class="nav-search-bar">
                                <form action="#">
                                    <input name="search" value="" type="text" class="form-control"
                                           placeholder="Type to search">
                                    <span><i class="ti-search"></i></span>
                                </form>
                                <span id="search-remove"><i class="ti-close"></i></span>
                            </div>

                            <!-- Navigation Menu ==== -->
                            <div class="menu-links navbar-collapse collapse justify-content-start"
                                 id="menuDropdown">
                                <div class="menu-logo">
                                    <a href="index.html"><img src="assets/images/logo.png" alt=""></a>
                                </div>
                                <ul class="nav navbar-nav">
                                    <li class="active"><a href="javascript:;">Home <i
                                                class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="index.html">Home 1</a></li>
                                            <li><a href="index-2.html">Home 2</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="javascript:;">Pages <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="javascript:;">About<i
                                                        class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="about-1.jsp">About 1</a></li>
                                                    <li><a href="about-2.jsp">About 2</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="javascript:;">Event<i
                                                        class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="event.html">Event</a></li>
                                                    <li><a href="events-details.html">Events Details</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="javascript:;">FAQ's<i
                                                        class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="faq-1.jsp">FAQ's 1</a></li>
                                                    <li><a href="faq-2.html">FAQ's 2</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="javascript:;">Contact Us<i
                                                        class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="contact-1.jsp">Contact Us 1</a></li>
                                                    <li><a href="contact-2.jsp">Contact Us 2</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="portfolio.html">Portfolio</a></li>
                                            <li><a href="profile.html">Profile</a></li>
                                            <li><a href="membership.html">Membership</a></li>
                                            <li><a href="error-404.html">404 Page</a></li>
                                        </ul>
                                    </li>
                                    <li class="add-mega-menu"><a href="javascript:;">Our Courses <i
                                                class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu add-menu">
                                            <li class="add-menu-left">
                                                <h5 class="menu-adv-title">Our Courses</h5>
                                                <ul>
                                                    <li><a href="courses.html">Courses </a></li>
                                                    <li><a href="courses-details.html">Courses Details</a></li>
                                                    <li><a href="profile.html">Instructor Profile</a></li>
                                                    <li><a href="event.html">Upcoming Event</a></li>
                                                    <li><a href="membership.html">Membership</a></li>
                                                </ul>
                                            </li>
                                            <li class="add-menu-right">
                                                <img src="assets/images/adv/adv.jpg" alt="" />
                                            </li>
                                        </ul>
                                    </li>
                                    <li><a href="javascript:;">Blog <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="blog-classic-grid.jsp">Blog Classic</a></li>
                                            <li><a href="blog-classic-sidebar.jsp">Blog Classic Sidebar</a></li>
                                            <li><a href="blog-list-sidebar.jsp">Blog List Sidebar</a></li>
                                            <li><a href="blog-standard-sidebar.jsp">Blog Standard Sidebar</a>
                                            </li>
                                            <li><a href="blog-details.jsp">Blog Details</a></li>
                                        </ul>
                                    </li>
                                    <li class="nav-dashboard"><a href="javascript:;">Dashboard <i
                                                class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="admin/index.html">Dashboard</a></li>
                                            <li><a href="admin/add-listing.html">Add Listing</a></li>
                                            <li><a href="admin/bookmark.html">Bookmark</a></li>
                                            <li><a href="admin/courses.html">Courses</a></li>
                                            <li><a href="admin/review.html">Review</a></li>
                                            <li><a href="admin/teacher-profile.html">Teacher Profile</a></li>
                                            <li><a href="admin/user-profile.html">User Profile</a></li>
                                            <li><a href="javascript:;">Calendar<i
                                                        class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="admin/basic-calendar.html">Basic Calendar</a>
                                                    </li>
                                                    <li><a href="admin/list-view-calendar.html">List View
                                                            Calendar</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="javascript:;">Mailbox<i
                                                        class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="admin/mailbox.html">Mailbox</a></li>
                                                    <li><a href="admin/mailbox-compose.html">Compose</a></li>
                                                    <li><a href="admin/mailbox-read.html">Mail Read</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <div class="nav-social-link">
                                    <a href="javascript:;"><i class="fa fa-facebook"></i></a>
                                    <a href="javascript:;"><i class="fa fa-google-plus"></i></a>
                                    <a href="javascript:;"><i class="fa fa-linkedin"></i></a>
                                </div>
                            </div>
                            <!-- Navigation Menu END ==== -->
                        </div>
                    </div>
                </div>
            </header>

            <!-- header END ==== -->
            <!-- Content -->



            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark"
                     style="background-image:url(assets/images/banner/banner3.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Our Courses</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="#">Home</a></li>
                            <li>Our Courses</li>
                        </ul>
                    </div>
                </div>

                <!-- Breadcrumb row END -->
                <!-- inner page banner END -->
                <div class="content-block">
                    <!-- About Us -->
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                    <form action="listCourse">
                                        <div class="widget courses-search-bx ">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <label>Search Courses</label>
                                                    <input name="search" type="text" required
                                                           class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                    </form>

                                    <div class="widget widget_archive">
                                        <h5 class="widget-title style-1">All Courses</h5>
                                        <ul>
                                            <c:forEach items="${requestScope.listCourseType}" var="courseType">
                                                <li class="active">
                                                    <a
                                                        href="listCourse?cate=${courseType.courseTypeId}">${courseType.courseTypeName}</a>
                                                </li>
                                            </c:forEach>

                                        </ul>
                                    </div>

                                    <div class="widget recent-posts-entry widget-courses">
                                        <h5 class="widget-title style-1">Recent Courses</h5>
                                        <div class="widget-post-bx">
                                            <c:forEach items="${requestScope.listRecent}" var="recent">
                                                <div class="widget-post clearfix">
                                                    <div class="ttr-post-media"> <img
                                                            src="assets/images/blog/recent-blog/pic1.jpg"
                                                            width="200" height="143" alt=""> </div>
                                                    <div class="ttr-post-info">
                                                        <div class="ttr-post-header">
                                                            <h6 class="post-title"><a href="#">${recent.course.courseName}</a></h6>
                                                        </div>
                                                        <div class="ttr-post-meta">
                                                            <ul>
                                                                <li class="price">
                                                                    <del>${recent.originalPrice}</del>
                                                                    <h5>${recent.lowestSalePrice}</h5>
                                                                </li>
                                                                <li class="review">${recent.rating}</li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>

                                <!--        bat dau course-->
                                <div class="col-lg-9 col-md-8 col-sm-12">
                                    <div class="row">
                                        <div class="col-6">
                                            <form class="col-2" action="listCourse" id="statusForm">
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
                                        </div>
                                        <div class ="col-6">
                                            <!-- The Popup -->
                                            <button class="open-popup-btn" onclick="openPopup()">Open Popup</button>
                                            <div class="popup" id="popup">
                                                <div class="popup-content">
                                                    <button class="close-btn" onclick="closePopup()">X</button>

                                                    <!-- Form để submit dữ liệu -->
                                                    <form id="popup-form" action="listCourse">
                                                        <div class="left-side">
                                                            <h2>Display properties</h2>

                                                            <!-- Các lựa chọn checkbox để chọn nhiều thuộc tính -->
                                                            <label>
                                                                <input type="checkbox" name="display-option" value="review" onclick="updateDisplay()"> Review
                                                            </label><br>
                                                            <label>
                                                                <input type="checkbox" name="display-option" value="lowest-price" onclick="updateDisplay()"> Lowest Price
                                                            </label><br>
                                                            <label>
                                                                <input type="checkbox" name="display-option" value="author" onclick="updateDisplay()"> Author
                                                            </label><br>
                                                            <label>
                                                                <input type="checkbox" name="display-option" value="original-price" onclick="updateDisplay()"> Original Price
                                                            </label><br>
                                                        </div>

                                                        <div class="divider"></div>

                                                        <div class="right-side">
                                                            <label for="number-course">Number course in 1 page</label>
                                                            <input type="number" id="number-course" name="numberOfCourse" placeholder="Text here" min="1"><br>
                                                        </div>

                                                        <div class="popup-buttons">
                                                            <button class="clear-btn" type="button" onclick="clearFields()">Clear All</button>
                                                            <button class="apply-btn" type="submit" onclick="applyChanges(event)">Apply</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>

                                        <c:forEach items="${requestScope.listCourse}" var="courseDetail">
                                            <div class="col-md-6 col-lg-4 col-sm-6 m-b30">
                                                <div class="cours-bx"  data-course-id="${courseDetail.course.courseId}">
                                                    <div class="action-box">
                                                        <img src="assets/images/courses/pic9.jpg" alt="">
                                                        <a href="#" class="btn">Read More</a>
                                                    </div>
                                                    <div class="info-bx text-center">
                                                        <h5><a href="#">${courseDetail.course.courseName}</a></h5>
                                                        <span class="course-author col-12 col-sm-6 col-md-2" id="author-${courseDetail.course.courseId}">
                                                            ${courseDetail.course.expert.user.firstName} ${courseDetail.course.expert.user.lastName}
                                                        </span>
                                                    </div>

                                                    <div class="cours-more-info">
                                                        <!-- Review section -->
                                                        <div class="review" id="review-${courseDetail.course.courseId}" >
                                                            <span>${courseDetail.totalEnrollment}</span>
                                                            <span>${courseDetail.rating}</span>
                                                        </div>

                                                        <!--  Price section -->
                                                        <div class="price">
                                                            <!-- Original Price section (nằm trên Lowest Price) -->
                                                            <div class="original-price" id="original-price-${courseDetail.course.courseId}">
                                                                <del>${courseDetail.originalPrice}</del>
                                                            </div>

                                                            <!-- Lowest Price section -->
                                                            <div class="lowest-price" id="lowest-price-${courseDetail.course.courseId}">
                                                                <h5>${courseDetail.lowestSalePrice}</h5>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <script>
                                        // Open the popup
                                        function openPopup() {
                                            document.getElementById('popup').style.display = 'flex';
                                        }

                                        // Close the popup
                                        function closePopup() {
                                            document.getElementById('popup').style.display = 'none';
                                        }

                                        // Clear all input fields
                                        function clearFields() {
                                            document.getElementById('number-course').value = '';
                                            const checkboxes = document.getElementsByName('display-option');
                                            checkboxes.forEach(checkbox => checkbox.checked = false);
                                        }

                                        // Hàm cập nhật trạng thái checkbox vào localStorage và hiển thị các thuộc tính của khóa học
                                        function updateDisplay() {
                                            const selectedOptions = [];
                                            const checkboxes = document.getElementsByName('display-option');

                                            // Lưu trạng thái của checkbox vào localStorage
                                            checkboxes.forEach(checkbox => {
                                                if (checkbox.checked) {
                                                    selectedOptions.push(checkbox.value);
                                                }
                                            });

                                            // Lưu vào localStorage
                                            localStorage.setItem('selectedOptions', JSON.stringify(selectedOptions));

                                            // Cập nhật hiển thị các thuộc tính dựa trên checkbox đã chọn
                                            const courses = document.querySelectorAll('.cours-bx');

                                            courses.forEach(course => {
                                                const courseId = course.getAttribute('data-course-id');
                                                console.log("Course ID:", courseId); // Debug

                                                // Sửa lỗi cú pháp: Dùng template literals
                                                const reviewElement = document.getElementById("review-" + courseId);
                                                const originalPriceElement = document.getElementById("original-price-" + courseId);
                                                const lowestPriceElement = document.getElementById("lowest-price-" + courseId);
                                                const authorElement = document.getElementById("author-" + courseId);
                                                console.log("Review Element:", reviewElement); // Debug

                                                // Kiểm tra null trước khi thay đổi style để tránh lỗi
                                                if (reviewElement)
                                                    reviewElement.style.display = selectedOptions.includes('review') ? 'block' : 'none';
                                                if (originalPriceElement)
                                                    originalPriceElement.style.display = selectedOptions.includes('original-price') ? 'block' : 'none';
                                                if (authorElement)
                                                    authorElement.style.display = selectedOptions.includes('author') ? 'block' : 'none';
                                                if (lowestPriceElement)
                                                    lowestPriceElement.style.display = selectedOptions.includes('lowest-price') ? 'block' : 'none';
                                            });
                                        }

                                        // Hàm khôi phục trạng thái checkbox từ localStorage khi tải lại trang
                                        function restoreDisplay() {
                                            const selectedOptions = JSON.parse(localStorage.getItem('selectedOptions') || '[]');
                                            const checkboxes = document.getElementsByName('display-option');

                                            checkboxes.forEach(checkbox => {
                                                checkbox.checked = selectedOptions.includes(checkbox.value);
                                            });

                                            // Gọi hàm updateDisplay để hiển thị lại các thuộc tính đã chọn
                                            updateDisplay();
                                        }

                                        // Hàm gửi dữ liệu numberOfCourse đi khi bấm "Apply"
                                        function applyChanges(event) {
                                            event.preventDefault(); // Ngừng gửi form tự động
                                            const numberOfCourses = document.getElementById('number-course').value;

                                            if (numberOfCourses && numberOfCourses > 0) {
                                                document.getElementById('popup-form').submit();
                                            } else {
                                                alert('Please enter a valid number of courses.');
                                            }
                                        }

                                        // Khôi phục trạng thái checkbox và numberOfCourse khi tải lại trang
                                        window.onload = function () {
                                            restoreDisplay();
                                        };
                                    </script>

                                    <div class="pagination-bx rounded-sm gray clearfix">
                                        <ul class="pagination justify-content-center">
                                            <c:forEach begin="1" end="${requestScope.pageNum}" var="i">
                                                <li
                                                    class="page-item ${i == requestScope.currentPage ? 'active' : ''}">
                                                    <a class="page-link m-lg-1"
                                                       href="listCourse?page=${i}&arrange=${requestScope.arrange}&cate=${requestScope.cate}&search=${requestScope.search}">${i}</a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- contact area END -->

            </div>
            <!-- Content END-->
            <!-- Footer ==== -->
            <footer>
                <div class="footer-top">
                    <div class="pt-exebar">
                        <div class="container">
                            <div class="d-flex align-items-stretch">
                                <div class="pt-logo mr-auto">
                                    <a href="index.html"><img src="assets/images/logo-white.png" alt="" /></a>
                                </div>
                                <div class="pt-social-link">
                                    <ul class="list-inline m-a0">
                                        <li><a href="#" class="btn-link"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-twitter"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-linkedin"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-google-plus"></i></a>
                                        </li>
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
                                    <p class="text-capitalize m-b20">Weekly Breaking news analysis and cutting
                                        edge advices on job searching.</p>
                                    <div class="subscribe-form m-b20">
                                        <form class="subscription-form"
                                              action="http://educhamp.themetrades.com/demo/assets/script/mailchamp.php"
                                              method="post">
                                            <div class="ajax-message"></div>
                                            <div class="input-group">
                                                <input name="email" required="required" class="form-control"
                                                       placeholder="Your Email Address" type="email">
                                                <span class="input-group-btn">
                                                    <button name="submit" value="Submit" type="submit"
                                                            class="btn"><i class="fa fa-arrow-right"></i></button>
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
                                                <li><a href="faq-1.jsp">FAQs</a></li>
                                                <li><a href="contact-1.jsp">Contact</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                        <div class="widget footer_widget">
                                            <h5 class="footer-title">Get In Touch</h5>
                                            <ul>
                                                <li><a
                                                        href="http://educhamp.themetrades.com/admin/index.html">Dashboard</a>
                                                </li>
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
                                        <li><a href="assets/images/gallery/pic1.jpg"
                                               class="magnific-anchor"><img
                                                    src="assets/images/gallery/pic1.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic2.jpg"
                                               class="magnific-anchor"><img
                                                    src="assets/images/gallery/pic2.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic3.jpg"
                                               class="magnific-anchor"><img
                                                    src="assets/images/gallery/pic3.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic4.jpg"
                                               class="magnific-anchor"><img
                                                    src="assets/images/gallery/pic4.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic5.jpg"
                                               class="magnific-anchor"><img
                                                    src="assets/images/gallery/pic5.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic6.jpg"
                                               class="magnific-anchor"><img
                                                    src="assets/images/gallery/pic6.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic7.jpg"
                                               class="magnific-anchor"><img
                                                    src="assets/images/gallery/pic7.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic8.jpg"
                                               class="magnific-anchor"><img
                                                    src="assets/images/gallery/pic8.jpg" alt=""></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="footer-bottom">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 text-center"> <a target="_blank"
                                                                                       href="https://www.templateshub.net">Templates Hub</a></div>
                        </div>
                    </div>
                </div>
            </footer>
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
        <script src='assets/vendors/switcher/switcher.js'></script>
    </body>

</html>