<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/24/2025
  Time: 11:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Modal -->


<div class="modal fade" id="settingModal" tabindex="-1" role="dialog" aria-labelledby="settingModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="settingModalLabel">Setting</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="settingInPage" action="${pageContext.request.contextPath}/manage-question" method="get">
                    <div class="form-group">
                        <label for="NumberQuestionPerPage">Enter number of question:</label>
                        <input type="text" class="form-control" id="NumberQuestionPerPage" name="NumberQuestionPerPage">
                        <div id="nameError" class="error"></div>
                    </div>
                    <div class="form-group">
                    <label>Enter the columns you want to show:</label>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="optionChoice" value="idChoice"> ID
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="optionChoice" value="contentChoice"> Content
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="optionChoice" value="subjectChoice"> Subject
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="optionChoice" value="levelChoice"> Level
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="optionChoice" value="typeChoice"> Type
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="optionChoice" value="statusChoice"> Status
                        </label>
                    </div>
                </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <!-- Nút submit sẽ submit form thông qua thuộc tính form -->
                <button type="submit" class="btn btn-primary" form="settingInPage">Submit</button>
            </div>
        </div>
    </div>
</div>
