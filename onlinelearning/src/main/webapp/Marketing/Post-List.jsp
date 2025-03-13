<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:10:19 GMT -->
    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">


        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp : Education HTML Template </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <jsp:include page="marketing-css.jsp"></jsp:include>
        <style>
            /* CSS for styling the table */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            table, th, td {
                border: 1px solid #ddd;
            }

            th, td {
                padding: 12px;
                text-align: left;
            }

            th {
                background-color: #4CAF50;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #ddd;
            }

            .container {
                width: 80%;
                margin: 0 auto;
            }

            .post-title {
                font-size: 24px;
                color: #333;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->
        <jsp:include page="HeaderMarketing.jsp"></jsp:include>
            <!-- header end -->

            <!-- Left sidebar menu start -->
        <jsp:include page="LeftSideMarketing.jsp"></jsp:include>
            <!-- Left sidebar menu end -->

            <!--Main container start -->
            <main class="ttr-wrapper">
                <div class="container-fluid">
                    <div class="db-breadcrumb">
                        <h4 class="breadcrumb-title">Courses</h4>
                        <ul class="db-breadcrumb-list">
                            <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                            <li>Post-List</li>
                        </ul>
                    </div>
                    <div class="row">
                        <!-- Your Profile Views Chart -->
                        <div class="col-lg-12 m-b30">
                            <div class="widget-box">
                            <button type="button" class="btn btn-primary">
                            <a href="addNewPost">Add new</a></button>
                                <div class="wc-title">
                                    <h4>Post-List</h4>
                                </div>
                               <div class="widget-inner">
                                   <table class="table table-bordered table-striped">
                                       <thead>
                                           <tr>
                                               <th>Title</th>
                                               <th>Thumbnail</th>
                                               <th>Create Date</th>
                                               <th>Update Date</th>
                                               <th>Status</th>
                                               <th>Post File</th>
                                               <th>Views</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                           <c:forEach items="${requestScope.listPost}" var="post">
                                               <tr>
                                                   <td>${post.title}</td>
                                                   <td><img src="${post.thumbnail}" alt="Post Thumbnail" style="width: 100px; height: 100px;"></td>
                                                   <td>${post.createDate}</td>
                                                   <td>${post.updateDate}</td>
                                                   <td>${post.status}</td>
                                                   <td>${post.postFile}</td>
                                                   <td>
                                                       <a href="postDetail?postId=${post.postId}">Detail </a>
                                                   </td>
                                               </tr>
                                           </c:forEach>
                                       </tbody>
                                   </table>
                               </div>

                        </div>
                    </div>
                    <!-- Your Profile Views Chart END-->
                </div>
            </div>
        </main>
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
        <jsp:include page="marketing-js.jsp"></jsp:include>

    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
