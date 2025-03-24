<!DOCTYPE html>
<html lang="en">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>
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
	.action-card {
        opacity: 1;
        transition: opacity 0.5s ease-in-out;
    }
            .popup-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                display: none;
                justify-content: center;
                align-items: center;
            }
            .popup-content {
                background: #f8f1e7;
                padding: 20px;
                border-radius: 10px;
                width: 400px;
            }
            .filter-btn-container {
                position: absolute;
                top: 10px;
                right: 10px;
            }
            .btn-change-avatar {
                display: block;
                margin: 10px auto; /* Căn giữa theo chiều ngang */
                background-color: #ff9800;
                color: white;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
                font-size: 14px;
                border-radius: 5px;
            }

            .btn-change-avatar:hover {
                background-color: #e68900;
            }

            }

        </style>

    <jsp:include page="header.jsp" />
    <!-- header END ==== -->
    <!-- Content -->
    <div class="page-content bg-white">
        <!-- inner page banner -->
        <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner1.jpg);">
            <div class="container">
                <div class="page-banner-entry">
                    <h1 class="text-white">Profile</h1>
				 </div>
            </div>
        </div>
        <%
            String id = request.getParameter("id");
            if (id == null) {
                id = (String) session.getAttribute("id");
            }
        %>
		<!-- Breadcrumb row -->
		<div class="breadcrumb-row">
			<div class="container">
				<ul class="list-inline">
					<li><a href="#">Home</a></li>
					<li>Profile</li>
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
							<div class="profile-bx text-center">
								<div class="user-profile-thumb">
									<img src="${user.avatar}" alt=""/>
								</div>


								<div class="profile-info">
									<h4>${user.lastName}</h4>
									<span>${user.email}</span>

								</div>

								<div class="profile-tabnav">
									<ul class="nav nav-tabs">
										<li class="nav-item">
											<a class="nav-link active" data-toggle="tab" href="#courses"><i class="ti-book"></i>Courses</a>
										</li>
										<li class="nav-item">
											<a class="nav-link" data-toggle="tab" href="#quiz-results"><i class="ti-bookmark-alt"></i>Quiz Results </a>
										</li>
										<li class="nav-item">
											<a class="nav-link" data-toggle="tab" href="#edit-profile"><i class="ti-pencil-alt"></i>Edit Profile</a>
										</li>

									</ul>
								</div>
							</div>
						</div>
						<c:set var="coursesPerPage" value="${param.coursesPerPage ne null ? param.coursesPerPage : 4}" />
                        <c:set var="totalCourses" value="${fn:length(requestScope.courses)}" />
                        <c:set var="totalPages" value="${(totalCourses/coursesPerPage) + (totalCourses%coursesPerPage > 0 ? 1 : 0)}" />
                        <c:set var="currentPage" value="${param.page ne null ? param.page : 1}" />

                        <%-- Tính toán vị trí bắt đầu và kết thúc cho mỗi trang --%>
                        <c:set var="startIndex" value="${(currentPage - 1) * coursesPerPage}" />
                        <c:set var="endIndex" value="${startIndex + coursesPerPage}" />
                        <c:set var="endIndex" value="${endIndex > totalCourses ? totalCourses : endIndex}" />
						<div class="col-lg-9 col-md-8 col-sm-12 m-b30">
							<div class="profile-content-bx">
								<div class="tab-content">
									                                   <div class="tab-pane active" id="courses">
                                                                            <div class="profile-head">
                                                                                <h3>My Courses</h3>
                                                                                <div class="feature-filters style1 ml-auto">
                                                                                <button class="btn btn-primary" id="filter-btn">Filter</button>
                                                                                </div>
                                                                            </div>
                                                                            <div class="courses-filter">
                                                                                <div class="clearfix">
                                                                                    <ul id="masonry" class="ttr-gallery-listing magnific-image row">
                                                                                        <c:forEach items="${requestScope.courses}" var="c">
                                                                                            <li class="action-card col-xl-4 col-lg-6 col-md-12 col-sm-6 publish"
                                                                                                    >
                                                                                                <div class="cours-bx">
                                                                                                    <div class="action-box">
                                                                                                        <img src="assets/images/courses/pic3.jpg" alt="">
                                                                                                        <a href="course-learning?courseId=${c.courseId}" class="btn">Read More</a>
                                                                                                    </div>
                                                                                                    <div class="info-bx text-center">
                                                                                                        <h5><a href="#">${c.courseType.courseTypeName}</a></h5>
                                                                                                        <h6>${c.title}</h6>
                                                                                                        <span>${c.description}</span>

                                                                                                    </div>
                                                                                                    <div class="cours-more-info">
                                                                                                        <div class="review">
                                                                                                            <c:forEach var="i" items="${requestScope.enrollList}">
                                                                                                                <c:if test="${c.courseId == i.course.courseId}">
                                                                                                                <span>Enroll Date</span>
                                                                                                                <h5>${i.enrollDate}</h5>
                                                                                                                </c:if>
                                                                                                            </c:forEach>
                                                                                                        </div>
                                                                                                        <div class="price">
                                                                                                            <c:forEach var="i" items="${requestScope.enrollList}">
                                                                                                                <c:if test="${c.courseId == i.course.courseId}">
                                                                                                                 <span>Progress</span>
                                                                                                                 <h5>${i.processPercentage}</h5>
                                                                                                                </c:if>
                                                                                                            </c:forEach>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </li>
                                                                                        </c:forEach>
                                                                                    </ul>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                         <div class="popup-overlay" id="popup">
                                                                                <div class="popup-content">
                                                                                    <h5>Display Properties</h5>
                                                                                    <form>
                                                                                        <div class="form-check">
                                                                                         <input class="form-check-input" type="checkbox" name="display" id="courseTypeName">
                                                                                         <label class="form-check-label" for="courseTypeName">Course Type Name</label>
                                                                                         </div>
                                                                                         <div class="form-check">
                                                                                         <input class="form-check-input" type="checkbox" name="display" id="title">
                                                                                         <label class="form-check-label" for="title">title</label>
                                                                                         </div>
                                                                                         <div class="form-check">
                                                                                         <input class="form-check-input" type="checkbox" name="display" id="description">
                                                                                         <label class="form-check-label" for="description">Description</label>
                                                                                         </div>
                                                                                          <div class="form-check">
                                                                                          <input class="form-check-input" type="checkbox" name="display" id="enrollDate">
                                                                                          <label class="form-check-label" for="enrollDate">Enroll Date</label>
                                                                                          </div>
                                                                                          <div class="form-check">
                                                                                          <input class="form-check-input" type="checkbox" name="display" id="processPercentage">
                                                                                          <label class="form-check-label" for="processPercentage">processPercentage</label>
                                                                                          </div>
                                                                                        <hr>
                                                                                        <h5>Display Progress</h5>
                                                                                       <div class="form-check">
                                                                                           <input class="form-check-input" type="checkbox" name="progress" id="pending">
                                                                                           <label class="form-check-label" for="pending">Pending</label>
                                                                                       </div>
                                                                                       <div class="form-check">
                                                                                           <input class="form-check-input" type="checkbox" name="progress" id="done">
                                                                                           <label class="form-check-label" for="done">Done</label>
                                                                                       </div>
                                                                                       <div class="form-check">
                                                                                           <input class="form-check-input" type="checkbox" name="progress" id="not-yet">
                                                                                           <label class="form-check-label" for="not-yet">Not Yet</label>
                                                                                       </div>


                                                                                        <hr>

                                                                                        <label for="courses-per-page">Number of Courses per Page</label>
                                                                                        <input type="number" class="form-control" id="courses-per-page" min="1" max="100" value="4">
                                                                                        <div class="mt-3 text-end">
                                                                                            <button type="button" class="btn btn-secondary" id="close-btn">Close</button>
                                                                                            <button type="submit" class="btn btn-primary">Apply</button>
                                                                                        </div>
                                                                                    </form>
                                                                                </div>
                                                                            </div>
									<div class="tab-pane" id="quiz-results">
										<div class="profile-head">
											<h3>Quiz Results</h3>
										</div>
										<div class="courses-filter">
											<div class="row">
												<div class="col-md-6 col-lg-6">
													<ul class="course-features">
														<li><i class="ti-book"></i> <span class="label">Lectures</span> <span class="value">8</span></li>
														<li><i class="ti-help-alt"></i> <span class="label">Quizzes</span> <span class="value">1</span></li>
														<li><i class="ti-time"></i> <span class="label">Duration</span> <span class="value">60 hours</span></li>
														<li><i class="ti-stats-up"></i> <span class="label">Skill level</span> <span class="value">Beginner</span></li>
														<li><i class="ti-smallcap"></i> <span class="label">Language</span> <span class="value">English</span></li>
														<li><i class="ti-user"></i> <span class="label">Students</span> <span class="value">32</span></li>
														<li><i class="ti-check-box"></i> <span class="label">Assessments</span> <span class="value">Yes</span></li>
													</ul>
												</div>
												<div class="col-md-6 col-lg-6">
													<ul class="course-features">
														<li><i class="ti-book"></i> <span class="label">Lectures</span> <span class="value">8</span></li>
														<li><i class="ti-help-alt"></i> <span class="label">Quizzes</span> <span class="value">1</span></li>
														<li><i class="ti-time"></i> <span class="label">Duration</span> <span class="value">60 hours</span></li>
														<li><i class="ti-stats-up"></i> <span class="label">Skill level</span> <span class="value">Beginner</span></li>
														<li><i class="ti-smallcap"></i> <span class="label">Language</span> <span class="value">English</span></li>
														<li><i class="ti-user"></i> <span class="label">Students</span> <span class="value">32</span></li>
														<li><i class="ti-check-box"></i> <span class="label">Assessments</span> <span class="value">Yes</span></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
									<div class="tab-pane" id="edit-profile">
										<div class="profile-head">
                            <h3>Profile</h3>
										</div>
                                            <form class="edit-profile" action="profile" method="post">
                                             <c:set value="${requestScope.user}" var="a" />
											<div class="">
											    <div class="form-group row">
                                                    <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">User Name</label>
                                                	<div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                	<input type="hidden" name="id" value="${a.userId}">
                                                	<input type="hidden" name="id" value="<%= id %>">
                                                		<input class="form-control" type="text" value="${a.userName}"name="userName">
                                                	</div>
                                                </div>


												<div class="form-group row">
													<label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">First Name</label>
													<div class="col-12 col-sm-9 col-md-9 col-lg-7">
													<input type="hidden" name="id" value="${a.userId}">
														<input class="form-control" type="text" value="${a.firstName}"name= "firstName">
													</div>
												</div>
                                                <div class="form-group row">
													<label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Last Name</label>
													<div class="col-12 col-sm-9 col-md-9 col-lg-7">
														<input class="form-control" type="text" value="${a.lastName}"name="lastName">
													</div>
												</div>
												<div class="form-group row">
													<label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Email</label>
													<div class="col-12 col-sm-9 col-md-9 col-lg-7">
														<input class="form-control" type="text" value="${a.email}"name="email" readonly>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Phone Number</label>
													<div class="col-12 col-sm-9 col-md-9 col-lg-7">
														<input class="form-control" type="text" value="${a.phoneNumber}"name="phoneNumber">
													</div>
												</div>

												
												<div class="seperator"></div>

												<div class="form-group row">
													<label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Gender</label>
													<div class="col-12 col-sm-9 col-md-9 col-lg-7">
														<input class="form-control" type="text" value="${a.gender}"name="gender">
													</div>
												</div>
												<div class="form-group row">
                                                	<label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Avatar</label>
                                                	<div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                	<input class="form-control" type="text" value="${a.avatar}"name="avatar">
                                                	</div>
                                                	</div>
											</div>
											<div class="">
												<div class="">
													<div class="row">
														<div class="col-12 col-sm-3 col-md-3 col-lg-2">
														</div>
														 <h5 style="color: green">${requestScope.message}</h5>
														  <h5 style="color: red">${requestScope.error}</h5>
														<div class="col-12 col-sm-9 col-md-9 col-lg-7">
															<button type="submit" class="btn">Save changes</button>
															<button type="reset" class="btn-secondry">Cancel</button>
														</div>
														<h5 style="color: green">${sessionScope.message}</h5>
                                                        <h5 style="color: red">${sessionScope.error}</h5>
													</div>

												</div>
											</div>
										</form>
									</div>

								</div> 
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
   <jsp:include page="footer.jsp" />
    <button class="back-to-top fa fa-chevron-up" ></button>
