<%--
    Document   : update
    Created on : Feb 20, 2025, 12:47:41 AM
    Author     : Admin
--%>

<%@page import="Module.Subject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            .form-item {
                margin-bottom: 12px;
            }
        </style>
    </head>
    <body>
        <%
          ResultSet rsCourse = (ResultSet) request.getAttribute("rsCourse");
          Subject subject = (Subject) request.getAttribute("subject");
          int subjectId = (int) request.getAttribute("subjectId");
          String message = (String) request.getAttribute("message");
        %>
        <div class="container">
            <h1>Cập nhật</h1>
            <form action="updateUpdate" method="post">
                <input class="form-control" type="hidden" name="subjectId" value="<%=subjectId%>" />
                <div class="form-item">
                    <label for="courseName">Tên khóa học</label>
                    <input class="form-control" style="width: 100%" type="text" name="SubjectName" id="SubjectName" value="<%=subject.SubjectName()%>">
                </div>
                <div class="form-item">
                    <label for="description">Mô tả khóa học</label>
                    <input class="form-control" style="width: 100%" name="Description" id="Description" value="<%=subject.getDescription()%>">
                </div>
                <% if (message != null) {%>
                <h5><%=message%> </h5>
                <%}%>
                <button type="submit">Lưu</button>
            </form>
        </div>
    </body>
</html>
