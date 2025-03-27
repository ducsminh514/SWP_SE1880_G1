<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Post Detail</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            body {
                background-color: #99CCCC;
                color: #33CCCC;
                padding: 20px;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 30px;
                background-color: #1e1e1e;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
            }
            h1 {
                color: #ffffff;
                border-bottom: 2px solid #3a3a3a;
                padding-bottom: 15px;
                margin-bottom: 25px;
                font-weight: 600;
            }
            .content-container {
                border: 1px solid #3a3a3a;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
                background-color: #2a2a2a;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }
            .content-container:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            }
            .content-header {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
                border-bottom: 1px solid #3a3a3a;
                padding-bottom: 10px;
            }
            .drag-handle {
                cursor: move;
                padding: 5px 10px;
                margin-right: 15px;
                background-color: #333;
                border-radius: 4px;
                color: #aaa;
            }
            .drag-handle:hover {
                background-color: #444;
                color: #fff;
            }
            .form-control {
                background-color: #333;
                color: #e0e0e0;
                border: 1px solid #444;
                border-radius: 5px;
                padding: 10px 15px;
            }
            .form-control:focus {
                background-color: #3a3a3a;
                color: #ffffff;
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }
            label {
                color: #bbb;
                font-weight: 500;
                margin-bottom: 8px;
            }
            .btn-dark {
                background-color: #3a3a3a;
                border-color: #3a3a3a;
                transition: all 0.2s ease;
            }
            .btn-dark:hover {
                background-color: #4a4a4a;
                border-color: #4a4a4a;
            }
            .btn-primary {
                background-color: #0069d9;
                border-color: #0062cc;
                padding: 10px 20px;
                font-weight: 500;
            }
            .btn-primary:hover {
                background-color: #0062cc;
                border-color: #005cbf;
            }
            .btn-danger {
                background-color: #dc3545;
                border-color: #dc3545;
                transition: all 0.2s ease;
            }
            .btn-danger:hover {
                background-color: #c82333;
                border-color: #bd2130;
            }
            textarea {
                min-height: 150px;
                resize: vertical;
            }
            .custom-file-label {
                background-color: #333;
                color: #aaa;
                border: 1px solid #444;
            }
            .custom-file-label::after {
                background-color: #444;
                color: #e0e0e0;
            }
            .custom-file-input:focus ~ .custom-file-label {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }
            /* Fix for thumbnail preview */
            #thumbnailPreview {
                margin-top: 10px;
                margin-bottom: 20px;
                max-height: 200px;
                overflow: hidden;
                border-radius: 5px;
                border: 1px solid #444;
                background-color: #252525;
                text-align: center;
            }
            #thumbnailPreview img {
                max-height: 180px;
                object-fit: contain;
                margin: 10px;
            }
            .content-buttons {
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 1px solid #3a3a3a;
            }
            .content-buttons .btn {
                margin-right: 10px;
                padding: 8px 15px;
                font-weight: 500;
            }
            .image-preview, .video-preview {
                margin-top: 10px;
                background-color: #252525;
                border-radius: 5px;
                padding: 10px;
                text-align: center;
                border: 1px solid #444;
            }
            .image-preview img, .video-preview video {
                max-height: 180px;
                border-radius: 3px;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .form-control {
                height : 40px ;
            }
            /* Form submission area */
            .form-actions {
                margin-top: 30px;
                display: flex;
                justify-content: flex-end;
                gap: 15px;
            }
            .form-actions .btn {
                padding: 10px 25px;
                font-weight: 500;
            }
            /* Thêm hiệu ứng hover */
            .btn {
                transition: all 0.3s ease;
            }
            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
        </style>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.10.2/Sortable.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bs-custom-file-input@1.3.4/dist/bs-custom-file-input.min.js"></script>
    </head>
    <body>
        <div class="container">
            <h1 class="mb-4">Chỉnh Sửa Bài Post</h1>
            <c:set value="${requestScope.post}" var="post"/>
            <form id="postForm" action="updatePost" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="postId" value="${post.postId}"> <!-- Giả sử có postId để xác định bài post -->

                <!-- Tiêu đề -->
                <div class="form-group">
                    <label for="title">Tiêu đề:</label>
                    <input type="text" class="form-control" id="title" name="title" value="${post.title}" required>
                </div>
                <div class="form-group">
                    <label for="status" class="mr-2">Trạng thái:</label>
                    <div class="custom-control custom-switch">
                        <!-- Nếu post.status là true (1), checkbox sẽ được chọn -->
                        <input type="checkbox" class="custom-control-input" id="status" name="status"
                               ${post.status ? 'checked' : ''}>
                        <label class="custom-control-label" for="status">Bật/Tắt</label>
                    </div>
                </div>
                <!-- Danh mục -->
                <div class="form-group">
                    <label for="category">Danh mục:</label>
                    <select class="form-control" id="category" name="categoryId" required>
                        <option value="${post.categoryBlog.categoryBlogId}" selected>${post.categoryBlog.categoryBlogName}</option>
                        <c:forEach items="${requestScope.categories}" var="category">
                            <c:if test="${category.categoryBlogId != post.categoryBlog.categoryBlogId}">
                                <option value="${category.categoryBlogId}">${category.categoryBlogName}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>

                <!-- Thumbnail -->
                <div class="form-group">
                    <label for="thumbnail">Ảnh thumbnail:</label>
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="thumbnail" name="thumbnail" accept="image/*">
                        <label class="custom-file-label" for="thumbnail">Chọn tệp</label>
                    </div>
                    <div id="thumbnailPreview" class="mt-2">
                        <c:if test="${not empty post.thumbnail}">
                            <img src="${post.thumbnail}" alt="Thumbnail" class="img-fluid" style="max-width: 300px;">
                            <input type="hidden" name="existingThumbnail" value="${post.thumbnail}">
                        </c:if>
                        <c:if test="${empty post.thumbnail}">
                            <p>Chưa có ảnh thumbnail</p>
                        </c:if>
                    </div>
                </div>

                <!-- Nội dung bài viết -->
                <div class="form-group">
                    <label>Nội dung bài viết:</label>
                    <div class="content-buttons mb-3">
                        <button type="button" class="btn btn-dark" id="addText"><i class="fas fa-font mr-2"></i>Thêm văn bản</button>
                        <button type="button" class="btn btn-dark" id="addImage"><i class="fas fa-image mr-2"></i>Thêm hình ảnh</button>
                        <button type="button" class="btn btn-dark" id="addVideo"><i class="fas fa-video mr-2"></i>Thêm video</button>
                    </div>

                    <div id="contentBlocks" class="mt-3">
                        <!-- Hiển thị các khối nội dung hiện có -->
                        <c:forEach items="${requestScope.listPostContent}" var="postContent" varStatus="loop">
                            <c:choose>
                                <c:when test="${postContent.contentType == 'TEXT'}">
                                    <div class="content-container" data-type="TEXT" data-content-id="${postContent.contentId}">
                                        <div class="content-header">
                                            <div class="drag-handle">☰</div>
                                            <h5>Đoạn văn bản</h5>
                                            <button type="button" class="btn btn-danger btn-sm ml-auto remove-block"><i class="fas fa-trash mr-1"></i>Xóa</button>
                                        </div>
                                        <div class="form-group">
                                            <input type="hidden" class="form-control" name="note" >
                                        </div>
                                        <textarea class="form-control" name="content">${postContent.content}</textarea>
                                        <input type="hidden" name="oldContent" value="">
                                        <input type="hidden" name="contentType" value="TEXT">
                                        <input type="hidden" name="contentId" value="${postContent.contentId}">
                                        <input type="hidden" name="orderIndex" value="">
                                        <input type="hidden" class ="check" name="check" value="">
                                    </div>
                                </c:when>
                                <c:when test="${postContent.contentType == 'IMAGE'}">
                                    <div class="content-container" data-type="IMAGE" data-content-id="${postContent.contentId}">
                                        <div class="content-header">
                                            <div class="drag-handle">☰</div>
                                            <h5>Hình ảnh</h5>
                                            <button type="button" class="btn btn-danger btn-sm ml-auto remove-block"><i class="fas fa-trash mr-1"></i>Xóa</button>
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input image-upload" name="imageFile" accept="image/*">
                                                <label class="custom-file-label">Chọn hình ảnh</label>
                                            </div>
                                            <div class="image-preview mt-2" data-existing-image="${postContent.content}">
                                                <c:if test="${not empty postContent.content}">
                                                    <img src="${postContent.content}" alt="Image" class="img-fluid" style="max-width: 300px;">
                                                </c:if>
                                            </div>
                                            <input type="hidden" name="oldContent" value="${postContent.content}">
                                        </div>
                                        <textarea type="hidden" class="form-control" name="content" style="display: none;"></textarea>
                                        <div class="form-group">
                                            <label>Mô tả hình ảnh:</label>
                                            <input type="text" class="form-control" name="note" value="${postContent.note}" placeholder="Nhập mô tả hình ảnh">
                                        </div>
                                        <input type="hidden" name="contentType" value="IMAGE">
                                        <input type="hidden" name="contentId" value="${postContent.contentId}">
                                        <input type="hidden" name="orderIndex" value="">
                                        <input type="hidden" class ="check" name="check" value="">
                                    </div>
                                </c:when>
                                <c:when test="${postContent.contentType == 'VIDEO'}">
                                    <div class="content-container" data-type="VIDEO" data-content-id="${postContent.contentId}">
                                        <div class="content-header">
                                            <div class="drag-handle">☰</div>
                                            <h5>Video</h5>
                                            <button type="button" class="btn btn-danger btn-sm ml-auto remove-block"><i class="fas fa-trash mr-1"></i>Xóa</button>
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input video-upload" name="videoFile" accept="video/*">
                                                <label class="custom-file-label">Chọn video</label>
                                            </div>
                                            <div class="video-preview mt-2" data-existing-video="${postContent.content}">
                                                <c:if test="${not empty postContent.content}">
                                                    <video controls class="img-fluid" style="max-height: 180px">
                                                        <source src="${postContent.content}" type="video/mp4">
                                                        Trình duyệt không hỗ trợ video.
                                                    </video>
                                                </c:if>
                                            </div>
                                            <input type="hidden" name="oldContent" value="${postContent.content}">
                                        </div>
                                        <textarea type="hidden" class="form-control" name="content" style="display: none;"></textarea>
                                        <div class="form-group">
                                            <label>Mô tả video:</label>
                                            <input type="text" class="form-control" name="note" value="${postContent.note}" placeholder="Nhập mô tả video">
                                        </div>
                                        <input type="hidden" class="check" name="check" value="">
                                        <input type="hidden" name="contentType" value="VIDEO">
                                        <input type="hidden" name="contentId" value="${postContent.contentId}">
                                        <input type="hidden" name="orderIndex" value="">
                                    </div>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </div>
                </div>

                <!-- Nút hành động -->
                <div class="row">
                    <div class="form-actions">
                        <a href="javascript:history.back()" class="btn btn-secondary"><i class="fas fa-times mr-2"></i>Hủy</a>
                        <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane mr-2"></i>Lưu thay đổi</button>
                        <!-- Nút Xóa màu đỏ -->
                        <button type="button" class="btn btn-danger"><i class="fas fa-trash mr-2"></i>Xóa</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Templates -->
        <template id="textBlockTemplate">
            <div class="content-container" data-type="TEXT">
                <div class="content-header">
                    <div class="drag-handle">☰</div>
                    <h5>Đoạn văn bản</h5>
                    <button type="button" class="btn btn-danger btn-sm ml-auto remove-block"><i class="fas fa-trash mr-1"></i>Xóa</button>
                </div>
                <textarea class="form-control" name="content"></textarea>
                <input type="hidden" name="contentType" value="TEXT">
                <div class="form-group">
                    <input type="hidden" class="form-control" name="note" >
                </div>
                <input type="hidden" name="oldContent" value="">
                <input type="hidden" name="contentType" value="TEXT">
                <input type="hidden" name="orderIndex" value="">
                <input type="hidden" name="contentId" value="">
                <input type="hidden" class ="check" name="check" value="">
            </div>
        </template>

        <template id="imageBlockTemplate">
            <div class="content-container" data-type="IMAGE">
                <div class="content-header">
                    <div class="drag-handle">☰</div>
                    <h5>Hình ảnh</h5>
                    <button type="button" class="btn btn-danger btn-sm ml-auto remove-block"><i class="fas fa-trash mr-1"></i>Xóa</button>
                </div>
                <div class="form-group">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input image-upload" name="imageFile" accept="image/*">
                        <label class="custom-file-label">Chọn hình ảnh</label>
                    </div>
                    <div class="image-preview mt-2"></div>
                </div>
                <textarea type="hidden" class="form-control" name="content" style="display: none;"></textarea>
                <div class="form-group">
                    <label>Mô tả hình ảnh:</label>
                    <input type="text" class="form-control" name="note" placeholder="Nhập mô tả hình ảnh">
                </div>
                <input type="hidden" name="oldContent" value="">
                <input type="hidden" name="contentType" value="IMAGE">
                <input type="hidden" name="orderIndex" value="">
                <input type="hidden" name="contentId" value="">
                <input type="hidden" class ="check" name="check" value="">
            </div>
        </template>

        <template id="videoBlockTemplate">
            <div class="content-container" data-type="VIDEO">
                <div class="content-header">
                    <div class="drag-handle">☰</div>
                    <h5>Video</h5>
                    <button type="button" class="btn btn-danger btn-sm ml-auto remove-block"><i class="fas fa-trash mr-1"></i>Xóa</button>
                </div>
                <div class="form-group">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input video-upload" name="videoFile" accept="video/*">
                        <label class="custom-file-label">Chọn video</label>
                    </div>
                    <div class="video-preview mt-2"></div>
                </div>
                <textarea type="hidden" class="form-control" name="content" style="display: none;"></textarea>
                <div class="form-group">
                    <label>Mô tả video:</label>
                    <input type="text" class="form-control" name="note" placeholder="Nhập mô tả video">
                </div>
                <input type="hidden" name="oldContent" value="">
                <input type="hidden" name="contentType" value="VIDEO">
                <input type="hidden" name="orderIndex" value="">
                <input type="hidden" name="contentId" value="">
                <input type="hidden" class ="check"  name="check" value="">
            </div>
        </template>

        <!-- Scripts -->

        <script>
            $(document).ready(function () {
                bsCustomFileInput.init();
                const contentBlocks = document.getElementById('contentBlocks');
                new Sortable(contentBlocks, {
                    handle: '.drag-handle',
                    animation: 150,

                });

                $(document).on('change', '.image-upload', function () {
                    // Get the parent container
                    const container = $(this).closest('.content-container');

                    // Find the hidden check input within this container and set its value to "change"
                    container.find('.check').val('change');

                });
                $(document).on('change', '.video-upload', function () {
                    // Get the parent container
                    const container = $(this).closest('.content-container');

                    // Find the hidden check input within this container and set its value to "change"
                    container.find('.check').val('change');
                });


               function cleanupDuplicateBlocks() {
                   const seenBlockIds = new Set();
                   $('#contentBlocks .content-container').each(function() {
                       const blockId = $(this).data('content-id');
                       const blockType = $(this).data('type');

                       const uniqueKey = blockId + blockType;

                       if (seenBlockIds.has(uniqueKey)) {
                           $(this).remove();
                       } else {
                           seenBlockIds.add(uniqueKey);
                       }
                   });
               }

               // Gọi hàm này sau khi thêm hoặc di chuyển khối
               $('#addText').click(function () {
                   const template = document.getElementById('textBlockTemplate');
                   const clone = document.importNode(template.content, true);

                   $('#contentBlocks').append(clone);
                   updateOrderIndices();
                   cleanupDuplicateBlocks();
               });

                // Thêm khối hình ảnh
                $('#addImage').click(function () {
                    const template = document.getElementById('imageBlockTemplate');
                    const clone = document.importNode(template.content, true);

                    $('#contentBlocks').append(clone);
                    bsCustomFileInput.init();
                    updateOrderIndices();
                });

                // Thêm khối video
                $('#addVideo').click(function () {
                    const template = document.getElementById('videoBlockTemplate');
                    const clone = document.importNode(template.content, true);

                    $('#contentBlocks').append(clone);
                    bsCustomFileInput.init();
                    updateOrderIndices();
                });

                // Xóa khối
                $(document).on('click', '.remove-block', function () {
                    if ($('.content-container').length > 1) {
                        $(this).closest('.content-container').remove();
                        updateOrderIndices();
                    } else {
                        alert('Bài viết phải có ít nhất một khối nội dung!');
                    }
                });

                // Preview thumbnail
                $('#thumbnail').change(function () {
                    const file = this.files[0];
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            $('#thumbnailPreview').html('<img src="' + e.target.result + '" class="img-fluid" style="max-height: 180px;">');
                        };
                        reader.readAsDataURL(file);
                    }
                });

                // Preview ảnh
                $(document).on('change', '.image-upload', function () {
                    const file = this.files[0];
                    const preview = $(this).closest('.form-group').find('.image-preview');
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            preview.html('<img src="' + e.target.result + '" class="img-fluid" style="max-height: 180px">');
                        };
                        reader.readAsDataURL(file);
                    }
                });

                // Preview video
                $(document).on('change', '.video-upload', function () {
                    const file = this.files[0];
                    const preview = $(this).closest('.form-group').find('.video-preview');
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            preview.html('<video controls class="img-fluid" style="max-height: 180px"><source src="' + e.target.result + '" type="video/mp4"></video>');
                        };
                        reader.readAsDataURL(file);
                    }
                });

                // Cập nhật thứ tự
                function updateOrderIndices() {
                    $('.content-container').each(function (index) {
                        console.log(index);
                        $(this).find('input[name="check"]').attr('name', `check[${index}]`);
                        $(this).find('input[name="orderIndex"]').attr('name', `orderIndex[${index}]`);
                        $(this).find('textarea[name="content"]').attr('name', `content[${index}]`);
                        $(this).find('input[name="contentType"]').attr('name', `contentType[${index}]`);
                        $(this).find('input[name="imageFile"]').attr('name', `imageFile[${index}]`);
                        console.log("Updated contentType name:", $(this).find('input[name^="imageFile"]').attr('name'));
                        $(this).find('input[name="videoFile"]').attr('name', `videoFile[${index}]`);
                        $(this).find('input[name="note"]').attr('name', `note[${index}]`);
                        $(this).find('input[name="contentId"]').attr('name', `contentId[${index}]`);
                        $(this).find('input[name="oldContent"]').attr('name', `oldContent[${index}]`);
                    });
                }

                // Validate form
                $('#postForm').submit(function (event) {
                    updateOrderIndices();
                    console.log('Form data:', $(this).serialize());
                });
            });
        </script>
    </body>
</html>