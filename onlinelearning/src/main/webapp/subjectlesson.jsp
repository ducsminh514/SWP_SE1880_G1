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
                margin: 15px auto;
                padding: 10px;
                background-color: #007bff;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 4px;
                text-align: center;
                width: 50%;
            }
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
            }
            .modal-content {
                background-color: white;
                margin: 5% auto;
                padding: 20px;
                border-radius: 8px;
                width: 400px;
                position: relative;
                animation: fadeIn 0.3s;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .close {
                position: absolute;
                right: 10px;
                top: 10px;
                cursor: pointer;
                font-size: 22px;
                font-weight: bold;
                color: #555;
            }
            .modal-content h3 {
                text-align: center;
            }
            .modal-content label {
                display: block;
                margin-top: 10px;
                font-weight: bold;
            }
            .modal-content input, .modal-content select {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .modal-content button {
                display: block;
                width: 100%;
                padding: 10px;
                margin-top: 15px;
                background-color: #007bff;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 4px;
            }
        </style>
        <script>
            function openModal() {
                document.getElementById('lessonModal').style.display = 'block';
            }
            function closeModal() {
                document.getElementById('lessonModal').style.display = 'none';
            }
            function submitLesson() {
                document.getElementById('lessonForm').submit();
            }

            function updateLessonStatus(lessonId, subjectID, status) {
                let form = document.createElement('form');
                form.method = 'POST';
                form.action = 'lesson-list';

                let lessonInput = document.createElement('input');
                lessonInput.type = 'hidden';
                lessonInput.name = 'lessonId';
                lessonInput.value = lessonId;
                form.appendChild(lessonInput);

                let subjectInput = document.createElement('input');
                subjectInput.type = 'hidden';
                subjectInput.name = 'subjectID';
                subjectInput.value = subjectID;
                form.appendChild(subjectInput);

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
                                       onchange="updateLessonStatus('${lesson.lessonID}', '${lesson.subjectID}', this.checked ? '1' : '2')">
                                <span class="slider"></span>
                            </label>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <button class="add-btn" onclick="openModal()">Add New Lesson Button</button>
            <!-- Modal -->
            <div id="lessonModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <h3>Add New Lesson</h3>
                    <form id="lessonForm" action="addLesson" method="POST">
                        <input type="hidden" name="subjectID" value="${subjectID}">

                        <label>Lesson Name:</label>
                        <input type="text" name="lessonName" required>

                        <label>Content:</label>
                        <textarea name="content" rows="3" required style="width:100%;"></textarea>

                        <label>Duration (minutes):</label>
                        <input type="number" name="duration" required>

                        <label>Order No:</label>
                        <input type="number" name="orderNo" required>

                        <label>Status:</label>
                        <select name="statusLesson">
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>

                        <label>Video URL:</label>
                        <input type="url" name="videoUrl">

                        <button type="button" onclick="submitLesson()">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>