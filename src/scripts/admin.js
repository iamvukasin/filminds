import { MDCDialog } from "@material/dialog";
import * as Cookies from "js-cookie";

const dialogs = document.querySelector(".mdc-dialog");
var dialog = null;
const addExpertButton = $("#add-expert-button");
const time = 300;

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
		var expertUsername = $(".expertUsername");
        $.ajax({
            type: "POST",
            url: "/api/admin_dashboard/remove_expert",
            headers: {"X-CSRFToken": Cookies.get("csrftoken")},
            data: {
                message: expertUsername[index].innerHTML
            },
        });
        $(experts[index]).remove();
    }
}

var deleteButtons = $(".remove-expert");
const removeUserButton = $(".remove-user");
const removeUserTextField = $("#remove-user-text-field");

deleteButtons.each((i, obj) => obj.onclick = deleteButtonClick(obj));

removeUserButton?.click(() => {
	
	if( removeUserTextField.val()==""){
		showAlert("Please enter valid data");
	}
	else{
        $.ajax({
            type: "POST",
            url: "/api/admin_dashboard/delete_user",
            headers: {"X-CSRFToken": Cookies.get("csrftoken")},
            data: {
                message: removeUserTextField.val()
            },
            success: (data) => showAlert(data.message)
        });
	    removeUserTextField.val("");
	}
});

const confirmExpertButton = $("#confirmExpertButton");
const addExpertTextField = $("#expertInput");
const categoryTextField = $("#categoryInput");
const addExpertTemplate = $("#template-expert");

confirmExpertButton?.click( ()=>{
	if( addExpertTextField.val()==""){
		showAlertWithTimer("Please enter username or email",time);
	}
	else if(categoryTextField.val() =="" ){
		showAlertWithTimer("Please choose category",time);
	}
	else {
        $.ajax({
            type: "POST",
            url: "/api/admin_dashboard/add_expert",
            headers: {"X-CSRFToken": Cookies.get("csrftoken")},
            data: {
                expert: addExpertTextField.val(),
				category : categoryTextField.val(),
            },
            success: (data) => {
				if (data.success == 0)
					showAlertWithTimer(data.message,time);
				else{
					const content = $(".expert__content");
					const newPick = addExpertTemplate.contents("div")[0].cloneNode(true);
					newPick.querySelector(".expertName").innerText = data.firstName + " " + data.lastName;
					newPick.querySelector(".expertUsername").innerText = data.username;
					newPick.querySelector(".expertEmail").innerText = data.email;
					newPick.querySelector(".expertCategory").innerText = data.category;
					content.append(newPick);
					deleteButtons = $(".remove-expert");
					deleteButtons.each((i, obj) => obj.onclick = deleteButtonClick(obj));
				}
			}
        });
	}
	
	addExpertTextField.val("");
	categoryTextField.val("");
});

function showAlert(str){
	alert(str);
}
function showAlertWithTimer(str,time){
	setTimeout(function() { alert(str); }, time);
}