
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<c:forEach var="child" items="${childComments}">
    <li class="comment odd parent">
        <div class="comment-body">
            <div class="comment-author vcard">
                <img class="avatar photo" src="assets/images/testimonials/pic1.jpg" alt="">
                <cite class="fn"> ${child.user.userName}</cite> <span class="says">says:</span>
            </div>
            <div class="comment-meta"> <a href="#">${child.createDate}</a> </div>
            <p>${child.content}</p>
            <div class="reply">
                <a  class="comment-reply-link" onclick="toggleReplyBox(event, this)">Reply</a>
            </div>
            <form action="addCommentPost">
                <div class="reply-box" style="display: none; margin-top: 10px; margin-bottom : 10px">
                    <input type="hidden" name="parentId" value="${child.parentId}">
                    <input type="hidden" name="postId" value="${child.post.postId}">
                    <textarea placeholder="Nhập nội dung bình luận" rows="3" name="content"></textarea>
                    <button type="submit" class="submit-reply">Gửi</button>
                </div>
            </form>
        </div>
        <ol class="children">
            <c:if test="${not empty child.children}">
                <c:set var="childComments" value="${child.children}" scope="request"/>
                <jsp:include page="comment-recursive.jsp"/>
            </c:if>
        </ol>
    </li>
</c:forEach>
