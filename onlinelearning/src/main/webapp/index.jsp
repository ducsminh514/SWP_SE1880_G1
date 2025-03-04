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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <!-- REVOLUTION SLIDER CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/layers.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/settings.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/navigation.css">
        <style>
            aside.side-bar {
                margin-top: 100px; /* Điều chỉnh số px để phù hợp */
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
                            <div class="row">
                                <div class="col-lg-4 col-md-4 col-sm-6">
                                    <div class="service-bx">
                                        <div class="action-box">
                                            <img src="assets/images/our-services/pic1.jpg" alt="">
                                        </div>
                                        <div class="info-bx text-center">
                                            <div class="feature-box-sm radius bg-white">
                                                <i class="fa fa-bank text-primary"></i>
                                            </div>
                                            <h4><a href="#">Learn Course Online</a></h4>
                                            <a href="#" class="btn radius-xl">View More</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-6">
                                    <div class="service-bx">
                                        <div class="action-box">
                                            <img src="assets/images/our-services/pic2.jpg" alt="">
                                        </div>
                                        <div class="info-bx text-center">
                                            <div class="feature-box-sm radius bg-white">
                                                <i class="fa fa-book text-primary"></i>
                                            </div>
                                            <h4><a href="#">Read Blogs</a></h4>
                                            <a href="#" class="btn radius-xl">View More</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-12">
                                    <div class="service-bx m-b0">
                                        <div class="action-box">
                                            <img src="assets/images/our-services/pic3.jpg" alt="">
                                        </div>
                                        <div class="info-bx text-center">
                                            <div class="feature-box-sm radius bg-white">
                                                <i class="fa fa-file-text-o text-primary"></i>
                                            </div>
                                            <h4><a href="#">Take Quiz</a></h4>
                                            <a href="#" class="btn radius-xl">View More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Main Slider -->

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
                                                            <img src="assets\images\courses\pic1.jpg" alt="">
                                                            <a href="#" class="btn">Read More</a>
                                                        </div>
                                                        <div class="info-bx text-center">
                                                            <h5><a href="#">${cou.key.courseName}</a></h5>
                                                        </div>
                                                        <div class="cours-more-info">
                                                            <div class="review">
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
                            <script>
                                $(document).ready(function () {
                                    $(".courses-carousel").owlCarousel({
                                        loop: true, // Lặp vô hạn
                                        margin: 5, // Khoảng cách giữa các item
                                        nav: true, // Hiện nút điều hướng
                                        dots: true, // Hiện chấm tròn điều hướng
                                        autoplay: true, // Tự động chạy
                                        autoplayTimeout: 5000, // Thời gian chuyển slide (ms)
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

