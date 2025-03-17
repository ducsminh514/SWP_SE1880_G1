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
            <h4 class="breadcrumb-title">Quản lý Câu hỏi</h4>
            <ul class="db-breadcrumb-list">
                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                <li>Quản lý Câu hỏi</li>
                <li>Câu hỏi 1</li>
            </ul>
        </div>
        <div class="row">
            <!-- Your Profile Views Chart -->
            <div class="col-lg-12 m-b30">
                <div class="widget-box">
                    <div class="wc-title">
                        <h4>Quản lý Câu hỏi</h4>
                    </div>
                    <div class="widget-body">
                        <div class="widget-inner">
                            <form action="${pageContext.request.contextPath}/edit-question" method="POST"
                                  enctype="multipart/form-data">
                                <input type="hidden" name="questionId" value="${question.questionId}">

                                <div class="mb-4">
                                    <a href="${pageContext.request.contextPath}/manage-question"
                                       class="btn btn-warning">Back</a>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="subject">Subject</label>
                                            <select class="form-control" id="subject" name="subject">
                                                <c:forEach items="${subjectList}" var="subject">
                                                    <option value="${subject.subjectId}" 
                                                            ${question.subject.subjectId == subject.subjectId ? "selected" : ""}>
                                                        ${subject.subjectName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="level">Level</label>
                                            <select class="form-control" id="level" name="level">
                                                <option value="1" ${question.level==1 ? "selected" : "" }>Easy</option>
                                                <option value="2" ${question.level==2 ? "selected" : "" }>Medium
                                                </option>
                                                <option value="3" ${question.level==3 ? "selected" : "" }>Hard</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="mark">Mark</label>
                                            <input type="number" class="form-control" id="mark" name="mark"
                                                   value="${question.mark}">
                                        </div>

                                        <div class="form-group">
                                            <label for="questionType">Question type</label>
                                            <select class="form-control" id="questionType" name="questionTypeId">
                                                <c:forEach items="${questionTypes}" var="type">
                                                    <option value="${type.questionTypeId}"
                                                        ${question.questionType.questionTypeId==type.questionTypeId ? "selected" : "" }>
                                                            ${type.questionTypeName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="createDate">Create Date</label>
                                            <input type="date" class="form-control" id="createDate" name="createDate"
                                                   value="${question.createTime}" readonly>
                                        </div>

                                        <div class="form-group">
                                            <label for="updateDate">Update Date</label>
                                            <input type="date" class="form-control" id="updateDate" name="updateDate"
                                                   value="${question.updateTime}" readonly>
                                        </div>

                                        <div class="form-group">
                                            <label for="status">Status</label>
                                            <select class="form-control" id="status" name="status">
                                                <option value="true" ${question.status ? "selected" : "" }>Active
                                                </option>
                                                <option value="false" ${!question.status ? "selected" : "" }>Inactive
                                                </option>
                                            </select>
                                        </div>

                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="content">Content</label>
                                    <textarea class="form-control" id="content" name="content"
                                              rows="4">${question.content}</textarea>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Image <span
                                                    style="color: #ff6666;">(chỉ theo định dạng ảnh)</span></label>
                                            <div id="imagesContainer">
                                                <!-- Existing images -->
                                                <c:forEach items="${question.questionImage}" var="image" varStatus="status">
                                                    <div class="image-item mb-3">
                                                        <div class="position-relative">
                                                            <div class="image-preview">
                                                                <img src="${pageContext.request.contextPath}/uploads/images/${image.imageUrl}" 
                                                                     alt="Question Image" class="img-fluid">
                                                            </div>
                                                            <button type="button" class="btn btn-danger btn-sm delete-image" 
                                                                    data-image-id="${image.imageId}">X</button>
                                                        </div>
                                                        <div class="mt-2">
                                                            <input type="text" class="form-control" name="imageTitle${status.index}" 
                                                                   value="${image.title}" placeholder="Title">
                                                            <input type="hidden" name="existingImageId${status.index}" value="${image.imageId}">
                                                        </div>
                                                    </div>
                                                </c:forEach>

                                                <!-- New image template -->
                                                <div class="image-item mb-3 new-image-template" style="display: none;">
                                                    <div class="position-relative">
                                                        <div class="image-preview">
                                                            <img src="" alt="Preview" class="img-fluid preview-image" style="display: none;">
                                                            <span class="no-image-text">No image selected</span>
                                                        </div>
                                                        <button type="button" class="btn btn-danger btn-sm delete-new-image">X</button>
                                                    </div>
                                                    <div class="mt-2">
                                                        <input type="file" class="form-control-file image-upload" accept="image/*">
                                                        <input type="text" class="form-control mt-2 image-title" placeholder="Title">
                                                    </div>
                                                </div>

                                                <div id="newImagesContainer"></div>
                                            </div>
                                            <button type="button" class="btn btn-warning mt-3" id="addImageBtn">Thêm hình ảnh</button>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
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
                                                    <span>No audio</span>
                                                </div>
                                                <div class="mt-3">
                                                    <input type="file" class="form-control-file" id="audioUpload" name="audioFile" accept="audio/mpeg">
                                                    <input type="hidden" name="currentAudio" value="${question.mp3}">
                                                    <input type="hidden" name="deleteAudio" id="deleteAudio" value="false">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Options section -->
                                <div id="optionsSection" class="mt-4">
                                    <h5>Options</h5>
                                    <div id="optionsContainer">
                                        <c:forEach items="${questionAnswers}" var="answer" varStatus="status">
                                            <div class="option-row">
                                                <div class="option-label">Option ${status.index + 1}</div>
                                                <input type="text" class="form-control option-input"
                                                       name="option${status.index + 1}" value="${answer.content}">
                                                <c:if test="${question.questionType.questionTypeId == 1}"> <!-- Multiple Choice -->
                                                    <input type="checkbox"
                                                           name="isCorrect${status.index + 1}" ${answer.isCorrect ? "checked" : ""}>
                                                    <label class="ml-2 mr-2">Is Correct</label>
                                                </c:if>
                                                <c:if test="${question.questionType.questionTypeId != 1}"> <!-- Fill in the blank -->
                                                    <input type="hidden" name="isCorrect${status.index + 1}"
                                                           value="true">
                                                </c:if>
                                                <button type="button" class="delete-btn">X</button>
                                            </div>
                                        </c:forEach>

                                        <!-- If no answers exist, show at least one empty option -->
                                        <c:if test="${empty questionAnswers}">
                                            <div class="option-row">
                                                <div class="option-label">Option 1</div>
                                                <input type="text" class="form-control option-input" name="option1"
                                                       value="">
                                                <c:if test="${question.questionType.questionTypeId == 1 || empty question.questionType}">
                                                    <input type="checkbox" name="isCorrect1">
                                                    <label class="ml-2 mr-2">IsCorrect</label>
                                                </c:if>
                                                <c:if test="${question.questionType.questionTypeId != 1 && not empty question.questionType}">
                                                    <input type="hidden" name="isCorrect1" value="true">
                                                </c:if>
                                                <button type="button" class="delete-btn">X</button>
                                            </div>
                                        </c:if>
                                    </div>
                                    <c:if test="${question.questionType.questionTypeId == 1 || empty question.questionType}">
                                        <button type="button" class="add-btn" id="addOption">Thêm option</button>
                                    </c:if>
                                </div>

                                <div class="text-center mt-4">
                                    <button type="submit" class="btn btn-primary">Update</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<div class="ttr-overlay"></div>

<!-- External JavaScripts -->
<jsp:include page="../admin/setting-in-page.jsp"></jsp:include>

<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
<jsp:include page="../common/common_admin_js.jsp"></jsp:include>

<!-- Script cuối trang -->
<script>
    $(document).ready(function () {
        // Xử lý thêm option mới
        $("#addOption").click(function () {
            const optionsContainer = $("#optionsContainer");
            const optionCount = optionsContainer.children().length + 1;
            const questionType = $("#questionType").val();

            let newOption = `
                <div class="option-row">
                    <div class="option-label">Option ${optionCount}</div>
                    <input type="text" class="form-control option-input" name="option${optionCount}" value="">
              `;

            // Nếu là multiple choice thì thêm checkbox
            if (questionType == 1) {
                newOption += `
                    <input type="checkbox" name="isCorrect${optionCount}">
                    <label class="ml-2 mr-2">IsCorrect</label>
                  `;
            } else {
                // Nếu là fill in the blank thì thêm hidden input với value=true
                newOption += `
                    <input type="hidden" name="isCorrect${optionCount}" value="true">
                  `;
            }

            newOption += `
                    <button type="button" class="delete-btn">X</button>
                </div>
              `;

            optionsContainer.append(newOption);
        });

        // Xử lý xóa option
        $(document).on("click", ".delete-btn", function () {
            // Nếu là fill in the blank và chỉ còn 1 option thì không cho xóa
            const questionType = $("#questionType").val();
            const optionsCount = $("#optionsContainer").children().length;

            if (questionType != 1 && optionsCount <= 1) {
                alert("Fill in the blank question must have at least one answer");
                return;
            }

            $(this).closest(".option-row").remove();

            // Cập nhật lại số thứ tự của các option
            $("#optionsContainer .option-row").each(function (index) {
                $(this).find(".option-label").text(`Option ${index + 1}`);
                $(this).find(".option-input").attr("name", `option${index + 1}`);
                $(this).find("input[type='checkbox'], input[type='hidden']").attr("name", `isCorrect${index + 1}`);
            });
        });

        // Hiển thị/ẩn phần options và nút thêm option dựa vào loại câu hỏi
        $("#questionType").change(function () {
            const questionType = $(this).val();

            if (questionType == 1) { // Multiple Choice
                $("#optionsSection").show();
                $("#addOption").show();

                // Chuyển đổi hidden input thành checkbox nếu cần
                $("#optionsContainer .option-row").each(function (index) {
                    const isCorrectInput = $(this).find("input[name^='isCorrect']");
                    if (isCorrectInput.attr("type") === "hidden") {
                        const isCorrect = isCorrectInput.val() === "true";
                        isCorrectInput.replaceWith(`
                                <input type="checkbox" name="isCorrect${index + 1}" ${isCorrect ? "checked" : ""}>
                                <label class="ml-2 mr-2">IsCorrect</label>
                            `);
                    }
                });
            } else { // Fill in the blank
                $("#optionsSection").show();
                $("#addOption").hide();

                // Nếu không có option nào, thêm một option mặc định
                if ($("#optionsContainer").children().length === 0) {
                    $("#optionsContainer").append(`
                            <div class="option-row">
                                <div class="option-label">Option 1</div>
                                <input type="text" class="form-control option-input" name="option1" value="">
                                <input type="hidden" name="isCorrect1" value="true">
                                <button type="button" class="delete-btn">X</button>
                            </div>
                        `);
                }

                // Chuyển đổi checkbox thành hidden input
                $("#optionsContainer .option-row").each(function (index) {
                    const checkboxLabel = $(this).find("label");
                    const checkbox = $(this).find("input[type='checkbox']");

                    if (checkbox.length > 0) {
                        const isChecked = checkbox.prop("checked");
                        checkbox.replaceWith(`<input type="hidden" name="isCorrect${index + 1}" value="${isChecked ? 'true' : 'false'}">`);
                        checkboxLabel.remove();
                    }
                });

                // Giữ lại chỉ một option nếu có nhiều hơn
                if ($("#optionsContainer").children().length > 1) {
                    $("#optionsContainer").children().slice(1).remove();
                }
            }
        });

        // Trigger change event để hiển thị/ẩn options khi trang load
        $("#questionType").trigger("change");

        // Xử lý thêm hình ảnh mới
        let imageIndex = 0;
        $('#addImageBtn').click(function() {
            const newImage = $('.new-image-template').clone().removeClass('new-image-template').show();
            const container = $('#newImagesContainer');
            
            newImage.find('.image-upload').attr('name', 'newImageFile[' + imageIndex + ']');
            newImage.find('.image-title').attr('name', 'newImageTitle[' + imageIndex + ']');
            
            container.append(newImage);
            imageIndex++;
        });

        // Xử lý preview ảnh
        $(document).on('change', '.image-upload', function() {
            const file = this.files[0];
            const preview = $(this).closest('.image-item').find('.preview-image');
            const noImageText = $(this).closest('.image-item').find('.no-image-text');

            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.attr('src', e.target.result).show();
                    noImageText.hide();
                }
                reader.readAsDataURL(file);
            }
        });

        // Xử lý xóa ảnh
        $(document).on('click', '.delete-image, .delete-new-image', function() {
            $(this).closest('.image-item').remove();
        });

        // Xử lý audio upload
        $('#audioUpload').change(function() {
            const file = this.files[0];
            const container = $('.audio-container');
            const placeholder = $('#audioPlaceholder');
            
            if (file) {
                const url = URL.createObjectURL(file);
                placeholder.hide();
                
                // Remove existing audio elements
                container.find('audio').remove();
                
                // Add new audio element
                const audioElement = $('<audio controls class="w-100"></audio>')
                    .append('<source src="' + url + '" type="' + file.type + '">');
                
                // Add delete button
                const deleteBtn = $('<button type="button" class="btn btn-danger delete-audio">')
                    .click(function() {
                        audioElement.remove();
                        $(this).remove();
                        placeholder.show();
                        $('#audioUpload').val('');
                    });
                
                container.prepend(audioElement, deleteBtn);
            }
        });

        // Xử lý xóa audio existing
        $('.delete-audio').click(function() {
            $('.existing-audio').remove();
            $(this).remove();
            $('#audioPlaceholder').show();
            $('<input>').attr({
                type: 'hidden',
                name: 'deleteAudio',
                value: 'true'
            }).appendTo('form');
        });
    });
</script>

</body>

</html>