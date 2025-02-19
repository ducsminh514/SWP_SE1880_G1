<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Thêm câu hỏi</title>
    <style>
        .option-input { margin-bottom: 5px; }
    </style>
</head>
<body>
<h2>Thêm câu hỏi trắc nghiệm</h2>
<form action="${pageContext.request.contextPath}/manage-question" method="post">
    <!-- Các thông tin của câu hỏi -->
    <div>
        <label for="questionText">Câu hỏi:</label>
        <input type="text" id="questionText" name="questionText" required>
    </div>
    <div>
        <label for="questionType">Loại câu hỏi:</label>
        <!-- Ở đây gắn giá trị multiple cho câu hỏi trắc nghiệm -->
        <select id="questionType" name="questionType">
            <option value="multiple">Multiple Choice</option>
            <option value="single">Single Choice</option>
        </select>
    </div>
    <br/>

    <!-- Container cho các option -->
    <div id="optionContainer">
        <label>Options:</label><br/>
        <input type="text" class="option-input" name="options" placeholder="Nhập option" required>
    </div>
    <button type="button" onclick="addOption()">Add Option</button>
    <br/><br/>

    <!-- Nút submit -->
    <button type="submit">Gửi câu hỏi</button>
</form>

<script type="text/javascript">
    function addOption() {
        // Tạo một input mới
        var input = document.createElement("input");
        input.type = "text";
        input.name = "options"; // tên giống nhau sẽ chuyển về dạng mảng phía servlet
        input.placeholder = "Nhập option";
        input.className = "option-input";

        // Thêm input vào container
        document.getElementById("optionContainer").appendChild(input);
    }
</script>
</body>
</html>

