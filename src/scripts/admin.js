import { MDCDialog } from "@material/dialog";

const dialog = new MDCDialog(document.querySelector(".mdc-dialog"));
const addExpertButton = $("#add-expert-button");

addExpertButton?.click(() => dialog.open());
