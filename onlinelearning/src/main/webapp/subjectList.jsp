<%--
    Document   : list
    Created on : Feb 19, 2025, 5:22:40 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>

            .product-item {
                box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;
                padding: 12px;
            }
            img {
                width: 100%;
                height: 300px;
            }
            .title {
                font-size: 16px;
                font-weight: 600;
            }
            a {
                text-decoration: none;
                color: black;
            }

            .btn-update:hover {
                color: white;
            }

        </style>
    </head>
    <body>
        <%
          ResultSet rsCourse = (ResultSet) request.getAttribute("rsCourse");
          ResultSet rsSubject = (ResultSet) request.getAttribute("rsSubject");
          int totalPage = (int) request.getAttribute("totalPage");
          int currentPage = (int) request.getAttribute("currentPage");
        %>
        <div class="container" style="margin-top: 20px">
            <div class="row">
                <div class="col-12">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" id="textSearch" placeholder="Tìm kiếm theo tên" aria-label="Tìm kiếm theo tên" aria-describedby="button-addon2">
                        <button class="btn btn-outline-secondary" type="button" id="button-addon2">Button</button>
                    </div>
                </div>
                <div class="side_bar col-2">
                    <div class="menu">
                        <p class="title">Danh mục khóa học</p>
                        <%if(rsCourse != null) {%>
                        <ul class="list-group">
                            <li style="cursor: pointer" onclick="filterByCourseCategory()" class="list-group-item">
                                Tất cả
                            </li>
                            <%while (rsCourse.next()) {%>
                            <li style="cursor: pointer" onclick="filterByCourseCategory(<%=rsCourse.getInt("CourseID")%>)" class="list-group-item">
                                <%=rsCourse.getString("CourseName")%>
                            </li>
                            <%}%>
                        </ul>
                        <%} else {%>
                        <div>Không có dữ liệu</div>
                        <%}%>
                    </div>
                </div>
                    <div class="list_product row col-10" style="margin-bottom: 20px">
                    <% if (rsSubject != null) {
                        while (rsSubject.next()) {%>
                    <div class="col-md-3">
                        <div class="product-item">
                            <div class="product-item-content">
                                <p class="product-item-name"><%=rsSubject.getString("SubjectName")%></p>
                                <p class="product-item-name">Mô tả: <%=rsSubject.getString("Description")%></p>
                                <button onclick="navigateToUpdate(<%=rsSubject.getInt("CourseID")%>)" type="button" class="btn btn-outline-primary btn-update">
                                    Cập nhật
                                </button>
                            </div>
                        </div>
                    </div>
                    <%}
                    } else {%>
                    <div>Không có dữ liệu</div>
                    <%}%>
                    <%if (totalPage > 1) {%>
                    <div class="d-flex justify-content-center" style="margin-top: 30px">
                        <nav aria-label="...">
                            <ul class="pagination">
                                <%if (currentPage != 1) {%>
                                <li class="page-item" <%=currentPage == 1 ? "disabled" : ""%>>
                                    <a class="page-link" href="getListSubject?currentPage=<%=currentPage - 1%>">Previous</a>
                                </li>
                                <%}%>
                                <%for (int i = 1; i <= totalPage; i++) {%>
                                <li class="page-item <%= i == currentPage ? "active" : ""%>">
                                    <a class="page-link" href="getListSubject?currentPage=<%=i%>"><%=i%></a>
                                </li>
                                <%}%>
                                <%if (totalPage != 1 && currentPage < totalPage) {%>
                                <li class="page-item">
                                    <a class="page-link" href="getListSubject?currentPage=<%=currentPage + 1%>">Next</a>
                                </li>
                                <%}%>
                            </ul>
                        </nav>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            document.getElementById("button-addon2").addEventListener("click", function () {
                var textSearch = document.getElementById("textSearch").value;
                window.location.href = "getListSubject?textSearch=" + encodeURIComponent(textSearch);
            });
            const navigateToUpdate = (id) => {
                window.location.href = "updateUpdate?subjectId=" + id;
            }
            const filterByCourseCategory = (CourseID) => {
                if (!!CourseID) {
                    window.location.href = "getListSubject?courseId=" + CourseID;
                } else {
                    window.location.href = "getListSubject";
                }
            }
        </script>
    </body>
</html>
