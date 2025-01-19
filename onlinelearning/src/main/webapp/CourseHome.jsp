<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.List" %>
<%@page import="Module.Course" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course List</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .card {
            margin-bottom: 20px;
        }
        .course-image {
            width: 150px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
        }
        .action-btns {
            margin-top: 10px;
        }
        .status {
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 15px;
        }
        .status-pending {
            background-color: #ffc107;
            color: white;
        }
        .status-active {
            background-color: #28a745;
            color: white;
        }
        .status-inactive {
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>
<body>

<div class="container mt-4">
    <!-- Search form -->
    <form action="courseManagement" method="get" class="mb-4 d-flex">
        <input type="text" name="txt" placeholder="Enter course name..." class="form-control w-50">
        <input type="submit" value="Search" class="btn btn-primary ml-2">
    </form>

    <!-- Filter by status -->
    <form action="courseManagement" method="get" class="mb-4">
        <select name="status" class="form-control w-25 d-inline-block">
            <option value="0">All Courses</option>
            <option value="1">Active Courses</option>
            <option value="2">Deactive Courses</option>
        </select>
        <input type="submit" value="Filter" class="btn btn-info ml-2">
    </form>

    <h1>Your Courses</h1>

    <div class="row">
        <%
            List<Course> courses = (List<Course>) request.getAttribute("aList");
            if (courses != null && !courses.isEmpty()) {
                for (Course c : courses) {
        %>
        <div class="col-md-6">
            <div class="card p-3">
                <div class="d-flex">
                    <img src="<%= c.getThumbnail() %>" class="course-image" alt="Course Thumbnail">
                    <div class="ml-3">
                        <h5 class="card-title"><%= c.getCourseName() %></h5>

                        <small class="text-muted">3 Categories | 3 Reviews ⭐⭐⭐⭐</small>
                    </div>
                </div>
                <p class="mt-2"><%= c.getDescription() %></p>
                <span class="status
                        <%= c.isStatus() ? "status-active" : "status-pending" %>">
                    <%= c.isStatus() ? "Active" : "Pending" %>
                </span>
                <div class="d-flex justify-content-between mt-2">
                    <h4 class="text-danger">$<%= c.getPrice() %></h4>
                    <div class="action-btns">
                        <form action="courseManagement" method="post" class="d-inline-block">
                            <input type="hidden" name="courseId" value="<%= c.getCourseId() %>">
                            <input type="submit" value="Approve" class="btn btn-success">
                        </form>
                        <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#confirmDeleteModal"
                                data-course-id="<%= c.getCourseId() %>" data-course-name="<%= c.getCourseName() %>">
                            Delete
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <div class="col-12">
            <p class="text-center">No courses available.</p>
        </div>
        <% } %>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="confirmDeleteModal" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="confirmDeleteModalLabel">Confirm Delete</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the course "<span id="courseName"></span>"?</p>
        <div class="form-check">
            <input type="checkbox" class="form-check-input" id="confirmCheckbox">
            <label class="form-check-label" for="confirmCheckbox">I confirm the deletion</label>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-danger" id="confirmDeleteBtn" disabled>Delete</button>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    // Show modal and populate course name and id
    $('#confirmDeleteModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var courseId = button.data('course-id');
        var courseName = button.data('course-name');
        var modal = $(this);
        modal.find('#courseName').text(courseName);

        // Enable delete button when checkbox is checked
        $('#confirmCheckbox').change(function() {
            if (this.checked) {
                $('#confirmDeleteBtn').prop('disabled', false);
            } else {
                $('#confirmDeleteBtn').prop('disabled', true);
            }
        });

        // Handle the delete action when confirmed
        $('#confirmDeleteBtn').click(function() {
            // Submit the delete form with the courseId
            var form = $('<form>', {
                'action': 'courseManagement',
                'method': 'post'
            }).append($('<input>', {
                'name': 'courseId',
                'value': courseId,
                'type': 'hidden'
            }));
            form.appendTo('body').submit();
        });
    });
</script>

</body>
</html>
