<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/23/2025
  Time: 4:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade" id="delete-product-modal" tabindex="-1" role="dialog" aria-labelledby="delete-modal-label" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <!-- Modal Header với màu nền cảnh báo -->
            <div class="modal-header bg-warning text-dark">
                <h5 class="modal-title" id="delete-modal-label">Confirm deactive</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- Modal Body -->
            <div class="modal-body">
                <p>Do you want deactive this setting?</p>
            </div>
            <!-- Modal Footer -->
            <div class="modal-footer">
                <form action="${pageContext.request.contextPath}/manage-setting?action=deactive" method="POST">
                    <div class="form-group d-none">
                        <input type="text" class="form-control" id="idDeleteInput" name="id" value="${setting.settingId}">
                    </div>
                    <div class="form-group" style="display: flex; gap: 10px; width: 100%;">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" style="min-width: 50px">No</button>
                        <button type="submit" class="btn btn-danger" style="min-width: 50px">Yes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    function deleteSettingModel(id) {
        let inputId = document.querySelector("#idDeleteInput");
        inputId.value = id;
    }
</script>