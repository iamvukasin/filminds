import { MDCDialog } from "@material/dialog";

const dialogs = document.querySelector(".mdc-dialog");
const dialog = null;
const addExpertButton = $("#add-expert-button");

if (dialogs) {
	dialog = new MDCDialog(dialogs);
}

addExpertButton?.click(() => dialog?.open());
