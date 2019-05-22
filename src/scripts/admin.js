import { MDCDialog } from "@material/dialog";
import * as Cookies from "js-cookie";

const dialogs = document.querySelector(".mdc-dialog");
var dialog = null;
const addExpertButton = $("#add-expert-button");

if (dialogs) {
	dialog = new MDCDialog(dialogs);
}

addExpertButton?.click(() => dialog?.open());

function deleteButtonClick(element) {
    return function () {
        var index = $(".remove-expert")?.index(element);
        var experts = $(".expert-content");

        if (!experts)
            return;

        $(experts[index]).remove();
    }
}

const deleteButtons = $(".remove-expert");
const removeUserButton = $(".remove-user");
const removeUserTextField = $("#remove-user-text-field");

deleteButtons.each((i, obj) => obj.onclick = deleteButtonClick(obj));

removeUserButton?.click(() => {
	
	if( removeUserTextField.val()==""){
		alert("Please enter valid data");
	}
	else{
        $.ajax({
            type: "POST",
            url: "/api/admin_dashboard/delete_user",
            headers: {"X-CSRFToken": Cookies.get("csrftoken")},
            data: {
                message: removeUserTextField.val()
            },
            success: (data) => alert(data.message)
        });
	    removeUserTextField.val("");
	}
});



