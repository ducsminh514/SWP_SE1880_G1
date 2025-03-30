<%-- Created by IntelliJ IDEA. User: PC Date: 3/9/2025 Time: 11:42 PM To change this template use File | Settings | File
  Templates. --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>

<head>
    <!-- META ============================================= -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="keywords" content=""/>
    <meta name="author" content=""/>
    <meta name="robots" content=""/>
    <!-- DESCRIPTION -->
    <meta name="description" content="EduChamp : Education HTML Template"/>
    <!-- OG -->
    <meta property="og:title" content="EduChamp : Education HTML Template"/>
    <meta property="og:description" content="EduChamp : Education HTML Template"/>
    <meta property="og:image" content=""/>
    <meta name="format-detection" content="telephone=no">
    <!-- PAGE TITLE HERE ============================================= -->
    <title>English Learning System - Edit Question</title>

    <!-- MOBILE SPECIFIC ============================================= -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- All PLUGINS CSS ============================================= -->
    <jsp:include page="../common/common_admin_css.jsp"></jsp:include>

    <style>
        .form-group {
            margin-bottom: 20px;
        }

        .form-control {
            border-radius: 4px;
        }

        .btn-action {
            margin-right: 10px;
        }

        .image-preview {
            height: 200px;
            border: 2px dashed #ddd;
            border-radius: 5px;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            margin-bottom: 10px;
        }

        .image-preview img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }

        .option-row {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .option-label {
            width: 80px;
            font-weight: bold;
        }

        .option-input {
            flex-grow: 1;
            margin-right: 10px;
        }

        .delete-btn {
            background-color: #ff4d4d;
            color: white;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }

        .add-btn {
            background-color: #ffc107;
            color: white;
            border: none;
            border-radius: 20px;
            padding: 5px 15px;
            cursor: pointer;
            margin-top: 10px;
        }

        .position-relative {
            position: relative;
        }

        .position-absolute {
            position: absolute;
        }

        .no-image-text {
            color: #6c757d;
        }

        .delete-image, .delete-new-image, .delete-audio {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 30px;
            height: 30px;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .audio-container {
            min-height: 100px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 15px;
        }
        
        .image-item {
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            position: relative;
        }
        
        .image-title {
            margin-top: 10px;
            font-weight: bold;
        }
        
        .existing-images-container {
            margin-bottom: 20px;
        }
        
        .new-image-container {
            margin-top: 20px;
        }
        
        #audioPlaceholder {
            background-color: #f8f9fa;
            border-radius: 5px;
            padding: 20px;
        }
        
        .preview-container {
            margin-top: 10px;
        }

        /* Style mới cho phần option */
        .options-container {
            margin-top: 20px;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 20px;
            background-color: #f8f9fa;
        }
        
        .options-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            border-bottom: 2px solid #dee2e6;
            padding-bottom: 10px;
        }
        
        .options-title {
            font-size: 18px;
            font-weight: bold;
            color: #495057;
        }
        
        .option-row {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            background-color: white;
            border-radius: 6px;
            padding: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }
        
        .option-row:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        .option-label {
            width: 80px;
            font-weight: bold;
            color: #495057;
            background-color: #e9ecef;
            padding: 8px 12px;
            border-radius: 4px;
            margin-right: 10px;
            text-align: center;
        }
        
        .option-input {
            flex-grow: 1;
            margin-right: 15px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 8px 12px;
        }
        
        .option-correct {
            display: flex;
            align-items: center;
            margin-right: 15px;
            font-weight: 500;
            color: #495057;
        }
        
        .option-correct input[type="checkbox"] {
            width: 18px;
            height: 18px;
            margin-right: 8px;
        }
        
        .delete-btn {
            background-color: #ff4d4d;
            color: white;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .delete-btn:hover {
            background-color: #ff3333;
            transform: scale(1.1);
        }
        
        .add-option-btn {
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 8px 16px;
            font-weight: 500;
            display: flex;
            align-items: center;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-top: 10px;
        }
        
        .add-option-btn i {
            margin-right: 8px;
        }
        
        .add-option-btn:hover {
            background-color: #218838;
        }
        
        .correct-label {
            font-weight: 500;
            color: #28a745;
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
            <h4 class="breadcrumb-title">Chỉnh sửa câu hỏi</h4>
            <ul class="db-breadcrumb-list">
                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                <li><a href="${pageContext.request.contextPath}/manage-question">Quản lý Câu hỏi</a></li>
                <li>Chỉnh sửa câu hỏi #${question.questionId}</li>
            </ul>
        </div>
        <div class="row">
            <!-- Your Profile Views Chart -->
            <div class="col-lg-12 m-b30">
                <div class="widget-box">
                    <div class="wc-title">
                        <h4>Chỉnh sửa câu hỏi #${question.questionId}</h4>
                    </div>
                    <div class="widget-inner">
                        <form class="edit-profile m-b30" action="${pageContext.request.contextPath}/manage-question" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="questionId" value="${question.questionId}">
                            
                            <div class="row">
                                <div class="col-12">
                                    <div class="ml-auto">
                                        <h3>Thông tin câu hỏi</h3>
                                    </div>
                                </div>
                                
                                <!-- Nội dung câu hỏi -->
                                <div class="form-group col-12">
                                    <label class="col-form-label">Nội dung câu hỏi</label>
                                    <div>
                                        <textarea class="form-control" name="content" rows="4">${question.content}</textarea>
                                    </div>
                                </div>
                                
                                <!-- Loại câu hỏi -->
                                <div class="form-group col-md-6">
                                    <label class="col-form-label">Loại câu hỏi</label>
                                    <div>
                                        <select class="form-control" id="questionType" name="questionType">
                                            <c:forEach items="${questionTypes}" var="type">
                                                <option value="${type.questionTypeId}" ${question.questionType.questionTypeId == type.questionTypeId ? 'selected' : ''}>${type.questionTypeName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- Môn học -->
                                <div class="form-group col-md-6">
                                    <label class="col-form-label">Môn học</label>
                                    <div>
                                        <select class="form-control" name="subject">
                                            <c:forEach items="${subjectList}" var="subject">
                                                <option value="${subject.subjectId}" ${question.subject.subjectId == subject.subjectId ? 'selected' : ''}>${subject.subjectName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- Cấp độ -->
                                <div class="form-group col-md-4">
                                    <label class="col-form-label">Cấp độ</label>
                                    <div>
                                        <select class="form-control" name="level">
                                            <option value="1" ${question.level == 1 ? 'selected' : ''}>Dễ</option>
                                            <option value="2" ${question.level == 2 ? 'selected' : ''}>Trung bình</option>
                                            <option value="3" ${question.level == 3 ? 'selected' : ''}>Khó</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- Điểm -->
                                <div class="form-group col-md-4">
                                    <label class="col-form-label">Điểm</label>
                                    <div>
                                        <input class="form-control" type="number" name="mark" value="${question.mark}" min="1" max="10">
                                    </div>
                                </div>
                                
                                <!-- Trạng thái -->
                                <div class="form-group col-md-4">
                                    <label class="col-form-label">Trạng thái</label>
                                    <div>
                                        <select class="form-control" name="status">
                                            <option value="true" ${question.status ? 'selected' : ''}>Kích hoạt</option>
                                            <option value="false" ${!question.status ? 'selected' : ''}>Vô hiệu hóa</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- Audio -->
                                <div class="form-group col-12">
                                    <label class="col-form-label">Audio (MP3)</label>
                                    <div class="audio-container position-relative">
                                        <c:if test="${not empty question.mp3}">
                                            <audio controls class="w-100 existing-audio">
                                                <source src="${pageContext.request.contextPath}/uploads/audio/${question.mp3}" type="audio/mpeg">
                                                Your browser does not support the audio element.
                                            </audio>
                                            <button type="button" class="btn btn-danger delete-audio">
                                                <i class="fa fa-times"></i>
                                            </button>
                                        </c:if>
                                        <div id="audioPlaceholder" class="text-center py-3" 
                                             style="${empty question.mp3 ? '' : 'display: none;'}">
                                            <span>Không có audio</span>
                                        </div>
                                        <div id="audioPreview" style="display: none;" class="mt-3">
                                            <audio controls class="w-100">
                                                <source id="newAudioPlayer" src="" type="audio/mpeg">
                                                Your browser does not support the audio element.
                                            </audio>
                                        </div>
                                        <div class="mt-3">
                                            <input type="file" class="form-control-file" id="audioUpload" name="audioFile" accept="audio/mpeg">
                                            <input type="hidden" name="currentAudio" value="${question.mp3}">
                                            <input type="hidden" name="deleteAudio" id="deleteAudio" value="false">
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Hình ảnh hiện tại -->
                                <div class="col-12 mt-4">
                                    <h4>Hình ảnh hiện tại</h4>
                                    <div class="row">
                                        <c:forEach items="${questionImages}" var="image">
                                            <div class="col-md-4 image-item">
                                                <div class="card mb-3">
                                                    <div class="card-body">
                                                        <input type="hidden" name="imageId" value="${image.imageId}">
                                                        <input type="hidden" class="delete-image-flag" name="deleteImage" value="false">
                                                        
                                                        <div class="image-preview">
                                                            <c:choose>
                                                                <c:when test="${not empty image.imageURL}">
                                                                    <img src="${pageContext.request.contextPath}${image.imageURL}" class="preview-image" alt="${image.imageTitle}">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="${pageContext.request.contextPath}/uploads/images/${image.imageTitle}" class="preview-image" alt="${image.imageTitle}">
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        
                                                        <div class="form-group">
                                                            <label>Tiêu đề ảnh</label>
                                                            <input type="text" class="form-control" value="${image.imageTitle}" readonly>
                                                        </div>
                                                        
                                                        <button type="button" class="btn btn-danger delete-image">
                                                            <i class="fa fa-trash"></i> Xóa ảnh
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                
                                <!-- Thêm hình ảnh mới -->
                                <div class="col-12 mt-4">
                                    <h4>Thêm hình ảnh mới</h4>
                                    <button type="button" id="addImageBtn" class="btn btn-warning mb-3">
                                        <i class="fa fa-plus"></i> Thêm hình ảnh
                                    </button>
                                    <div id="newImagesContainer" class="row">
                                        <!-- Container for new images -->
                                    </div>
                                    
                                    <!-- Template for new image (hidden) -->
                                    <div class="col-md-4 new-image-template" style="display: none;">
                                        <div class="image-item">
                                            <div class="image-preview">
                                                <img src="" alt="Preview" class="preview-image" style="display: none;">
                                                <span class="no-image-text">Chưa có ảnh</span>
                                            </div>
                                            <input type="file" class="form-control-file mb-2 image-upload" accept="image/*">
                                            <input type="text" class="form-control mb-2 image-title" placeholder="Tiêu đề ảnh">
                                            <button type="button" class="btn btn-danger delete-new-image">
                                                <i class="fa fa-times"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Các tùy chọn -->
                                <div class="col-12 mt-4">
                                    <div class="options-container">
                                        <div class="options-header">
                                            <div class="options-title">
                                                <i class="fa fa-list-ul"></i> Các tùy chọn đáp án
                                            </div>
                                            <div>
                                                <span class="badge badge-info">Số lượng: <span id="optionCount">${questionAnswers.size()}</span></span>
                                            </div>
                                        </div>
                                        
                                        <div id="optionsContainer">
                                            <c:forEach items="${questionAnswers}" var="answer" varStatus="status">
                                                <div class="option-row">
                                                    <div class="option-label">Option ${status.index + 1}</div>
                                                    <input type="text" class="form-control option-input" name="option" value="${answer.content}">
                                                    <div class="option-correct">
                                                        <input type="checkbox" id="isCorrect${status.index + 1}" name="isCorrect${status.index + 1}" ${answer.correct ? 'checked' : ''}>
                                                        <label for="isCorrect${status.index + 1}" class="correct-label">Đáp án đúng</label>
                                                    </div>
                                                    <button type="button" class="delete-btn" title="Xóa tùy chọn">
                                                        <i class="fa fa-times"></i>
                                                    </button>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        
                                        <button type="button" id="addOptionBtn" class="add-option-btn">
                                            <i class="fa fa-plus"></i> Thêm tùy chọn
                                        </button>
                                    </div>
                                </div>
                                
                                <!-- Nút submit -->
                                <div class="col-12 mt-4">
                                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                    <a href="${pageContext.request.contextPath}/manage-question" class="btn btn-secondary">Hủy</a>
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

<script>
    $(document).ready(function() {
        // Cập nhật số lượng option
        function updateOptionCount() {
            $('#optionCount').text($('.option-row').length);
        }
        
        // Thêm option mới
        $('#addOptionBtn').click(function() {
            console.log('Add option button clicked');
            const optionsContainer = $('#optionsContainer');
            const optionCount = $('.option-row').length + 1;
            
            const newOption = `
                <div class="option-row">
                    <div class="option-label">Option ${optionCount}</div>
                    <input type="text" class="form-control option-input" name="option" value="">
                    <div class="option-correct">
                        <input type="checkbox" id="isCorrect${optionCount}" name="isCorrect${optionCount}">
                        <label for="isCorrect${optionCount}" class="correct-label">Đáp án đúng</label>
                    </div>
                    <button type="button" class="delete-btn" title="Xóa tùy chọn">
                        <i class="fa fa-times"></i>
                    </button>
                </div>
            `;
            
            optionsContainer.append(newOption);
            console.log('New option added');
        });

        // Xử lý xóa option
        $(document).on('click', '.delete-btn', function() {
            console.log('Delete button clicked');
            const optionRow = $(this).closest('.option-row');
            
            optionRow.remove();
            
            // Cập nhật lại số thứ tự các option
            $('.option-row').each(function(index) {
                console.log('Updating option number:', index + 1);
                $(this).find('.option-label').text('Option ' + (index + 1));
                $(this).find('input[type="checkbox"]').attr({
                    'name': 'isCorrect' + (index + 1),
                    'id': 'isCorrect' + (index + 1)
                });
                $(this).find('label').attr('for', 'isCorrect' + (index + 1));
            });
            
            updateOptionCount();
        });

        // Xử lý thay đổi loại câu hỏi
        $('#questionType').change(function() {
            console.log('Question type changed');
            const selectedType = $(this).val();
            const optionsContainer = $('#optionsContainer');
            const addOptionBtn = $('#addOptionBtn');
            
            // Xóa tất cả các option hiện tại
            optionsContainer.empty();
            
            // Thêm các option mặc định dựa trên loại câu hỏi
            if (selectedType === "1") { // Multiple Choice
                console.log('Adding multiple choice options');
                for (let i = 1; i <= 4; i++) {
                    const option = `
                        <div class="option-row">
                            <div class="option-label">Option ${i}</div>
                            <input type="text" class="form-control option-input" name="option" value="">
                            <div class="option-correct">
                                <input type="checkbox" id="isCorrect${i}" name="isCorrect${i}">
                                <label for="isCorrect${i}" class="correct-label">Đáp án đúng</label>
                            </div>
                            <button type="button" class="delete-btn" title="Xóa tùy chọn">
                                <i class="fa fa-times"></i>
                            </button>
                        </div>
                    `;
                    optionsContainer.append(option);
                }
                // Hiển thị nút thêm tùy chọn
                addOptionBtn.show();
            } 
            else if (selectedType === "2") { // Fill in Blank
                console.log('Adding Fill in Blank options');
                // Thêm một option cho câu trả lời đúng
                const option = `
                    <div class="option-row">
                        <div class="option-label">Answer</div>
                        <input type="text" class="form-control option-input" name="option" value="">
                        <div class="option-correct">
                            <input type="checkbox" id="isCorrect1" name="isCorrect1" checked>
                            <label for="isCorrect1" class="correct-label">Đáp án đúng</label>
                        </div>
                        <button type="button" class="delete-btn" title="Xóa tùy chọn" style="visibility: hidden">
                            <i class="fa fa-times"></i>
                        </button>
                    </div>
                `;
                optionsContainer.append(option);
                // Ẩn nút thêm tùy chọn
                addOptionBtn.hide();
            }
            
            updateOptionCount();
        });

        // Debug cho xử lý hình ảnh
        let imageIndex = 0;
        $('#addImageBtn').click(function() {
            console.log('Add Image button clicked');
            const newImage = $('.new-image-template').clone().removeClass('new-image-template').show();
            const container = $('#newImagesContainer');
            
            console.log('Current image index:', imageIndex);
            newImage.find('.image-upload').attr('name', 'newImageFile[' + imageIndex + ']');
            newImage.find('.image-title').attr('name', 'newImageTitle[' + imageIndex + ']');
            
            container.append(newImage);
            console.log('New image container added');
            imageIndex++;
        });

        // Debug cho preview ảnh
        $(document).on('change', '.image-upload', function() {
            console.log('Image file selected');
            const file = this.files[0];
            console.log('File details:', file);
            
            const preview = $(this).closest('.image-item').find('.preview-image');
            const noImageText = $(this).closest('.image-item').find('.no-image-text');

            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    console.log('Image loaded successfully');
                    preview.attr('src', e.target.result).show();
                    noImageText.hide();
                }
                reader.readAsDataURL(file);
            }
        });

        // Debug cho xóa ảnh
        $(document).on('click', '.delete-image', function() {
            console.log('Delete image button clicked');
            const imageItem = $(this).closest('.image-item');
            imageItem.find('.delete-image-flag').val('true');
            console.log('Image marked for deletion');
            imageItem.addClass('text-muted').css('opacity', '0.5');
            $(this).hide();
        });

        // Debug cho xóa ảnh mới
        $(document).on('click', '.delete-new-image', function() {
            console.log('Delete new image button clicked');
            const imageContainer = $(this).closest('.col-md-4');
            console.log('Removing image container:', imageContainer);
            imageContainer.remove();
        });

        // Debug cho xử lý audio
        $('.delete-audio').click(function() {
            console.log('Delete audio button clicked');
            $('#deleteAudio').val('true');
            console.log('Audio marked for deletion');
            $(this).closest('.audio-container').find('audio').hide();
            $(this).hide();
            $('#audioPlaceholder').show();
        });

        // Debug cho preview audio
        $('#audioUpload').change(function() {
            console.log('Audio file selected');
            const file = this.files[0];
            console.log('Audio file details:', file);
            
            if (file) {
                const audioUrl = URL.createObjectURL(file);
                console.log('Audio URL created:', audioUrl);
                $('#newAudioPlayer').attr('src', audioUrl);
                $('#audioPreview').show();
            } else {
                console.log('No audio file selected');
                $('#audioPreview').hide();
            }
        });

        // Debug form submission
        $('form').submit(function(e) {
            console.log('Form submitted');
            console.log('Form data:', $(this).serialize());
            // Uncomment line below to prevent form submission during testing
            // e.preventDefault();
        });
    });
</script>

<script>
    // Toast message display
    var toastMessage = "${sessionScope.toastMessage}";
    var toastType = "${sessionScope.toastType}";
    if (toastMessage) {
        iziToast.show({
            title: toastType === 'success' ? 'Success' : 'Error',
            message: toastMessage,
            position: 'topRight',
            color: toastType === 'success' ? 'green' : 'red',
            timeout: 5000,
            onClosing: function () {
                // Remove toast attributes from the session after displaying
                fetch('${pageContext.request.contextPath}/remove-toast', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                }).then(response => {
                    if (!response.ok) {
                        console.error('Failed to remove toast attributes');
                    }
                }).catch(error => {
                    console.error('Error:', error);
                });
            }
        });
    }
</script>

</body>

</html>