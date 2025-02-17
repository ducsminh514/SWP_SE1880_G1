<%--
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
</head>
<body>
<h2>Add New Question</h2>
<form action="${pageContext.request.contextPath}/manage-question" method="post" enctype="multipart/form-data">
    <!-- Dùng hidden field để xác định action -->
    <input type="hidden" name="action" value="add" />

    <label for="questionText">Câu hỏi:</label>
    <input type="text" name="questionText" id="questionText" required /><br/>

    <labelzzzzzzzz for="questionType">Loại câu hỏi:</labelzzzzzzzz>
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
