<!DOCTYPE html>
<html lang="en">
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<head><!-- META ============================================= -->
      	<meta charset="utf-8">
      	<meta http-equiv="X-UA-Compatible" content="IE=edge">
      	<meta name="keywords" content="" />
      	<meta name="author" content="" />
      	<meta name="robots" content="" />

      	<!-- DESCRIPTION -->
      	<meta name="description" content="EduChamp : Education " />

      	<!-- OG -->
      	<meta property="og:title" content="EduChamp : Education " />
      	<meta property="og:description" content="EduChamp : Education " />
      	<meta property="og:image" content="" />
      	<meta name="format-detection" content="telephone=no">

      	<!-- FAVICONS ICON ============================================= -->
      	<link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
      	<link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

      	<!-- PAGE TITLE HERE ============================================= -->
      	<title>EduChamp : Education  </title>

      	<!-- MOBILE SPECIFIC ============================================= -->
      	<meta name="viewport" content="width=device-width, initial-scale=1">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Page</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { display: flex; }
        .question-box { flex: 3; border: 2px solid black; padding: 20px; margin-right: 20px; }
        .quiz-nav { flex: 1; border: 2px solid black; padding: 10px; }
        .question-title { font-weight: bold; font-size: 20px; }
        .answer-box label { display: block; margin-top: 5px; }
        .next-button { margin-top: 20px; padding: 10px; background-color: red; color: white; border: none; cursor: pointer; }
        .quiz-nav button { width: 30px; height: 30px; margin: 3px; cursor: pointer; }
        .page-link {
            display: inline-block;
            padding: 10px;
            border: 1px solid #000;
            width: 35px;
            height: 35px;
            text-align: center;
            line-height: 15px;
            text-decoration: none;
            color: #000;           /* Chữ màu đen */
            background-color: #ccc; /* Nền màu xám */
            border-radius: 0;      /* Loại bỏ góc bo tròn để tạo ô vuông */
            margin: 5px;
        }
        .pagination-container {
            display: flex;
            flex-wrap: wrap; /* Tự động xuống dòng khi đầy hàng */
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .pagination-container .page-item {
            margin: 5px; /* Khoảng cách giữa các nút */
        }

        /* Ví dụ: mỗi hàng hiển thị tối đa 10 item */
        .pagination-container .page-item {
            flex: 0 0 calc(10% - 10px); /* chỉnh % theo số mục bạn muốn trên một hàng */
            text-align: center;
        }



    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="container">
    <div class="question-box">
     <form action="quiz" method="post"id="quizForm">
     <h5>${requestScope.error}<h5>
<input type="hidden" name="id" value="${requestScope.id}">
     <c:forEach items="${requestScope.listQuestion}" var="list">
        <div class="question-title">Question: ${list.content}</div>
            <div class="answer-box">
        <c:if test="${not empty list.questionImage}">
            <img style="width: 200px; height: 200px" src="${list.questionImage}" />
        </c:if>
                    <c:if test="${list.questionType.questionTypeId == 1}">
                        <c:forEach var="ans" items="${requestScope.listans}">
                            <c:if test="${list.questionId ==ans.questionId}">
                                <label>
                                <input type="radio" name="radio" value="${ans.answerId}"> ${ans.content}
                                </label>
                            </c:if>
                        </c:forEach>
                    </c:if>
                     <c:if test="${list.questionType.questionTypeId == 2}">
                        <label>Answer: <input type="text" name="answertext"/></label>
                       <label>Images:
                           <input type="file" name="images_${list.questionId}" multiple accept="image/*" onchange="previewImages()"/>
                       </label>
                         <br>
                         <div id="imagePreview"></div>
                         <br>
                   </c:if>

              </div>
        </c:forEach>
            <button id="finishButton" type="submit" style="margin-top:15px;background-color:red;color:white;border:none;padding:10px;">
                Finish attempt
            </button>
        </form>
    </div>

    <div class="quiz-nav">
        <strong>Quiz Navigation</strong><br>
         <ul class="pagination-container">
             <c:forEach begin="1" end="${requestScope.num}" var="i">
                 <li class="page-item">
                     <a class="page-link m-lg-1">
                         ${i}
                     </a>
                 </li>
             </c:forEach>
         </ul>


        <p>Time left: <strong id="time"></strong></p>
    </div>
</div>
<br>
<br>
<br>
<br>
<br>
<jsp:include page="footer.jsp"/>
 <script type="text/javascript">
         window.onload = function() {
             // Lấy giá trị TimeLimit từ request (giả sử giá trị là 5 phút)
             var timeLimitInMinutes = ${lessonQuiz.timeLimit};  // Ví dụ: 5 phút
             var timeLimitInSeconds = timeLimitInMinutes * 60; // Chuyển đổi sang giây

             // Hiển thị TimeLimit ban đầu (chuyển đổi từ giây sang phút và giây)
             function formatTime(seconds) {
                 var minutes = Math.floor(seconds / 60);
                 var remainingSeconds = seconds % 60;
                 return minutes + "m " + remainingSeconds + "s";
             }

             document.getElementById("time").innerText = formatTime(timeLimitInSeconds);

             // Đếm ngược
             var countdown = setInterval(function() {
                 timeLimitInSeconds--; // Giảm giá trị thời gian đi 1 giây
                 document.getElementById("time").innerText = formatTime(timeLimitInSeconds);

                 // Nếu thời gian hết, dừng đếm ngược và nộp bài
                 if (timeLimitInSeconds <= 0) {
                     clearInterval(countdown);
                     alert("Time's up! Your quiz will be submitted.");

                     // Gửi form tự động khi hết thời gian
                     document.getElementById("quizForm").submit();  // Gửi form nộp bài
                 }
             }, 1000);  // Mỗi giây (1000ms) đếm ngược 1 lần
         };
     </script>

<script>
  function previewImages() {
    const preview = document.getElementById('imagePreview');
    preview.innerHTML = ''; // Xóa các hình ảnh đã hiển thị trước đó

    const files = document.querySelector('input[type="file"]').files;
    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      const reader = new FileReader();

      reader.onload = function(e) {
        // Tạo phần tử chứa hình ảnh và ô nhập chú thích
        const container = document.createElement('div');
        container.style.marginBottom = '20px';

        const img = document.createElement('img');
        img.src = e.target.result;
        img.style.maxWidth = '200px'; // Giới hạn kích thước hình ảnh
        img.style.marginRight = '10px'; // Thêm khoảng cách giữa hình ảnh và chú thích

        const captionInput = document.createElement('input');
        captionInput.type = 'text';
        captionInput.placeholder = 'Enter caption for this ';
        captionInput.name = 'captions[]'; // Gửi các chú thích dưới dạng mảng

        container.appendChild(img);
        container.appendChild(captionInput);

        preview.appendChild(container); // Thêm phần tử vào div preview
      }

      reader.readAsDataURL(file);
    }
  }
</script>
</body>
</html>
