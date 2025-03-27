<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/17/2025
  Time: 10:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Add New Question</title>
    <style>
        label { display: inline-block; width: 120px; margin-top: 10px; }
        input, select { margin-top:<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/17/2025
  Time: 10:07 PM
  To change this template use File | Settings | File Templates.
--%>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>
        <head>
        <title>Add New Question</title>
        <style>
        label { display: inline-block; width: 120px; margin-top: 10px; }
            input, select { margin-top: 10px; }
    </style>
    <script type="text/javascript">
        function addOption() {
            // Lấy container option
            var container = document.getElementById("optionsContainer");

            // Tạo một div để chứa option mới
            var div = document.createElement("div");
            div.style.marginTop = "5px";

            // Tạo input text mới
            var input = document.createElement("input");
            input.type = "text";
            input.name = "options"; // nếu muốn nhận nhiều option, có thể xử lý mảng trên server: options[]
            input.placeholder = "Nhập option";
            input.required = true;

            // Tạo nút xóa option (nếu cần)
            var btnRemove = document.createElement("button");
            btnRemove.type = "button";
            btnRemove.textContent = "Remove";
            btnRemove.onclick = function() {
                container.removeChild(div);
            };

            // Thêm input và button vào div
            div.appendChild(input);
            div.appendChild(btnRemove);

            // Thêm div vào container
            container.appendChild(div);
        }

        function toggleOptions() {
            var questionType = document.getElementById("questionType").value;
            var optionsSection = document.getElementById("optionsSection");
            if(questionType === "multiple_choice"){
                optionsSection.style.display = "block";
            } else {
                optionsSection.style.display = "none";
            }
        }

        window.onload = function() {
            toggleOptions();
        };
    </script>
</head>
<body>
<h2>Add New Question</h2>
<form action="${pageContext.request.contextPath}/manage-question" method="post" enctype="multipart/form-data">
    <!-- Dùng hidden field để xác định action -->
    <input type="hidden" name="action" value="add" />

    <label for="questionText">Câu hỏi:</label>
    <input type="text" name="questionText" id="questionText" required /><br/>

    <label for="questionType">Loại câu hỏi:</label>
    <select name="questionType" id="questionType" onchange="toggleOptions()">
        <option value="multiple_choice">Multiple Choice</option>
        <option value="fill_in_blank">Fill in Blank</option>
        <option value="audio">Audio</option>
    </select><br/>

    <!-- Phần nhập option chỉ hiển thị với Multiple Choice -->
    <div id="optionsSection" style="display:none; margin-top:20px;">
        <label>Options:</label>
        <div id="optionsContainer" name="optionsContainer">
            <!-- Mỗi option thêm vào sẽ đặt vào đây -->
        </div>
        <button type="button" onclick="addOption()">Add Option</button>
    </div><br/>

    <label for="correctAnswer">Đáp án đúng:</label>
    <input type="text" name="correctAnswer" id="correctAnswer" required /><br/>

    <label for="imageFile">Ảnh:</label>
    <input type="file" name="imageFile" id="imageFile" accept="image/*" /><br/>

    <label for="audioFile">Audio:</label>
    <input type="file" name="audioFile" id="audioFile" accept="audio/*" /><br/><br/>

    <input type="submit" value="Add Question" />
</form>

</body>
</html> 10px; }
    </style>
</head>
<body>
<h2>Add New Question</h2>
<form action="${pageContext.request.contextPath}/manage-question" method="post" enctype="multipart/form-data">
    <!-- Dùng hidden field để xác định action -->
    <input type="hidden" name="action" value="add" />

    <label for="questionText">Câu hỏi:</label>
    <input type="text" name="questionText" id="questionText" required /><br/>

    <label for="questionType">Loại câu hỏi:</label>
    <select name="questionType" id="questionType">
        <option value="multiple_choice">Multiple Choice</option>
        <option value="fill_in_blank">Fill in Blank</option>
        <option value="audio">Audio</option>
    </select><br/>

    <label for="correctAnswer">Đáp án đúng:</label>
    <input type="text" name="correctAnswer" id="correctAnswer" required /><br/>

    <label for="imageFile">Ảnh:</label>
    <input type="file" name="imageFile" id="imageFile" accept="image/*" /><br/>

    <label for="audioFile">Audio:</label>
    <input type="file" name="audioFile" id="audioFile" accept="audio/*" /><br/><br/>

    <input type="submit" value="Add Question" />
</form>
</body>
</html>
