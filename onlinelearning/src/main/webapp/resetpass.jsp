<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Đặt lại mật khẩu</h2>
    <form method="get" action="reset">
        <label for="newPassword">Mật khẩu mới:</label>
        <input type="password" id="newPassword" name="newPassword" required><br><br>
        <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required><br><br>
        <input type="hidden" value="${requestScope.email}" name="email"/>
        <button type="submit">Đặt lại mật khẩu</button>
    </form>

    <%-- Hiển thị thông báo nếu có --%>
    <c:if test="${not empty errorMessage}">
        <p style="color:red;">${errorMessage}</p>
    </c:if>

    <c:if test="${not empty successMessage}">
        <p style="color:green;">${successMessage}</p>
    </c:if>
    </body>
</html>