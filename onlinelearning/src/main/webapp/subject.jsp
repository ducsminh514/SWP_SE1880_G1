<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Module.Course" %>
<html>
<head>
    <title>Danh sách khóa học</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>Danh sách khóa học</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Tên khóa học</th>
            <th>Mô tả</th>
            <th>Giá</th>
            <th>Trạng thái</th>
        </tr>
        <%
            ArrayList<Course> courses = (ArrayList<Course>) request.getAttribute("courses");
            if (courses != null) {
                for (Course c : courses) {
        %>
        <tr>
            <td><%= c.getCourseId() %></td>
            <td><%= c.getCourseName() %></td>
            <td><%= c.getDescription() %></td>
            <td><%= c.getPrice() %></td>
            <td><%= c.isStatus() ? "Hoạt động" : "Không hoạt động" %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="5">Không có khóa học nào.</td>
        </tr>
        <% } %>
    </table>
</body>
</html>
