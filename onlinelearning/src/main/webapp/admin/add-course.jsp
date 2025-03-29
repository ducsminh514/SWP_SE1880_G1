<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.png" type="image/x-icon" />
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/favicon.png" />
    
    <!-- PAGE TITLE HERE ============================================= -->
    <title>Add New Course - Online Learning Platform</title>
    
    <!-- MOBILE SPECIFIC ============================================= -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!--[if lt IE 9]>
    <script src="${pageContext.request.contextPath}/assets/js/html5shiv.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/respond.min.js"></script>
    <![endif]-->
    
    <!-- All PLUGINS CSS ============================================= -->
    <jsp:include page="../common/common_admin_css.jsp"></jsp:include>
    
    <style>
        .thumbnail-preview {
            width: 200px;
            height: 120px;
            margin-top: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        
        .thumbnail-preview img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
        }
        
        .ck-editor__editable {
            min-height: 250px;
        }
    </style>
</head>
<body class="ttr-opened-sidebar ttr-pinned-sidebar">
    
    <!-- header start -->
    <jsp:include page="../common/common_admin_header.jsp"></jsp:include>
    <!-- header end -->

    <!-- Left sidebar menu start -->
    <jsp:include page="../common/common_admin_sidebar_menu.jsp"></jsp:include>
    <!-- Left sidebar menu end -->

    <!--Main container start -->
    <main class="ttr-wrapper">
        <div class="container-fluid">
            <div class="db-breadcrumb">
                <h4 class="breadcrumb-title">Add New Course</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="${pageContext.request.contextPath}/admin-dashboard"><i class="fa fa-home"></i>Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/subject">Course Management</a></li>
                    <li>Add New Course</li>
                </ul>
            </div>  
            
            <div class="row">
                <div class="col-lg-12 m-b30">
                    <div class="widget-box">
                        <div class="wc-title">
                            <h4>Course Information</h4>
                        </div>
                        <div class="widget-inner">
                            <form id="courseForm" action="${pageContext.request.contextPath}/admin/add-course" method="post" enctype="multipart/form-data">
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger" role="alert">
                                        ${errorMessage}
                                    </div>
                                </c:if>
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success" role="alert">
                                        ${successMessage}
                                    </div>
                                </c:if>
                                
                                <div class="row">
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-group">
                                            <label for="courseName">Course Name <span class="text-danger">*</span></label>
                                            <input name="courseName" id="courseName" class="form-control" type="text" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-group">
                                            <label for="title">Course Title <span class="text-danger">*</span></label>
                                            <input name="title" id="title" class="form-control" type="text" required>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-group">
                                            <label for="courseType">Course Category <span class="text-danger">*</span></label>
                                            <select name="courseType" id="courseType" class="form-control" required>
                                                <option value="">Select Category</option>
                                                <c:forEach items="${courseTypes}" var="type">
                                                    <option value="${type.courseTypeId}">${type.courseTypeName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-group">
                                            <label for="expert">Instructor <span class="text-danger">*</span></label>
                                            <select name="expert" id="expert" class="form-control" required>
                                                <option value="">Select Instructor</option>
                                                <c:forEach items="${experts}" var="expert">
                                                    <option value="${expert.expertId}">${expert.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-group">
                                            <label for="price">Price <span class="text-danger">*</span></label>
                                            <input name="price" id="price" class="form-control" type="number" step="0.01" min="0" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-group">
                                            <label for="level">Skill Level <span class="text-danger">*</span></label>
                                            <select name="level" id="level" class="form-control" required>
                                                <option value="">Select Level</option>
                                                <option value="Beginner">Beginner</option>
                                                <option value="Intermediate">Intermediate</option>
                                                <option value="Advanced">Advanced</option>
                                                <option value="All Levels">All Levels</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label for="thumbnail">Thumbnail Image <span class="text-danger">*</span></label>
                                            <input type="file" name="thumbnail" id="thumbnail" class="form-control" accept="image/*" onchange="previewThumbnail(event)" required>
                                            <div class="thumbnail-preview" id="thumbnailPreview">
                                                <span>No image selected</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label for="status">Status <span class="text-danger">*</span></label>
                                            <select name="status" id="status" class="form-control" required>
                                                <option value="true">Active</option>
                                                <option value="false">Draft</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label for="description">Course Description <span class="text-danger">*</span></label>
                                            <textarea name="description" id="description" class="form-control" rows="6" required></textarea>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-lg-12 m-t20">
                                        <div class="d-flex justify-content-between">
                                            <button type="button" class="btn-secondry" onclick="window.location.href='${pageContext.request.contextPath}/admin/subject'">Cancel</button>
                                            <button type="submit" class="btn">Save Course</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <div class="ttr-overlay"></div>

    <!-- External JavaScripts -->
    <jsp:include page="../common/common_admin_js.jsp"></jsp:include>
    
    <!-- CKEditor -->
    <script src="https://cdn.ckeditor.com/ckeditor5/35.3.0/classic/ckeditor.js"></script>
    
    <script>
        // Initialize CKEditor for description
        ClassicEditor
            .create(document.querySelector('#description'))
            .catch(error => {
                console.error(error);
            });
            
        // Preview thumbnail image
        function previewThumbnail(event) {
            const preview = document.getElementById('thumbnailPreview');
            preview.innerHTML = '';
            
            if (event.target.files && event.target.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    preview.appendChild(img);
                }
                reader.readAsDataURL(event.target.files[0]);
            } else {
                preview.innerHTML = '<span>No image selected</span>';
            }
        }
        
        // Form validation
        document.getElementById('courseForm').addEventListener('submit', function(event) {
            const requiredFields = document.querySelectorAll('[required]');
            let valid = true;
            
            requiredFields.forEach(function(field) {
                if (!field.value.trim()) {
                    field.classList.add('is-invalid');
                    valid = false;
                } else {
                    field.classList.remove('is-invalid');
                }
            });
            
            if (!valid) {
                event.preventDefault();
                alert('Please fill all required fields.');
            }
        });
    </script>
</body>
</html> 