</div>

 <script>

     document.addEventListener("DOMContentLoaded", function () {
         const filterBtn = document.getElementById("filter-btn");
         const popup = document.getElementById("popup");
         const closeBtn = document.getElementById("close-btn");
         const form = popup.querySelector("form");
         const coursesList = document.querySelectorAll("#masonry .action-card");
         const coursesPerPageInput = document.getElementById("courses-per-page");
         const paginationContainer = document.createElement("div");
         paginationContainer.className = "pagination";
         document.querySelector(".courses-filter").appendChild(paginationContainer);

         let coursesPerPage = parseInt(coursesPerPageInput.value);
         let currentPage = 1;

         filterBtn.addEventListener("click", function () {
             popup.style.display = "block";
         });

         closeBtn.addEventListener("click", function () {
             popup.style.display = "none";
         });

         form.addEventListener("change", function () {
             const showCourseType = document.getElementById("courseTypeName").checked;
             const showDescription = document.getElementById("description").checked;
             const showEnrollDate = document.getElementById("enrollDate").checked;
             const showProcessPercentage = document.getElementById("processPercentage").checked;
             const showTitle = document.getElementById("title").checked;
             const showPending = document.getElementById("pending").checked;
             const showDone = document.getElementById("done").checked;
             const showNotYet = document.getElementById("not-yet").checked;

             coursesList.forEach(course => {
                 const progressElement = course.querySelector(".price h5");
                 const progressText = progressElement.textContent.trim(); // Assuming progress is stored as text like 'Done', 'Pending', etc.

                 let showCourse = false;

                 // Apply progress filter
                 if (showPending && progressText === "Pending") {
                     showCourse = true;
                 }
                 if (showDone && progressText === "Done") {
                     showCourse = true;
                 }
                 if (showNotYet && progressText === "Not yet") {
                     showCourse = true;
                 }

                 // Control display of other course information
                 course.querySelector(".info-bx h5").style.display = showCourseType ? "block" : "none";
                 course.querySelector(".info-bx span").style.display = showDescription ? "block" : "none";
                 course.querySelector(".review h5").style.display = showEnrollDate ? "block" : "none";
                 course.querySelector(".price h5").style.display = showProcessPercentage ? "block" : "none";
                 course.querySelector(".info-bx h6").style.display = showTitle ? "block" : "none";

                 // Show or hide course based on progress filter
                 course.style.display = showCourse ? "block" : "none";
             });
         });

         form.addEventListener("submit", function (e) {
             e.preventDefault();
             coursesPerPage = parseInt(coursesPerPageInput.value);
             currentPage = 1;
             updatePagination();
             popup.style.display = "none";
         });

         function updatePagination() {
             const totalCourses = coursesList.length;
             const totalPages = Math.ceil(totalCourses / coursesPerPage);
             paginationContainer.innerHTML = "";

             for (let i = 1; i <= totalPages; i++) {
                 const pageBtn = document.createElement("button");
                 pageBtn.textContent = i;
                 pageBtn.className = "page-btn";
                 if (i === currentPage) pageBtn.classList.add("active");
                 pageBtn.addEventListener("click", function () {
                     currentPage = i;
                     updateCourseVisibility();
                     updatePagination();
                 });
                 paginationContainer.appendChild(pageBtn);
             }

             updateCourseVisibility();
         }

         function updateCourseVisibility() {
             // Smooth transition effect
             document.querySelectorAll(".action-card").forEach(card => {
                 card.style.transition = "opacity 0.5s ease-in-out";
             });

             coursesList.forEach((course, index) => {
                 const start = (currentPage - 1) * coursesPerPage;
                 const end = start + coursesPerPage;
                 course.style.display = index >= start && index < end ? "block" : "none";
                 course.style.opacity = index >= start && index < end ? 1 : 0;
             });
         }

         updatePagination();
     });

    </script>

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
