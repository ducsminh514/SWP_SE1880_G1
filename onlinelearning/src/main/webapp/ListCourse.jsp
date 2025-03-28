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

        <!--[if lt IE 9]-->
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
        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <!-- REVOLUTION SLIDER CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/layers.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/settings.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/navigation.css">
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

            /* Cải thiện kiểu cho dropdown */
            .form-select {
                border: 1px solid #ccc;
                border-radius: 8px; /* Góc bo tròn */
                padding: 8px 16px; /* Khoảng cách cho các phần tử trong dropdown */
                font-size: 16px; /* Tăng kích thước chữ */
                background-color: #fff; /* Màu nền */
                transition: all 0.3s ease; /* Thêm hiệu ứng khi hover hoặc focus */
            }

            /* Thêm hiệu ứng hover */
            .form-select:hover, .form-select:focus {
                border-color: #007bff; /* Đổi màu viền khi hover */
                background-color: #f0f8ff; /* Thay đổi màu nền khi hover */
                outline: none; /* Xóa viền khi chọn */
            }

            /* Style cho button submit (nếu cần thiết) */
            .form-select-sm {
                font-size: 14px; /* Giảm kích thước font */
            }

            /* Tăng hiệu quả của các option */
            .form-select option {
                padding: 10px;
            }

            /* Thêm khoảng cách cho form */
            #statusForm {
                display: inline-block; /* Đảm bảo form không chiếm toàn bộ chiều rộng */
                margin-right: 10px; /* Khoảng cách giữa các phần tử */
                background-color: #f9f9f9; /* Thêm màu nền nhẹ cho form */
                border-radius: 8px; /* Bo góc form */
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); /* Thêm bóng đổ cho form */
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
                <div class="rev-slider">
                    <div id="rev_slider_486_1_wrapper" class="rev_slider_wrapper fullwidthbanner-container" data-alias="news-gallery36" data-source="gallery" style="margin:0px auto;background-color:#ffffff;padding:0px;margin-top:0px;margin-bottom:0px;">
                        <!-- START REVOLUTION SLIDER 5.3.0.2 fullwidth mode -->
                        <div id="rev_slider_486_1" class="rev_slider fullwidthabanner" style="display:none;" data-version="5.3.0.2">
                            <ul>	<!-- SLIDE  -->
                                <c:forEach items="${requestScope.listSlider}" var ="slide">
                                    <li data-index="rs-${slide.slideId}"
                                        data-transition="parallaxvertical"
                                        data-slotamount="default"
                                        data-hideafterloop="0"
                                        data-hideslideonmobile="off"
                                        data-easein="default"
                                        data-easeout="default"
                                        data-masterspeed="default"
                                        data-thumb="error-404.html"
                                        data-rotate="0"
                                        data-fstransition="fade"
                                        data-fsmasterspeed="1500"
                                        data-fsslotamount="7"
                                        data-saveperformance="off"
                                        data-title="A STUDY ON HAPPINESS"
                                        data-param1="" data-param2=""
                                        data-param3="" data-param4=""
                                        data-param5="" data-param6=""
                                        data-param7="" data-param8=""
                                        data-param9="" data-param10=""
                                        data-description="Science says that Women are generally happier">
                                        <!-- MAIN IMAGE -->
                                        <img src="${slide.image}" alt=""
                                             data-bgposition="center center"
                                             data-bgfit="cover"
                                             data-bgrepeat="no-repeat"
                                             data-bgparallax="10"
                                             class="rev-slidebg"
                                             data-no-retina />

                                        <!-- LAYER NR. 1 -->
                                        <div class="tp-caption tp-shape tp-shapewrapper "
                                             id="slide-${slide.slideId}-layer-1"
                                             data-x="['center','center','center','center']" data-hoffset="['0','0','0','0']"
                                             data-y="['middle','middle','middle','middle']" data-voffset="['0','0','0','0']"
                                             data-width="full"
                                             data-height="full"
                                             data-whitespace="nowrap"
                                             data-type="shape"
                                             data-basealign="slide"
                                             data-responsive_offset="off"
                                             data-responsive="off"
                                             data-frames='[{"from":"opacity:0;","speed":1,"to":"o:1;","delay":0,"ease":"Power4.easeOut"},{"delay":"wait","speed":1,"to":"opacity:0;","ease":"Power4.easeOut"}]'
                                             data-textAlign="['left','left','left','left']"
                                             data-paddingtop="[0,0,0,0]"
                                             data-paddingright="[0,0,0,0]"
                                             data-paddingbottom="[0,0,0,0]"
                                             data-paddingleft="[0,0,0,0]"
                                             style="z-index: 5;background-color:rgba(2, 0, 11, 0.80);border-color:rgba(0, 0, 0, 0);border-width:0px;">
                                        </div>
                                        <!-- LAYER NR. 2 -->
                                        <div class="tp-caption Newspaper-Title   tp-resizeme"
                                             id="slide-${slide.slideId}-layer-2"
                                             data-x="['center','center','center','center']"
                                             data-hoffset="['0','0','0','0']"
                                             data-y="['top','top','top','top']"
                                             data-voffset="['250','250','250','240']"
                                             data-fontsize="['50','50','50','30']"
                                             data-lineheight="['55','55','55','35']"
                                             data-width="full"
                                             data-height="none"
                                             data-whitespace="normal"
                                             data-type="text"
                                             data-responsive_offset="on"
                                             data-frames='[{"from":"y:[-100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;","mask":"x:0px;y:0px;s:inherit;e:inherit;","speed":1500,"to":"o:1;","delay":1000,"ease":"Power3.easeInOut"},{"delay":"wait","speed":1000,"to":"auto:auto;","mask":"x:0;y:0;s:inherit;e:inherit;","ease":"Power3.easeInOut"}]'
                                             data-textAlign="['center','center','center','center']"
                                             data-paddingtop="[0,0,0,0]"
                                             data-paddingright="[0,0,0,0]"
                                             data-paddingbottom="[10,10,10,10]"
                                             data-paddingleft="[0,0,0,0]"
                                             style="z-index: 6; font-family:rubik; font-weight:700; text-align:center; white-space: normal;">
                                            ${slide.title}
                                        </div>

                                        <!-- LAYER NR. 3 -->
                                        <div class="tp-caption Newspaper-Subtitle   tp-resizeme"
                                             id="slide-${slide.slideId}-layer-3"
                                             data-x="['center','center','center','center']"
                                             data-hoffset="['0','0','0','0']"
                                             data-y="['top','top','top','top']"
                                             data-voffset="['210','210','210','210']"
                                             data-width="none"
                                             data-height="none"
                                             data-whitespace="nowrap"
                                             data-type="text"
                                             data-responsive_offset="on"
                                             data-frames='[{"from":"y:[-100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;","mask":"x:0px;y:0px;s:inherit;e:inherit;","speed":1500,"to":"o:1;","delay":1000,"ease":"Power3.easeInOut"},{"delay":"wait","speed":1000,"to":"auto:auto;","mask":"x:0;y:0;s:inherit;e:inherit;","ease":"Power3.easeInOut"}]'
                                             data-textAlign="['left','left','left','left']"
                                             data-paddingtop="[0,0,0,0]"
                                             data-paddingright="[0,0,0,0]"
                                             data-paddingbottom="[0,0,0,0]"
                                             data-paddingleft="[0,0,0,0]"
                                             style="z-index: 7; white-space: nowrap; color:#fff; font-family:rubik; font-size:18px; font-weight:400;">
                                            ${slide.content}
                                        </div>

                                        <!-- LAYER NR. 3 -->
                                        <div class="tp-caption Newspaper-Subtitle   tp-resizeme"
                                             id="slide-${slide.slideId}-layer-4"
                                             data-x="['center','center','center','center']"
                                             data-hoffset="['0','0','0','0']"
                                             data-y="['top','top','top','top']"
                                             data-voffset="['320','320','320','290']"
                                             data-width="['800','800','700','420']"
                                             data-height="['100','100','100','120']"
                                             data-whitespace="unset"
                                             data-type="text"
                                             data-responsive_offset="on"
                                             data-frames='[{"from":"y:[-100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;","mask":"x:0px;y:0px;s:inherit;e:inherit;","speed":1500,"to":"o:1;","delay":1000,"ease":"Power3.easeInOut"},{"delay":"wait","speed":1000,"to":"auto:auto;","mask":"x:0;y:0;s:inherit;e:inherit;","ease":"Power3.easeInOut"}]'
                                             data-textAlign="['center','center','center','center']"
                                             data-paddingtop="[0,0,0,0]"
                                             data-paddingright="[0,0,0,0]"
                                             data-paddingbottom="[0,0,0,0]"
                                             data-paddingleft="[0,0,0,0]"
                                             style="z-index: 7; text-transform:capitalize; white-space: unset; color:#fff; font-family:rubik; font-size:18px; line-height:28px; font-weight:400;">
                                            ${slide.description}
                                        </div>
                                        <!-- LAYER NR. 4 -->
                                        <div class="tp-caption Newspaper-Button rev-btn "
                                             id="slide-${slide.slideId}-layer-5"
                                             data-x="['center','center','center','center']"
                                             data-hoffset="['90','80','75','90']"
                                             data-y="['top','top','top','top']"
                                             data-voffset="['400','400','400','420']"
                                             data-width="none"
                                             data-height="none"
                                             data-whitespace="nowrap"
                                             data-type="button"
                                             data-responsive_offset="on"
                                             data-responsive="off"
                                             data-frames='[{"from":"y:[-100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;","mask":"x:0px;y:0px;","speed":1500,"to":"o:1;","delay":1000,"ease":"Power3.easeInOut"},{"delay":"wait","speed":1000,"to":"auto:auto;","mask":"x:0;y:0;","ease":"Power3.easeInOut"},{"frame":"hover","speed":"300","ease":"Power1.easeInOut","to":"o:1;rX:0;rY:0;rZ:0;z:0;","style":"c:rgba(0, 0, 0, 1.00);bg:rgba(255, 255, 255, 1.00);bc:rgba(255, 255, 255, 1.00);bw:1px 1px 1px 1px;"}]'
                                             data-textAlign="['center','center','center','center']"
                                             data-paddingtop="[12,12,12,12]"
                                             data-paddingright="[30,35,35,15]"
                                             data-paddingbottom="[12,12,12,12]"
                                             data-paddingleft="[30,35,35,15]"
                                             style="z-index: 8; white-space: nowrap; outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;cursor:pointer; background-color:var(--primary) !important; border:0; border-radius:30px; margin-right:5px;">READ MORE </div>
                                        <div class="tp-caption Newspaper-Button rev-btn"
                                             id="slide-${slide.slideId}-layer-6"
                                             data-x="['center','center','center','center']"
                                             data-hoffset="['-90','-80','-75','-90']"
                                             data-y="['top','top','top','top']"
                                             data-voffset="['400','400','400','420']"
                                             data-width="none"
                                             data-height="none"
                                             data-whitespace="nowrap"
                                             data-type="button"
                                             data-responsive_offset="on"
                                             data-responsive="off"
                                             data-frames='[{"from":"y:[-100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;","mask":"x:0px;y:0px;","speed":1500,"to":"o:1;","delay":1000,"ease":"Power3.easeInOut"},{"delay":"wait","speed":1000,"to":"auto:auto;","mask":"x:0;y:0;","ease":"Power3.easeInOut"},{"frame":"hover","speed":"300","ease":"Power1.easeInOut","to":"o:1;rX:0;rY:0;rZ:0;z:0;","style":"c:rgba(0, 0, 0, 1.00);bg:rgba(255, 255, 255, 1.00);bc:rgba(255, 255, 255, 1.00);bw:1px 1px 1px 1px;"}]'
                                             data-textAlign="['center','center','center','center']"
                                             data-paddingtop="[12,12,12,12]"
                                             data-paddingright="[30,35,35,15]"
                                             data-paddingbottom="[12,12,12,12]"
                                             data-paddingleft="[30,35,35,15]"
                                             style="z-index: 8; white-space: nowrap; outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;cursor:pointer; border-radius:30px;">CONTACT US</div>
                                    </li>
                                </c:forEach>
                                <!-- SLIDE  -->
                            </ul>
                        </div><!-- END REVOLUTION SLIDER -->
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
                                                <h4> Search course  </h4>
                                                <div class="input-group">
                                                    <input name="search" type="text" required
                                                           class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                    </form>

                                    <div class="widget widget_archive">
                                        <h5 class="widget-title style-1">Category Course</h5>
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
                                                                    <del>${recent.originalPrice}</del><br>
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
                                                <input type="hidden" name="search" value="${requestScope.search}">
                                                <input type="hidden" name="page" value="${requestScope.currentPage}">
                                                <input type="hidden" name="cate" value="${requestScope.cate}">
                                                <input type="hidden" name="numberOfCourse" value="${requestScope.numberOfCourse}">
                                                <select class="form-select form-select-sm" aria-label="Small select example" name="arrange" onchange="document.getElementById('statusForm').submit();">
                                                    <option selected>Arrange</option>
                                                    <option value="rating">Highest Rating</option>
                                                    <option value="date-soon">Earliest Date</option>
                                                    <option value="date-late">Latest Date</option>
                                                </select>
                                            </form>
                                        </div>

                                        <div class ="col-6 text-end">
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
                                                        <a href="#" class="btn">Regist</a>
                                                    </div>
                                                    <div class="info-bx text-center">
                                                        <h5><a href="courseDetail?courseId=${courseDetail.course.courseId}">${courseDetail.course.courseName}</a></h5>
                                                        <span class="course-author " id="author-${courseDetail.course.courseId}">
                                                            ${courseDetail.course.expert.user.firstName} ${courseDetail.course.expert.user.lastName}
                                                        </span>
                                                    </div>

                                                    <div class="cours-more-info">
                                                        <!-- Review section -->
                                                        <div class="review" id="review-${courseDetail.course.courseId}" >
                                                            <span>${courseDetail.totalEnrollment} enrollment</span>
                                                            <span>${courseDetail.rating} rating</span>
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
                                                       href="listCourse?page=${i}&arrange=${requestScope.arrange}&cate=${requestScope.cate}&search=${requestScope.search}&numberOfCourse=${requestScope.numberOfCourse}">${i}</a>
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
        <!-- Revolution JavaScripts Files -->
        <script src="assets/vendors/revolution/js/jquery.themepunch.tools.min.js"></script>
        <script src="assets/vendors/revolution/js/jquery.themepunch.revolution.min.js"></script>
        <!-- Slider revolution 5.0 Extensions  (Load Extensions only on Local File Systems !  The following part can be removed on Server for On Demand Loading) -->
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.actions.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.carousel.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.kenburn.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.layeranimation.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.migration.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.navigation.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.parallax.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.slideanims.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.video.min.js"></script>
        <script>
                                        jQuery(document).ready(function () {
                                            var ttrevapi;
                                            var tpj = jQuery;
                                            if (tpj("#rev_slider_486_1").revolution == undefined) {
                                                revslider_showDoubleJqueryError("#rev_slider_486_1");
                                            } else {
                                                ttrevapi = tpj("#rev_slider_486_1").show().revolution({
                                                    sliderType: "standard",
                                                    jsFileLocation: "assets/vendors/revolution/js/",
                                                    sliderLayout: "fullwidth",
                                                    dottedOverlay: "none",
                                                    delay: 9000,
                                                    navigation: {
                                                        keyboardNavigation: "on",
                                                        keyboard_direction: "horizontal",
                                                        mouseScrollNavigation: "off",
                                                        mouseScrollReverse: "default",
                                                        onHoverStop: "on",
                                                        touch: {
                                                            touchenabled: "on",
                                                            swipe_threshold: 75,
                                                            swipe_min_touches: 1,
                                                            swipe_direction: "horizontal",
                                                            drag_block_vertical: false
                                                        }
                                                        ,
                                                        arrows: {
                                                            style: "uranus",
                                                            enable: true,
                                                            hide_onmobile: false,
                                                            hide_onleave: false,
                                                            tmp: '',
                                                            left: {
                                                                h_align: "left",
                                                                v_align: "center",
                                                                h_offset: 10,
                                                                v_offset: 0
                                                            },
                                                            right: {
                                                                h_align: "right",
                                                                v_align: "center",
                                                                h_offset: 10,
                                                                v_offset: 0
                                                            }
                                                        },

                                                    },
                                                    viewPort: {
                                                        enable: true,
                                                        outof: "pause",
                                                        visible_area: "80%",
                                                        presize: false
                                                    },
                                                    responsiveLevels: [1240, 1024, 778, 480],
                                                    visibilityLevels: [1240, 1024, 778, 480],
                                                    gridwidth: [1240, 1024, 778, 480],
                                                    gridheight: [768, 600, 600, 600],
                                                    lazyType: "none",
                                                    parallax: {
                                                        type: "scroll",
                                                        origo: "enterpoint",
                                                        speed: 400,
                                                        levels: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 46, 47, 48, 49, 50, 55],
                                                        type: "scroll",
                                                    },
                                                    shadow: 0,
                                                    spinner: "off",
                                                    stopLoop: "off",
                                                    stopAfterLoops: -1,
                                                    stopAtSlide: -1,
                                                    shuffle: "off",
                                                    autoHeight: "off",
                                                    hideThumbsOnMobile: "off",
                                                    hideSliderAtLimit: 0,
                                                    hideCaptionAtLimit: 0,
                                                    hideAllCaptionAtLilmit: 0,
                                                    debugMode: false,
                                                    fallbacks: {
                                                        simplifyAll: "off",
                                                        nextSlideOnWindowFocus: "off",
                                                        disableFocusListener: false
                                                    }
                                                });
                                            }
                                        });
        </script>
    </body>

</html>