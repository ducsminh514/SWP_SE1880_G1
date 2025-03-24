<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!-- Footer ==== -->
<footer>
    <div class="footer-top">
		<div class="pt-exebar">
			<div class="container">
				<div class="d-flex align-items-stretch">
					<div class="pt-logo mr-auto">
						<a href="index.jsp"><img src="${pageContext.request.contextPath}/assets/images/logo-white.png" alt=""/></a>
					</div>

					<div class="pt-btn-join">
					<c:if test="${sessionScope.account==null}">
						<a href="register.jsp" class="btn ">Join Now</a>
						 </c:if>
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
									<li><a href="index.jsp">Home</a></li>
									<li><a href="about-2.jsp">About</a></li>
									<li><a href="faq-1.jsp">FAQs</a></li>
									<li><a href="contact-1.jsp">Contact</a></li>
								</ul>
							</div>
						</div>
						<div class="col-4 col-lg-4 col-md-4 col-sm-4">
							<div class="widget footer_widget">
								<h5 class="footer-title">Get In Touch</h5>
								<ul>
									<li><a href="blog-classic-grid.jsp">Blog</a></li>
									<li><a href="event.jsp">Event</a></li>
								</ul>
							</div>
						</div>
						<div class="col-4 col-lg-4 col-md-4 col-sm-4">
							<div class="widget footer_widget">
								<h5 class="footer-title">Courses</h5>
								<ul>
									<li><a href="courses.jsp">Courses</a></li>
									<li><a href="courses-details.jsp">Details</a></li>
								</ul>
							</div>
						</div>
					</div>
                </div>

            </div>
        </div>
    </div>

</footer>
<!-- Footer END ==== -->

<!-- External JavaScripts -->
<script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendors/bootstrap/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendors/magnific-popup/magnific-popup.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendors/counter/waypoints-min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendors/counter/counterup.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendors/imagesloaded/imagesloaded.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendors/masonry/masonry.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendors/masonry/filter.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendors/owl-carousel/owl.carousel.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/functions.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/contact.js"></script>
<script src='${pageContext.request.contextPath}/assets/vendors/switcher/switcher.js'></script>
</body>
</html>
