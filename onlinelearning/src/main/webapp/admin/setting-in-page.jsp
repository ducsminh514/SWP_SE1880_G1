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
                <form id="settingInPage" action="${paginationUrl}" method="get">
                    <input type="hidden" name="action" value="list"/>
                    <c:if test="${not empty param.subject}">
                        <input type="hidden" name="subject" value="${param.subject}"/>
                    </c:if>
                    <c:if test="${not empty param.level}">
                        <input type="hidden" name="level" value="${param.level}"/>
                    </c:if>
                    <c:if test="${not empty param.status}">
                        <input type="hidden" name="status" value="${param.status}"/>
                    </c:if>
                    <c:if test="${not empty param.search}">
                        <input type="hidden" name="search" value="${param.search}"/>
                    </c:if>
                    <c:if test="${not empty currentPage}">
                        <input type="hidden" name="page" value="${currentPage}"/>
                    </c:if>
                    <div class="form-group">
                        <label for="pageSize">Enter number of questions:</label>
                        <input type="text" class="form-control" id="pageSize" name="pageSize" value="${param.pageSize}">
                    </div>
                    <div class="form-group">
                        <label>Enter the columns you want to show:</label>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="optionChoice" value="idChoice"
                                    <% 
                                        String[] choices = request.getParameterValues("optionChoice");
                                        if (choices != null) {
                                            for (String choice : choices) {
                                                if ("idChoice".equals(choice)) {
                                                    out.print("checked");
                                                    break;
                                                }
                                            }
                                        }
                                    %>> ID
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="optionChoice" value="contentChoice"
                                    <% 
                                        if (choices == null) {
                                            choices = request.getParameterValues("optionChoice");
                                        }
                                        if (choices != null) {
                                            for (String choice : choices) {
                                                if ("contentChoice".equals(choice)) {
                                                    out.print("checked");
                                                    break;
                                                }
                                            }
                                        }
                                    %>> Content
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="optionChoice" value="subjectChoice"
                                    <% 
                                        if (choices == null) {
                                            choices = request.getParameterValues("optionChoice");
                                        }
                                        if (choices != null) {
                                            for (String choice : choices) {
                                                if ("subjectChoice".equals(choice)) {
                                                    out.print("checked");
                                                    break;
                                                }
                                            }
                                        }
                                    %>> Subject
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="optionChoice" value="levelChoice"
                                    <% 
                                        if (choices == null) {
                                            choices = request.getParameterValues("optionChoice");
                                        }
                                        if (choices != null) {
                                            for (String choice : choices) {
                                                if ("levelChoice".equals(choice)) {
                                                    out.print("checked");
                                                    break;
                                                }
                                            }
                                        }
                                    %>
                                > Level
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="optionChoice" value="typeChoice"
                                    <% 
                                        if (choices == null) {
                                            choices = request.getParameterValues("optionChoice");
                                        }
                                        if (choices != null) {
                                            for (String choice : choices) {
                                                if ("typeChoice".equals(choice)) {
                                                    out.print("checked");
                                                    break;
                                                }
                                            }
                                        }
                                    %>> Type
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="optionChoice" value="statusChoice"
                                    <% 
                                        if (choices == null) {
                                            choices = request.getParameterValues("optionChoice");
                                        }
                                        if (choices != null) {
                                            for (String choice : choices) {
                                                if ("statusChoice".equals(choice)) {
                                                    out.print("checked");
                                                    break;
                                                }
                                            }
                                        }
                                    %>> Status
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="optionChoice" value="actionChoice"
                                    <%
                                        if (choices == null) {
                                            choices = request.getParameterValues("actionChoice");
                                        }
                                        if (choices != null) {
                                            for (String choice : choices) {
                                                if ("actionChoice".equals(choice)) {
                                                    out.print("checked");
                                                    break;
                                                }
                                            }
                                        }
                                    %>> Action
                            </label>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary" form="settingInPage">Submit</button>
            </div>
        </div>
    </div>
</div>