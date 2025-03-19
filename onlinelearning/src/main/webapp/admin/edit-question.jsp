<%-- Created by IntelliJ IDEA. User: PC Date: 3/9/2025 Time: 11:42 PM To change this template use File | Settings | File
  Templates. --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                                    <div class="form-group">
                                        <label for="content">Nội dung câu hỏi</label>
                                        <textarea class="form-control" id="content" name="content" rows="4" required>${question.content}</textarea>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="level">Cấp độ</label>
                                        <select class="form-control" id="level" name="level" required>
                                            <option value="1" ${question.level == 1 ? 'selected' : ''}>Dễ</option>
                                            <option value="2" ${question.level == 2 ? 'selected' : ''}>Trung bình</option>
                                            <option value="3" ${question.level == 3 ? 'selected' : ''}>Khó</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="subject">Môn học</label>
                                        <select class="form-control" id="subject" name="subject" required>
                                            <c:forEach items="${subjectList}" var="subject">
                                                <option value="${subject.subjectId}" ${question.subject.subjectId == subject.subjectId ? 'selected' : ''}>${subject.subjectName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="mark">Điểm</label>
                                        <input type="number" class="form-control" id="mark" name="mark" value="${question.mark}" min="1" required>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="questionType">Loại câu hỏi</label>
                                        <select class="form-control" id="questionType" name="questionType" required>
                                            <c:forEach items="${questionTypes}" var="type">
                                                <option value="${type.questionTypeId}" ${question.questionType.questionTypeId == type.questionTypeId ? 'selected' : ''}>${type.questionTypeName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="status">Trạng thái</label>
                                        <select class="form-control" id="status" name="status">
                                            <option value="true" ${question.status ? 'selected' : ''}>Kích hoạt</option>
                                            <option value="false" ${!question.status ? 'selected' : ''}>Vô hiệu hóa</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="col-12">
                                    <div class="form-group">
                                        <label for="audioUpload">Audio (MP3)</label>
                                        <div class="audio-container position-relative">
                                            <c:if test="${not empty question.mp3}">
                                                <audio controls class="w-100">
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
                                            <div class="mt-3">
                                                <input type="file" class="form-control-file" id="audioUpload" name="audioFile" accept="audio/mpeg">
                                                <input type="hidden" name="currentAudio" value="${question.mp3}">
                                                <input type="hidden" name="deleteAudio" id="deleteAudio" value="false">
                                            </div>
                                            
                                            <!-- Audio preview for new uploads -->
                                            <div id="audioPreview" style="display: none; margin-top: 10px;">
                                                <audio controls class="w-100">
                                                    <source id="newAudioPlayer" src="" type="audio/mpeg">
                                                    Your browser does not support the audio element.
                                                </audio>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Existing Images Section -->
                                <div class="col-12 mt-4">
                                    <h5>Hình ảnh hiện tại</h5>
                                    <div class="row" id="existingImagesContainer">
                                        <c:if test="${empty question.questionImage}">
                                            <div class="col-12">
                                                <p class="text-muted">Không có hình ảnh</p>
                                            </div>
                                        </c:if>
                                        
                                        <c:forEach items="${question.questionImage}" var="image" varStatus="status">
                                            <div class="col-md-4">
                                                <div class="image-item">
                                                    <div class="image-preview">
                                                        <img src="${pageContext.request.contextPath}/uploads/images/${image.imageTitle}" 
                                                             alt="Question Image" class="preview-image">
                                                    </div>
                                                    <div class="image-title">
                                                        <input type="text" class="form-control" name="imageTitle[${status.index}]" 
                                                               value="${image.imageTitle}" readonly>
                                                        <input type="hidden" name="imageId[${status.index}]" value="${image.imageId}">
                                                        <input type="hidden" class="delete-image-flag" name="deleteImage[${status.index}]" value="false">
                                                    </div>
                                                    <button type="button" class="btn btn-danger delete-image">
                                                        <i class="fa fa-times"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                
                                <!-- New Images Section -->
                                <div class="col-12 mt-4">
                                    <h5>Thêm hình ảnh mới</h5>
                                    <div class="row" id="newImagesContainer">
                                        <!-- New images will be added here -->
                                    </div>
                                    <button type="button" id="addImageBtn" class="btn btn-info mt-2">
                                        <i class="fa fa-plus"></i> Thêm hình ảnh
                                    </button>
                                    
                                    <!-- Template for new image (hidden) -->
                                    <div class="col-md-4 new-image-template" style="display: none;">
                                        <div class="image-item">
                                            <div class="image-preview">
                                                <img src="" alt="New Image" class="preview-image" style="display: none;">
                                                <span class="no-image-text">Chưa chọn ảnh</span>
                                            </div>
                                            <div class="image-title">
                                                <input type="text" class="form-control image-title" placeholder="Tiêu đề ảnh">
                                            </div>
                                            <input type="file" class="form-control-file mt-2 image-upload" accept="image/*">
                                            <button type="button" class="btn btn-danger delete-new-image">
                                                <i class="fa fa-times"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Options Section -->
                                <div class="col-12 mt-4" id="optionsSection">
                                    <h5>Các tùy chọn</h5>
                                    <div id="optionsContainer">
                                        <c:forEach items="${questionAnswers}" var="answer" varStatus="status">
                                            <div class="option-row">
                                                <div class="option-label">Option ${status.index + 1}</div>
                                                <input type="text" class="form-control option-input" name="option${status.index + 1}" value="${answer.content}">
                                                <c:choose>
                                                    <c:when test="${question.questionType.questionTypeId == 1}">
                                                        <input type="checkbox" name="isCorrect${status.index + 1}" ${answer.isCorrect ? 'checked' : ''}>
                                                        <label class="ml-2 mr-2">Đáp án đúng</label>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="hidden" name="isCorrect${status.index + 1}" value="${answer.isCorrect}">
                                                    </c:otherwise>
                                                </c:choose>
                                                <button type="button" class="delete-btn">X</button>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <button type="button" id="addOption" class="add-btn">
                                        <i class="fa fa-plus"></i> Thêm tùy chọn
                                    </button>
                                </div>
                                
                                <div class="col-12 mt-4">
                                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                    <a href="${pageContext.request.contextPath}/manage-question" class="btn btn-secondary ml-2">Hủy</a>
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
        // Debug cho nút thêm option
        $('#addOption').click(function() {
            console.log('Add Option button clicked');
            const optionsContainer = $('#optionsContainer');
            const optionCount = optionsContainer.children().length + 1;
            console.log('Current option count:', optionCount);

            const newOption = `
                <div class="option-row">
                    <div class="option-label">Option ${optionCount}</div>
                    <input type="text" class="form-control option-input" name="option${optionCount}" value="">
                    <input type="checkbox" name="isCorrect${optionCount}">
                    <button type="button" class="delete-btn">X</button>
                </div>
            `;
            optionsContainer.append(newOption);
            console.log('New option added:', newOption);
        });

        // Debug cho nút xóa option
        $(document).on('click', '.delete-btn', function() {
            console.log('Delete button clicked');
            const optionRow = $(this).closest('.option-row');
            console.log('Deleting option:', optionRow.find('.option-input').val());
            optionRow.remove();
            
            // Cập nhật lại số thứ tự các option
            $('.option-row').each(function(index) {
                console.log('Updating option number:', index + 1);
                $(this).find('.option-label').text('Option ' + (index + 1));
                $(this).find('.option-input').attr('name', 'option' + (index + 1));
                $(this).find('input[type="checkbox"]').attr('name', 'isCorrect' + (index + 1));
            });
        });

        // Debug cho thay đổi loại câu hỏi
        $("#questionType").change(function() {
            console.log('Question type changed to:', $(this).val());
            const selectedType = $(this).val();
            const optionsContainer = $("#optionsContainer");
            
            // Clear existing options
            optionsContainer.empty();
            console.log('Cleared existing options');

            // Add appropriate number of options based on question type
            if (selectedType === "1") { // Multiple choice
                console.log('Adding multiple choice options');
                for (let i = 1; i <= 4; i++) {
                    const option = `
                        <div class="option-row">
                            <div class="option-label">Option ${i}</div>
                            <input type="text" class="form-control option-input" name="option${i}" value="">
                            <input type="checkbox" name="isCorrect${i}">
                            <button type="button" class="delete-btn">X</button>
                        </div>
                    `;
                    optionsContainer.append(option);
                }
            } else if (selectedType === "2") { // True/False
                console.log('Adding True/False options');
                for (let i = 1; i <= 2; i++) {
                    const value = i === 1 ? "True" : "False";
                    const option = `
                        <div class="option-row">
                            <div class="option-label">Option ${i}</div>
                            <input type="text" class="form-control option-input" name="option${i}" value="${value}" readonly>
                            <input type="checkbox" name="isCorrect${i}">
                            <button type="button" class="delete-btn">X</button>
                        </div>
                    `;
                    optionsContainer.append(option);
                }
            }
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

</body>

</html>