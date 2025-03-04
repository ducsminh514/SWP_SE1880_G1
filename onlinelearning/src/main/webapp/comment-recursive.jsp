<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<div class="children">
    <c:forEach var="child" items="${childComments}">
        <div class="comment" style="margin-left: 30px; border-left: 2px solid #ddd; padding-left: 10px;">
            <div class="comment-body">
                <div class="comment-author vcard">
                    <img class="avatar photo" src="assets/images/testimonials/pic1.jpg" alt="">
                    <cite class="fn">User ${child.user.userName}</cite> <span class="says">says:</span>
                </div>
                <div class="comment-meta"> <a href="#">${child.createDate}</a> </div>
                <p>${child.content}</p>
                <div class="reply"> <a href="#" class="comment-reply-link">Reply</a> </div>
            </div>
            <c:if test="${not empty child.children}">
                <c:set var="childComments" value="${child.children}" scope="page"/>
                <jsp:include page="comment-recursive.jsp"/>
            </c:if>
        </div>
    </c:forEach>
</div>
