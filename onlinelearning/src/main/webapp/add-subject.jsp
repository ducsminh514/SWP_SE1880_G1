
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add New Subject</title>

        <style>
            body {
                font-family: Arial, sans-serif;
            }

            img{
                width: 200px;  /* Đặt chiều rộng cố định */
                height: 200px; /* Đặt chiều cao cố định */
                object-fit: cover; /* Cắt ảnh vừa với khung mà không bị méo */
                border-radius: 8px; /* Bo góc nhẹ nhàng */
                border: 1px solid #ccc; /* Viền nhẹ giúp ảnh nổi bật */
                box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ */
                margin: 5px; /* Tạo khoảng cách giữa các ảnh */
            }

            .uploaded-img{
                width: 270px;  /* Đặt chiều rộng cố định */
                height: 140px; /* Đặt chiều cao cố định */
                object-fit: cover; /* Cắt ảnh vừa với khung mà không bị méo */
                border-radius: 8px; /* Bo góc nhẹ nhàng */
                border: 1px solid #ccc; /* Viền nhẹ giúp ảnh nổi bật */
                box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ */
                margin: 5px; /* Tạo khoảng cách giữa các ảnh */
            }

            .container {
                width: 600px;
                margin: auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 10px;
                box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.2);
            }
            .input-group {
                margin-bottom: 15px;
            }
            label {
                font-weight: bold;
            }
            input, select, textarea {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            button {
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .btn-primary {
                background-color: blue;
                color: white;
            }
            .btn-secondary {
                background-color: gray;
                color: white;
            }
            .upload-container {
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .modal {
                display: none;
                position: fixed;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.5);
                justify-content: center;
                align-items: center;
            }

            .btn-close-modal{
                position: relative;
                left: 0;
                bottom: 35px;
            }

            .modal-content {
                background: white;
                padding: 20px;
                border-radius: 10px;
                width: 500px;
            }
            .grid-container {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 10px;
                margin-top: 10px;
            }
            .grid-item {
                width: 100px;
                height: 100px;
                background: #ccc;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>New Subject</h2>
            <form>
                <div class="input-group">
                    <label>Name:</label>
                    <input type="text" id="name">
                </div>
                <div class="input-group">
                    <label>Thumbnail Image:</label>
                    <input type="file" id="thumbnailInput" accept="image/*" onchange="previewThumbnail(event)">
                    <div class="thumbnail-preview" id="thumbnailPreview">No Image</div>
                </div>
                <div class="input-group">
                    <label>Category:</label>
                    <select>
                        <option>Select Category</option>
                    </select>
                </div>
                <div class="input-group">
                    <label>Owner:</label>
                    <input type="text" id="owner">
                </div>
                <div class="input-group">
                    <label>Upload Image/Video:</label>
                    <input type="file" id="uploadFile" accept="image/*,video/*,.mkv,.mp3"><br>
                </div>
                <button class="btn-primary" type="button" onclick="document.getElementById('modal').style.display = 'block'">Mô tả file</button>
                <br><br>
                <div class="input-group">
                    <label for="status">Status:</label>
                    <select id="status">
                        <option value="1">Active</option>
                        <option value="0">Draft</option>
                    </select>
                </div>
                <div class="input-group">
                    <label>Description:</label>
                    <textarea rows="4"></textarea>
                </div>
                <button class="btn-primary" type="submit">Save subject</button>
            </form>
        </div>

        <div id="modal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5);">
            <div style="background:white; padding:20px; width:100%; height: 40%; margin:auto; margin-top:10%;">
                <h3>Uploaded Files</h3><br/>
                <div id="uploadedFilesContainer" class="grid-container"></div>
            </div>
            <button class="btn-primary btn-close-modal" onclick="document.getElementById('modal').style.display = 'none'">Đóng</button>
        </div>
    </body>
    <script>
        var db;
        function saveThumbnailToDB(file) {
            const reader = new FileReader();
            reader.onload = function (event) {
                const transaction = db.transaction("subjects", "readwrite");
                const store = transaction.objectStore("subjects");
                store.put({id: "thumbnail", data: event.target.result});
            };
            reader.readAsDataURL(file);
        }

        function loadThumbnailFromDB() {
            const transaction = db.transaction("subjects", "readonly");
            const store = transaction.objectStore("subjects");
            const request = store.get("thumbnail");

            request.onsuccess = function () {
                if (request.result) {
                    document.getElementById("thumbnailPreview").innerHTML = '<img src="' + request.result.data + '" width="100">';
                } else {
                    document.getElementById("thumbnailPreview").innerHTML = 'No image';
                }
            };
        }

        // Hiển thị ảnh thumbnail khi chọn file
        function previewThumbnail(event) {
            var file = event.target.files[0];
            var preview = document.getElementById("thumbnailPreview");

            if (file) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    saveThumbnailToDB(e.target.result);
                    preview.innerHTML = "<img src='" + e.target.result + "' width='100' height='100' alt='Thumbnail'>";
                };
                reader.readAsDataURL(file);
            } else {
                preview.innerHTML = "No Image";
            }
        }
        document.addEventListener("DOMContentLoaded", function () {
            const request = indexedDB.open("SubjectDB", 1);


            request.onupgradeneeded = function (event) {
                db = event.target.result;
                if (!db.objectStoreNames.contains("subjects")) {
                    db.createObjectStore("subjects", {keyPath: "id", autoIncrement: true});
                }
                if (!db.objectStoreNames.contains("media")) {
                    db.createObjectStore("media", {keyPath: "id", autoIncrement: true});
                }
            };

            request.onsuccess = function (event) {
                db = event.target.result;
                loadThumbnailFromDB();
                loadUploadedFiles();
            };

            request.onerror = function () {
                console.error("IndexedDB error");
            };

            document.getElementById("thumbnailInput").addEventListener("change", function (event) {
                const file = event.target.files[0];
                if (file) {
                    saveThumbnailToDB(file);
                    document.getElementById("thumbnailPreview").innerHTML = '<img src="' + URL.createObjectURL(file) + '" width="100">';
                }
            });

            document.getElementById("uploadFile").addEventListener("change", function (event) {
                var file = event.target.files[0];
                if (!file)
                    return;

                var reader = new FileReader();
                reader.onload = function (e) {
                    var transaction = db.transaction("media", "readwrite");
                    var store = transaction.objectStore("media");

                    var fileData = {
                        id: Date.now(), // Đảm bảo ID duy nhất
                        name: file.name,
                        type: file.type,
                        data: e.target.result
                    };

                    store.add(fileData);
                    console.log("Đã lưu file vào IndexedDB: " + file.name);
                    loadUploadedFiles();
                };

                if (file.type.indexOf("video/") === 0) {
                    reader.readAsArrayBuffer(file);  // Đọc video dưới dạng ArrayBuffer
                } else {
                    reader.readAsDataURL(file);  // Ảnh vẫn đọc bằng DataURL
                }
            });

            function loadUploadedFiles() {
                if (!db)
                    return;
                var transaction = db.transaction("media", "readonly");
                var store = transaction.objectStore("media");
                var request = store.getAll();

                request.onsuccess = function (event) {
                    var files = event.target.result;
                    var container = document.getElementById("uploadedFilesContainer");
                    container.innerHTML = "";

                    files.forEach(function (file) {
                        var fileElement = document.createElement("div");
                        fileElement.classList.add("grid-item");

                        if (file.type.indexOf("image/") === 0) {
                            fileElement.innerHTML = '<img class="uploaded-img" src="' + file.data + '" alt="' + file.name + '">';
                        } else if (file.type.indexOf("video/") === 0) {
                            var blob = new Blob([file.data], {type: "video/mp4"}); // Tạo Blob từ dữ liệu đã lưu
                            var videoURL = URL.createObjectURL(blob); // Tạo URL từ Blob
                            fileElement.innerHTML = '<video width="200" height="150" controls>' +
                                    '<source src="' + videoURL + '" type="' + "video/mp4" + '">' +
                                    'Your browser does not support the video tag.' +
                                    '</video>';
                        }

                        var deleteButton = document.createElement("button");
                        deleteButton.textContent = "Xóa";
                        deleteButton.onclick = function () {
                            deleteFileFromDB(file.id);
                        };

                        fileElement.appendChild(deleteButton);
                        container.appendChild(fileElement);
                    });
                };
            }

            function deleteFileFromDB(id) {
                var transaction = db.transaction("media", "readwrite");
                var store = transaction.objectStore("media");
                store.delete(id);
                console.log("Đã xóa file khỏi IndexedDB, id: " + id);
                loadUploadedFiles();
            }
        });
    </script>
</html>

