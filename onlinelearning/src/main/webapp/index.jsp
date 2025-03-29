<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="LMS, Learning, Online Education, Courses, Online Courses" />
        <meta name="author" content="EduChamp" />
        <meta name="robots" content="index, follow" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp - Professional Learning Management System" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp - Online Learning Platform" />
        <meta property="og:description" content="Discover top-quality courses and resources for your professional development" />
        <meta property="og:image" content="assets/images/logo.png" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp | Online Learning Platform</title>

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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <!-- REVOLUTION SLIDER CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/layers.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/settings.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/navigation.css">
        
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        
        <style>
            /* Cải thiện sidebar */
            aside.side-bar {
                margin-top: 30px;
                box-shadow: 0 0 30px rgba(0,0,0,0.05);
                border-radius: 10px;
                padding: 20px;
                background-color: #fff;
            }
            
            /* Nâng cấp card courses */
            .cours-bx {
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0,0,0,0.08);
                transition: all 0.3s ease;
                margin-bottom: 30px;
                border: none;
            }
            
            .cours-bx:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            }
            
            .cours-bx .info-bx {
                padding: 20px 15px;
            }
            
            /* Nâng cấp service box */
            .service-bx {
                border-radius: 10px;
                overflow: hidden;
                transition: all 0.3s ease;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            }
            
            .service-bx:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            }
            
            .service-bx .action-box img {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }
            
            .service-bx .info-bx {
                padding: 20px 15px;
            }
            
            /* Nâng cấp blog cards */
            .recent-news {
                transition: all 0.3s ease;
                height: 100% !important;
                min-height: 250px;
            }
            
            .recent-news:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.15) !important;
            }
            
            /* Footer nâng cấp */
            .footer {
                background-color: #033d75;
                background-image: linear-gradient(to right, #033d75, #0261bf);
            }
            
            /* Nút Back to Top */
            .back-to-top {
                border-radius: 50%;
                box-shadow: 0 5px 15px rgba(0,0,0,0.15);
                width: 50px;
                height: 50px;
                line-height: 50px;
                text-align: center;
            }
            
            /* Nâng cấp headings */
            .section-head {
                margin-bottom: 40px;
            }
            
            .title-head {
                position: relative;
                padding-bottom: 15px;
                margin-bottom: 20px;
                font-weight: 600;
                text-transform: capitalize;
            }
            
            .title-head:after {
                content: "";
                position: absolute;
                width: 60px;
                height: 3px;
                background: var(--primary);
                bottom: 0;
                left: 0;
            }
            
            .title-head.text-center:after {
                left: 50%;
                transform: translateX(-50%);
            }
            
            /* Cấu trúc trang chính */
            .page-content {
                padding-top: 0;
            }
            
            .content-area {
                padding-top: 30px;
            }
            
            /* Hiệu ứng hover các nút */
            .btn {
                border-radius: 30px;
                font-weight: 500;
                transition: all 0.3s ease;
                padding: 10px 25px;
            }
            
            .btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }
            
            /* Widget Recent Posts */
            .widget.recent-posts-entry .widget-post {
                margin-bottom: 20px;
                padding-bottom: 20px;
                border-bottom: 1px solid #eee;
            }
            
            .widget.recent-posts-entry .widget-post:last-child {
                border-bottom: none;
                padding-bottom: 0;
                margin-bottom: 0;
            }
            
            .widget.recent-posts-entry .ttr-post-media {
                border-radius: 8px;
                overflow: hidden;
            }
            
            /* Đánh giá khóa học */
            .review {
                display: flex;
                align-items: center;
            }
            
            .review span {
                margin-left: 5px;
                font-weight: 500;
            }
            
            body {
                font-family: 'Poppins', sans-serif;
            }
        </style>
        <!-- REVOLUTION SLIDER END -->
    </head>

    <body id="bg">
        <div class="page-wraper">
            <div id="container-xxl">
                <!-- Header Top ==== -->
                <%@include file="header.jsp" %>
                <!-- Header Top END ==== -->

                <!-- Main Slider -->
                <div class="page-content bg-white">
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
                    <div class="section-area content-inner service-info-bx">
                        <div class="container">
                            <div class="section-head text-center">
                                <h2 class="title-head">Our <span class="text-primary">Services</span></h2>
                                <p>Discover what we offer to enhance your learning experience</p>
                            </div>
                            <div class="row">
                                <div class="col-lg-4 col-md-4 col-sm-6">
                                    <div class="service-bx">
                                        <div class="action-box">
                                            <img src="assets/images/our-services/pic1.jpg" alt="">
                                            <div class="overlay-icon">
                                                <span class="fa fa-book text-white"></span>
                                            </div>
                                        </div>
                                        <div class="info-bx text-center">
                                            <div class="feature-box-sm radius bg-white">
                                                <i class="fa fa-graduation-cap text-primary"></i>
                                            </div>
                                            <h4><a href="listCourse">Learn Courses Online</a></h4>
                                            <p>Access quality courses anytime, anywhere</p>
                                            <a href="listCourse" class="btn radius-xl">View Courses</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-6">
                                    <div class="service-bx">
                                        <div class="action-box">
                                            <img src="assets/images/our-services/pic2.jpg" alt="">
                                            <div class="overlay-icon">
                                                <span class="fa fa-newspaper-o text-white"></span>
                                            </div>
                                        </div>
                                        <div class="info-bx text-center">
                                            <div class="feature-box-sm radius bg-white">
                                                <i class="fa fa-book text-primary"></i>
                                            </div>
                                            <h4><a href="listPost">Read Blogs</a></h4>
                                            <p>Explore articles and insights from experts</p>
                                            <a href="listPost" class="btn radius-xl">View Blogs</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-12">
                                    <div class="service-bx m-b0">
                                        <div class="action-box">
                                            <img src="assets/images/our-services/pic3.jpg" alt="">
                                            <div class="overlay-icon">
                                                <span class="fa fa-check-square-o text-white"></span>
                                            </div>
                                        </div>
                                        <div class="info-bx text-center">
                                            <div class="feature-box-sm radius bg-white">
                                                <i class="fa fa-file-text-o text-primary"></i>
                                            </div>
                                            <h4><a href="#">Take Quiz</a></h4>
                                            <p>Test your knowledge with interactive quizzes</p>
                                            <a href="#" class="btn radius-xl">Start Quiz</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Main Slider -->

                <div class="row">
                    <div class="col-lg-9 col-md-8 col-sm-12">
                        <!-- Popular Courses -->
                        <div class="section-area section-sp2 popular-courses-bx">
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-12 heading-bx left">
                                        <h2 class="title-head">Popular <span class="text-primary">Courses</span></h2>
                                        <p>Discover our most popular and highly-rated courses</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="courses-carousel owl-carousel owl-btn-1 col-12 p-lr0">
                                        <c:forEach items="${requestScope.mapRatingCourse}" var="cou">
                                            <div class="item">
                                                <div class="cours-bx">
                                                    <div class="action-box">
                                                        <img src="assets/images/courses/pic1.jpg" alt="">
                                                        <div class="course-overlay">
                                                            <span class="badge badge-primary">Popular</span>
                                                            <a href="course-details?id=${cou.key.courseId}" class="btn">View Details</a>
                                                        </div>
                                                    </div>
                                                    <div class="info-bx text-center">
                                                        <h5><a href="course-details?id=${cou.key.courseId}">${cou.key.courseName}</a></h5>
                                                        <div class="course-info-meta">
                                                            <span><i class="fa fa-user"></i> 245 Students</span>
                                                            <span><i class="fa fa-clock-o"></i> 15 Hours</span>
                                                        </div>
                                                    </div>
                                                    <div class="cours-more-info d-flex justify-content-between align-items-center">
                                                        <div class="review">
                                                            <div class="star-ratings">
                                                                <c:forEach begin="1" end="5" var="i">
                                                                    <c:choose>
                                                                        <c:when test="${i <= cou.value}">
                                                                            <i class="fa fa-star text-warning"></i>
                                                                        </c:when>
                                                                        <c:when test="${i - 0.5 <= cou.value}">
                                                                            <i class="fa fa-star-half-o text-warning"></i>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <i class="fa fa-star-o text-warning"></i>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:forEach>
                                                            </div>
                                                            <span class="rating-value">${cou.value}/5</span>
                                                        </div>
                                                        <div class="price">
                                                            <del class="text-muted">$${cou.key.price}</del>
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
                        
                        <script>
                            $(document).ready(function () {
                                $(".courses-carousel").owlCarousel({
                                    loop: true, // Lặp vô hạn
                                    margin: 20, // Khoảng cách giữa các item
                                    nav: true, // Hiện nút điều hướng
                                    dots: true, // Hiện chấm tròn điều hướng
                                    autoplay: true, // Tự động chạy
                                    autoplayTimeout: 5000, // Thời gian chuyển slide (ms)
                                    autoplayHoverPause: true, // Dừng khi hover
                                    responsive: {
                                        0: {
                                            items: 1  // Khi màn hình nhỏ hơn 576px, hiển thị 1 item
                                        },
                                        576: {
                                            items: 2  // Khi màn hình từ 576px đến 992px, hiển thị 2 item
                                        },
                                        992: {
                                            items: 3  // Khi màn hình lớn hơn 992px, hiển thị 3 item
                                        }
                                    }
                                });
                            });
                        </script>

                        <!-- Hot Blogs Section -->
                        <div class="section-area section-sp2">
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-12 heading-bx left text-center">
                                        <h2 class="title-head text-uppercase">Hot <span class="text-primary">Blogs</span></h2>
                                        <p>Latest articles and insights from our experts</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <c:forEach items="${requestScope.mapRatingPost}" var="post">
                                        <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                            <div class="recent-news blog-card d-flex flex-column shadow rounded overflow-hidden h-100">
                                                <!-- Ảnh bài viết -->
                                                <div class="action-box position-relative" style="height: 200px; overflow: hidden;">
                                                    <img src="assets/images/blog/latest-blog/pic1.jpg" class="img-fluid w-100 h-100"
                                                         style="object-fit: cover;" alt="Blog Image">
                                                    <span class="blog-date position-absolute bg-primary text-white px-3 py-2" 
                                                          style="top: 15px; right: 15px; border-radius: 5px;">
                                                        ${post.key.updateDate}
                                                    </span>
                                                </div>

                                                <!-- Thông tin bài viết -->
                                                <div class="info-bx flex-grow-1 d-flex flex-column p-3">
                                                    <div class="post-meta mb-2">
                                                        <span class="badge badge-info">
                                                            <i class="fa fa-folder-o"></i> ${post.key.categoryBlog.categoryBlogName}
                                                        </span>
                                                        <span class="badge badge-warning ml-2">
                                                            <i class="fa fa-star"></i> ${post.value}
                                                        </span>
                                                    </div>
                                                    
                                                    <h5 class="post-title mb-3">
                                                        <a href="post-details?id=${post.key.postId}" class="text-dark">${post.key.title}</a>
                                                    </h5>
                                                    
                                                    <div class="post-footer mt-auto d-flex justify-content-between align-items-center">
                                                        <div class="author d-flex align-items-center">
                                                            <img src="assets/images/testimonials/pic1.jpg" alt=""
                                                                 class="rounded-circle mr-2" style="width: 30px; height: 30px;">
                                                            <span class="text-primary">John Doe</span>
                                                        </div>
                                                        <a href="post-details?id=${post.key.postId}" 
                                                           class="btn btn-sm btn-outline-primary">Read More</a>
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
                                    <i class="fa fa-newspaper-o mr-2"></i> View More Blogs
                                </a>
                            </div>
                        </div>

                        <!-- Testimonials END ==== -->
                    </div>

                    <!-- Side bar-->
                    <div class="col-lg-3 col-md-4 col-sm-12">
                        <aside class="side-bar sticky-top">
                            <!-- Search Widget -->
                            <div class="widget">
                                <h6 class="widget-title">Search</h6>
                                <div class="search-bx style-1">
                                    <form role="search" method="post" action="search">
                                        <div class="input-group">
                                            <input name="text" class="form-control" placeholder="Enter your keywords..." type="text">
                                            <span class="input-group-append">
                                                <button type="submit" class="btn"><i class="fa fa-search"></i></button>
                                            </span>
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
                                                        <a href="post-details?id=${recentPost.postId}">${recentPost.title}</a>
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
                            
                            <!-- Categories Widget -->
                            <div class="widget widget_categories">
                                <h6 class="widget-title">Categories</h6>
                                <ul>
                                    <li><a href="#">Programming</a> (15)</li>
                                    <li><a href="#">Language Learning</a> (12)</li>
                                    <li><a href="#">Business</a> (18)</li>
                                    <li><a href="#">Marketing</a> (10)</li>
                                    <li><a href="#">Design</a> (6)</li>
                                </ul>
                            </div>
                            
                            <!-- Tag Cloud Widget -->
                            <div class="widget widget_tag_cloud">
                                <h6 class="widget-title">Tags</h6>
                                <div class="tagcloud">
                                    <a href="#">Design</a>
                                    <a href="#">Development</a>
                                    <a href="#">CSS</a>
                                    <a href="#">JavaScript</a>
                                    <a href="#">HTML</a>
                                    <a href="#">Java</a>
                                    <a href="#">Python</a>
                                    <a href="#">SQL</a>
                                </div>
                            </div>
                        </aside>
                    </div>
                </div>

                <!-- Call to Action Section -->
                <div class="section-area bg-primary section-sp1">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-7 col-md-6">
                                <h2 class="text-white">Ready to start your learning journey?</h2>
                                <p class="text-white">Join thousands of students who have already taken the first step!</p>
                            </div>
                            <div class="col-lg-5 col-md-6 text-right">
                                <a href="listCourse" class="btn btn-light radius-xl">Browse Courses</a>
                                <a href="login" class="btn btn-outline-light radius-xl ml-2">Sign Up Today</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer ==== -->
                <%@include file="footer.jsp" %>
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

