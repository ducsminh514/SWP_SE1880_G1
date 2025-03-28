<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
     <!-- META ============================================= -->
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
            <title>EduChamp : Education HTML Template </title>

            <!-- MOBILE SPECIFIC ============================================= -->
            <meta name="viewport" content="width=device-width, initial-scale=1">

            <!--[if lt IE 9]-->
            <style>
                    /* Basic reset for margin and padding */


                    h1 {
                        text-align: center;
                        font-size: 2.5em;
                        color: #2c3e50;
                        margin-bottom: 20px;
                    }

                </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<br>
<br>
<br>

<div class="container">
    <h1>Your Quiz Result</h1>

    <div class="result-summary">
        <h3>Score: ${score}</h3>
        <p>Total questions: ${num}</p>
    </div>

    <div class="finish-button">
        <a href="index.jsp" class="btn">Go Back to Home</a>
    </div>
</div>
<br>
<br>
<br>
<br>
<br>


<jsp:include page="footer.jsp"/>
</body>
</html>
