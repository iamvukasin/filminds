import { MDCDialog } from "@material/dialog";

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
    removeUserTextField.val("");
});