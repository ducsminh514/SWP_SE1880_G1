<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tạo Bài Post Mới</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #212529;
            color: white;
            padding: 20px;
        }
        .content-container {
            border: 1px solid #444;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 15px;
            background-color: #2a2e32;
        }
        .content-header {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .drag-handle {
            cursor: move;
            padding: 5px;
            margin-right: 10px;
        }
        .form-control {
            background-color: #343a40;
            color: white;
            border: 1px solid #495057;
        }
        .form-control:focus {
            background-color: #343a40;
            color: white;
        }
        .btn-dark {
            background-color: #495057;
            border-color: #495057;
        }
        .btn-dark:hover {
            background-color: #5a6268;
            border-color: #5a6268;
        }
        .container {
            max-width: 1200px;
        }
        textarea {
            min-height: 150px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="mb-4">Tạo Bài Post Mới</h1>

        <form id="postForm" action="addNewPost" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="title">Tiêu đề:</label>
                <input type="text" class="form-control" id="title" name="title" required>
            </div>

            <div class="form-group">
                <label for="category">Danh mục:</label>
                <select class="form-control" id="category" name="categoryId" required>
                    <option value="">Chọn danh mục</option>
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.categoryBlogId}">${category.categoryBlogName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="thumbnail">Ảnh thumbnail:</label>
                <div class="custom-file">
                    <input type="file" class="custom-file-input" id="thumbnail" name="thumbnail" accept="image/*">
                    <label class="custom-file-label" for="thumbnail">Chọn tệp</label>
                    <div id="thumbnailPreview" class="mt-2"></div>
                </div>
            </div>

            <div class="form-group">
                <label>Nội dung bài viết:</label>
                <div class="mb-3">
                    <button type="button" class="btn btn-dark mr-2" id="addText">Thêm văn bản</button>
                    <button type="button" class="btn btn-dark mr-2" id="addImage">Thêm hình ảnh</button>
                    <button type="button" class="btn btn-dark" id="addVideo">Thêm video</button>
                </div>

                <div id="contentBlocks" class="mt-3">
                    <!-- Các khối nội dung sẽ được thêm vào đây bằng JavaScript -->
                </div>
            </div>

            <button type="submit" class="btn btn-primary">Đăng bài</button>
            <a href="ManagePostsServlet" class="btn btn-secondary">Hủy</a>
        </form>
    </div>

    <!-- Templates for content blocks -->
    <template id="textBlockTemplate">
        <div class="content-container" data-type="TEXT">
            <div class="content-header">
                <div class="drag-handle">☰</div>
                <h5>Đoạn văn bản</h5>
                <button type="button" class="btn btn-danger btn-sm ml-auto remove-block">Xóa</button>
            </div>
            <textarea class="form-control" name="content"></textarea>
            <input type="hidden" name="contentType" value="TEXT">
        </div>
    </template>

    <template id="imageBlockTemplate">
        <div class="content-container" data-type="IMAGE">
            <div class="content-header">
                <div class="drag-handle">☰</div>
                <h5>Hình ảnh</h5>
                <button type="button" class="btn btn-danger btn-sm ml-auto remove-block">Xóa</button>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input type="file" class="custom-file-input image-upload" name="imageFile[INDEX]" accept="image/*">
                    <label class="custom-file-label">Chọn hình ảnh</label>
                </div>
                <div class="image-preview mt-2"></div>
            </div>
            <div class="form-group">
                <label>Mô tả hình ảnh:</label>
                <input type="text" class="form-control" name="note[INDEX]" placeholder="Nhập mô tả hình ảnh">
            </div>
            <input type="hidden" name="contentType[INDEX]" value="IMAGE">
        </div>
    </template>

    <template id="videoBlockTemplate">
        <div class="content-container" data-type="VIDEO">
            <div class="content-header">
                <div class="drag-handle">☰</div>
                <h5>Video</h5>
                <button type="button" class="btn btn-danger btn-sm ml-auto remove-block">Xóa</button>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input type="file" class="custom-file-input video-upload" name="videoFile[INDEX]" accept="video/*">
                    <label class="custom-file-label">Chọn video</label>
                </div>
                <div class="video-preview mt-2"></div>
            </div>
            <div class="form-group">
                <label>Mô tả video:</label>
                <input type="text" class="form-control" name="note[INDEX]" placeholder="Nhập mô tả video">
            </div>
            <input type="hidden" name="contentType[INDEX]" value="VIDEO">
        </div>
    </template>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.10.2/Sortable.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bs-custom-file-input@1.3.4/dist/bs-custom-file-input.min.js"></script>

    <script>
        $(document).ready(function() {
            // Khởi tạo custom file input
            bsCustomFileInput.init();

            // Thêm một khối văn bản mặc định khi tải trang
            $('#addText').click();

            // Khởi tạo sortable cho các khối nội dung
            const contentBlocks = document.getElementById('contentBlocks');
            new Sortable(contentBlocks, {
                handle: '.drag-handle',
                animation: 150
            });

            // Xử lý thêm khối văn bản
            $('#addText').click(function() {
                const template = document.getElementById('textBlockTemplate');
                const clone = document.importNode(template.content, true);
                $('#contentBlocks').append(clone);
                updateOrderIndices();
            });

           $('#addImage').click(function() {
               const template = document.getElementById('imageBlockTemplate');
               const clone = document.importNode(template.content, true);
               const index = $('.content-container').length; // Lấy số lượng khối hiện tại

               clone.querySelector('.image-upload').name = `imageFile[${index}]`;
               clone.querySelector('input[name^="note"]').name = `note[${index}]`;
               clone.querySelector('input[name^="contentType"]').name = `contentType[${index}]`;
               $('#contentBlocks').append(clone);
               bsCustomFileInput.init();
               updateOrderIndices();
           });

           $('#addVideo').click(function() {
               const template = document.getElementById('videoBlockTemplate');
               const clone = document.importNode(template.content, true);
               const index = $('.content-container').length;

               clone.querySelector('.video-upload').name = `videoFile[${index}]`;
               clone.querySelector('input[name^="note"]').name = `note[${index}]`;
               clone.querySelector('input[name^="contentType"]').name = `contentType[${index}]`;
               $('#contentBlocks').append(clone);
               bsCustomFileInput.init();
               updateOrderIndices();
           });

            // Xử lý xóa khối nội dung
            $(document).on('click', '.remove-block', function() {
                if ($('.content-container').length > 1) {
                    $(this).closest('.content-container').remove();
                    updateOrderIndices();
                } else {
                    alert('Bài viết phải có ít nhất một khối nội dung!');
                }
            });

            // Xử lý preview ảnh thumbnail
            $('#thumbnail').change(function() {
                const file = this.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        $('#thumbnailPreview').html('<img src="' + e.target.result + '" class="img-fluid mt-2" style="max-height: 200px">');
                    }
                    reader.readAsDataURL(file);
                }
            });

            // Xử lý preview ảnh
            $(document).on('change', '.image-upload', function() {
                const file = this.files[0];
                const preview = $(this).closest('.form-group').find('.image-preview');

                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        preview.html('<img src="' + e.target.result + '" class="img-fluid mt-2" style="max-height: 200px">');
                    }
                    reader.readAsDataURL(file);
                }
            });

            // Xử lý preview video
            $(document).on('change', '.video-upload', function() {
                const file = this.files[0];
                const preview = $(this).closest('.form-group').find('.video-preview');

                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        preview.html('<video controls class="img-fluid mt-2" style="max-height: 200px"><source src="' + e.target.result + '" type="' + file.type + '"></video>');
                    }
                    reader.readAsDataURL(file);
                }
            });

            // Cập nhật thứ tự các khối nội dung
            function updateOrderIndices() {
                $('.content-container').each(function(index) {
                    $(this).attr('data-order', index);
                    // Thêm input ẩn để lưu thứ tự
                    if ($(this).find('input[name="orderIndex"]').length === 0) {
                        $(this).append('<input type="hidden" name="orderIndex" value="' + index + '">');
                    } else {
                        $(this).find('input[name="orderIndex"]').val(index);
                    }
                });
            }

            // Validate form trước khi submit
            $('#postForm').submit(function(event) {
                const title = $('#title').val().trim();
                const category = $('#category').val();

                if (title === '') {
                    alert('Vui lòng nhập tiêu đề bài viết!');
                    event.preventDefault();
                    return;
                }

                if (category === '') {
                    alert('Vui lòng chọn danh mục!');
                    event.preventDefault();
                    return;
                }

                if ($('.content-container').length === 0) {
                    alert('Vui lòng thêm ít nhất một khối nội dung!');
                    event.preventDefault();
                    return;
                }

                // Cập nhật thứ tự lần cuối trước khi submit
                updateOrderIndices();
            });
        });
    </script>
</body>
</html>