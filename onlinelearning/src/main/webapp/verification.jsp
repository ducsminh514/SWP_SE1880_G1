<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Verify OTP</h2>
    <form action="verify" method="get">
        <label for="otp">Nhập OTP:</label>
        <input type="text" id="otp" name="otp" required>
        <input type="hidden" value="${requestScope.otp}" name="otpmail"/>
        <input type="hidden" value="${requestScope.email}" name="email"/>
        <button type="submit">Xác Minh</button>
    </form>

    <c:if test="${not empty errorMessage}">
        <p style="color:red;">${errorMessage}</p>
    </c:if>
    </body>
</html>