<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Danh sách câu hỏi</title>
    <style>
        table { border-collapse: collapse; width: 80%; }
        table, th, td { border: 1px solid black; }
        th, td { padding: 8px; text-align: left; }
        .btn { text-decoration: none; background-color: #4CAF50; color: white; padding: 6px 12px; border-radius: 4px; }
    </style>
</head>
<body>
<h2>Danh sách câu hỏi</h2>
<!-- Nút Add New Question -->
<a href="${pageContext.request.contextPath}/manage-question?action=add" class="btn">Add New Question</a>
<br/><br/>
<table>
    <tr>
        <th>ID</th>
        <th>Câu hỏi</th>
        <th>Loại</th>
        <th>Đáp án</th>
        <th>Action</th>
    </tr>
    <c:forEach var="question" items="${questions}">
        <tr>
            <td>${question.id}</td>
            <td>${question.questionText}</td>
            <td>${question.questionType}</td>
            <td>${question.correctAnswer}</td>
            <td>
                <a href="${pageContext.request.contextPath}/manage-question?action=edit&id=${question.id}" title="Edit">edit</a>
                <a href="#"
                   onclick="confirmDeactive(${question.id})" title="deactive">delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
<script>
    function confirmDeactive(id) {
        if (confirm('Are you sure you want to deactivate this question?')) {
            window.location.href = '${pageContext.request.contextPath}/manage-question?action=deactive&id=' + id;
        }
    }
</script>
</body>
</html>
