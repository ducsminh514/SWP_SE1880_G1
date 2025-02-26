<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Subject Lessons</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 600px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 34px;
            height: 20px;
        }
        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 20px;
        }
        .slider:before {
            position: absolute;
            content: "";
            height: 14px;
            width: 14px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        input:checked + .slider {
            background-color: #007bff;
        }
        input:checked + .slider:before {
            transform: translateX(14px);
        }
        .add-btn {
            display: block;
            margin-top: 10px;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            text-align: center;
        }
    </style>
    <script>
        function updateLessonStatus(lessonId, packageID, status) {
            let form = document.createElement('form');
            form.method = 'POST';
            form.action = 'lesson-list';
            
            let lessonInput = document.createElement('input');
            lessonInput.type = 'hidden';
            lessonInput.name = 'lessonId';
            lessonInput.value = lessonId;
            form.appendChild(lessonInput);
            
            let packageInput = document.createElement('input');
            packageInput.type = 'hidden';
            packageInput.name = 'packageID';
            packageInput.value = packageID;
            form.appendChild(packageInput);
            
            let statusInput = document.createElement('input');
            statusInput.type = 'hidden';
            statusInput.name = 'status';
            statusInput.value = status;
            form.appendChild(statusInput);
            
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</head>
<body>
    <div class="container">
        <h2 style="text-align: center;">Subject Lessons</h2>
        <table>
            <tr>
                <th>Lesson Name</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            <c:forEach var="lesson" items="${lessons}">
                <tr>
                    <td>${lesson.lessonName}</td>
                    <td>${lesson.status ? "Active" : "Inactive"}</td>
                    <td>
                        <a href="#">[View details]</a>
                        <label class="toggle-switch">
                            <input type="checkbox" ${lesson.status ? "checked" : ""} 
                                onchange="updateLessonStatus('${lesson.lessonID}', '${lesson.packageID}', this.checked ? '1' : '2')">
                            <span class="slider"></span>
                        </label>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <button class="add-btn">Add New Lesson Button</button>
    </div>
</body>
</html>