<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script>

    document.addEventListener("DOMContentLoaded", function () {
     function removeDiacritics(str) {
                // Chuyển đổi các ký tự có dấu thành không dấu
                return str.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
            }
        function generateUsername() {
            let firstName = document.querySelector('input[name="firstName"]').value.trim();
            let lastName = document.querySelector('input[name="lastName"]').value.trim();
            let nameField = document.querySelector('input[name="name"]');

            firstName = removeDiacritics(firstName).replace(/\s+/g, '');
                        lastName = removeDiacritics(lastName).replace(/\s+/g, '');

                        // Kiểm tra và tạo username theo format lastName + firstName + 4 số random
                        if (firstName && lastName && !nameField.dataset.edited) {
                            let randomNumber = Math.floor(1000 + Math.random() * 9000); // 4 số ngẫu nhiên
                            nameField.value = lastName.toLowerCase() + firstName.toLowerCase() + randomNumber;
                        }
        }

        document.querySelector('input[name="firstName"]').addEventListener('input', generateUsername);
        document.querySelector('input[name="lastName"]').addEventListener('input', generateUsername);
        document.querySelector('input[name="name"]').addEventListener('input', function() {
            this.dataset.edited = true;
        });
    });
</script>
</head>
<body id="bg">
<div class="page-wraper">
	<div id="loading-icon-bx"></div>
	<div class="account-form">
		<div class="account-head" style="background-image:url(assets/images/background/bg-3.jpg);">
			<a href="index.jsp"><img src="assets/images/logo-white-2.png" alt=""></a>
		</div>
		<div class="account-form-inner">
			<div class="account-container">
				<div class="heading-bx left">
					<h2 class="title-head">Sign Up <span>Now</span></h2>
					<p>Login Your Account <a href="login.jsp">Click here</a></p>
				</div>	
				<form class="contact-bx" method="post" action= "register">
					<div class="row placeani">

                        <div class="col-lg-12">
							<div class="form-group row">
                                <div class="col-md-6">
                                    <div class="input-group">
                                    <label>Your First Name</label>
                                    <input name="firstName" type="text" required class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="input-group">
                                    <label>Your Last Name</label>
                                    <input name="lastName" type="text" required class="form-control">
                                    </div>
                                </div>
                            </div>
						</div>
						<div class="col-lg-12">
                        	<div class="form-group">
                        		<div class="input-group">
                        			<label>Username </label>
                        			<input name="name" type="text" required="" class="form-control">
                        		</div>
                        	</div>
                        </div>
                        <div class="col-lg-12">
							<div class="form-group">
								<div class="input-group">
									<label>Your Phone Number</label>
									<input name="phoneNumber" type="text" required="" class="form-control">
								</div>
							</div>
						</div>
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="gender">Your Gender</label>
                                <select name="gender" id="gender" class="form-control" required>
                                    <option value="-1" disabled selected>Select your gender</option>
                                    <option value="male">Male</option>
                                    <option value="female">Female</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-12">
							<div class="form-group">
                                 <label for="age">Your Age</label>
                                 <select name="age" id="age" class="form-control" required onchange="this.style.color = 'black'">
                                    <option value="-1" disabled selected style="color: gray;">Select your age</option>
                                      <script>
                                            let ageSelect = document.getElementById("age");
                                            for (let i = 18; i <= 99; i++) {
                                                let option = document.createElement("option");
                                                option.value = i;
                                                option.textContent = i;
                                                ageSelect.appendChild(option);
                                            }
                                      </script>
                                 </select>
                            </div>
						</div>
						<div class="col-lg-12">
							<div class="form-group">
								<div class="input-group">
									<label>Your Email Address</label>
									<input name="email" type="email" required="" class="form-control">
								</div>
							</div>
						</div>
						<div class="col-lg-12">
							<div class="form-group">
								<div class="input-group"> 
									<label>Your Password</label>
									<input name="password" type="password" class="form-control" required="">
								</div>
							</div>
						</div>
						<div class="col-lg-12">
							<div class="form-group">
								<div class="input-group">
									<label>Confirm Password</label>
									<input name="confirmPassword" type="password" class="form-control" required="">
								</div>
							</div>
						</div>
						<h5 style="color: red">${requestScope.error}</h5>
						<h5 style="color: green">${requestScope.notication}</h5>
						<div class="col-lg-12 m-b30">
							<button name="submit" type="submit" value="Submit" class="btn button-md">Sign Up</button>
						</div>

					</div>
				</form>
			</div>
		</div>
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
</body>

</html>
