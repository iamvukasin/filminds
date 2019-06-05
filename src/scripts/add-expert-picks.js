import { MDCDialog } from "@material/dialog";
import * as Cookies from "js-cookie";

const allDialogs = document.querySelector(".mdc-dialog");
var dialog = null;
var expertPicksUpButtons = $(".expert-pick__up");
var expertPicksDownButtons = $(".expert-pick__down");
var expertPicksDeleteButtons = $(".expert-pick__delete");
var hiddenIDs = $(".hidden-id");

const addPickButton = $("#add-pick-button");
const addExpertButton = $("#add-expert-button");
const savePicksButton = $("#save-picks-button");
const changesMade = $("#changes-made");
const picksCode = $("#picks-code");
const time = 300;
const addMovieButton = $("#addMovieButton");
const addMovieTitle = $("#addMovieTitle");
const addExpertPickTemplate = $("#template-expert-pick");

function replaceMovieTitle(element, index, promote) {
    var movieTitle = $(element).find(".movie-title h3");
    var newIndex = (promote ? index : index + 2);
    movieTitle?.text(movieTitle.text().replace(/^\d+\./, newIndex + "."));
}

function onUpButtonClick(element) {
    return function () {
        var index = $(".expert-pick__up")?.index(element);
        var expertPicks = $(".expert-pick");
		if (index>0)changesMade.val(1);
        if (expertPicks && index > 0) {
            replaceMovieTitle(expertPicks[index], index, true);
            replaceMovieTitle(expertPicks[index - 1], index - 1, false);
            $(expertPicks[index]).insertBefore($(expertPicks[index - 1]));
        }
    }
}

function onDownButtonClick(element) {
    return function () {
        var index = $(".expert-pick__down")?.index(element);
        var expertPicks = $(".expert-pick");
		if (index<expertPicks.length-1) changesMade.val(1);
        if (expertPicks && index < expertPicks.length - 1) {
            replaceMovieTitle(expertPicks[index], index, false);
            replaceMovieTitle(expertPicks[index + 1], index + 1, true);
            $(expertPicks[index]).insertAfter($(expertPicks[index + 1]));
        }
    }
}

function onDeleteButtonClick(element) {
    return function () {
		changesMade.val(1);
        var index = $(".expert-pick__delete")?.index(element);
        var expertPicks = $(".expert-pick");
        if (!expertPicks)
            return;
        for (var i = index + 1; i < expertPicks.length; i++) {
            replaceMovieTitle(expertPicks[i], i, true);
        }
        $(expertPicks[index]).remove();
		expertPicksUpButtons = $(".expert-pick__up");
		expertPicksDownButtons = $(".expert-pick__down");
		expertPicksDeleteButtons = $(".expert-pick__delete");
		hiddenIDs = $(".hidden-id");
    }
}

function onAddButtonClick() {
    addMovieDialog.open();
}

expertPicksUpButtons.each((i, obj) => obj.onclick = onUpButtonClick(obj));
expertPicksDownButtons.each((i, obj) => obj.onclick = onDownButtonClick(obj));
expertPicksDeleteButtons.each((i, obj) => obj.onclick = onDeleteButtonClick(obj));

if (allDialogs) {
    dialog = new MDCDialog(allDialogs);
}

addPickButton?.click(() => {
	autocomplete(document.getElementById("addMovieTitle"), null);
	dialog?.open();
});

addMovieButton?.click( ()=>{
	if( addMovieTitle.val()==""){
		addMovieYear.val("");
		showAlertWithTimer("Please enter movie title",time);
	}
	else {
        $.ajax({
            type: "POST",
            url: "/api/expert_picks/expert_pick",
            headers: {"X-CSRFToken": Cookies.get("csrftoken")},
            data: {
                title: addMovieTitle.val()
            },
            success: (data) => {
				if (data.success==1){
					addExpertPick(data.message,data.picture,data.id,addMovieTitle.val(),data.year);
					addMovieTitle.val("");
				}
				else showAlertWithTimer(data.message,time);
			}
        });
	}
});

function addExpertPick(message,picture, id,title,year){
	hiddenIDs = $(".hidden-id");
	for (var i = 0 ; i < hiddenIDs.length;i++){
		if (hiddenIDs[i].getAttribute("value")==id) {
			showAlertWithTimer("The movie is already on the list",time);
			return;
		}
	}
	const content = $(".expert-picks__content");
	const newPick = addExpertPickTemplate.contents("div")[0].cloneNode(true);
	newPick.querySelector(".expert-pick-img").setAttribute("src", picture);
	var expertPicks = $(".expert-pick"); 
	var index = expertPicks.length+1;
    newPick.querySelector(".expert-pick-header").innerText = index+". "+title+ " ("+ year+ ") ";
	newPick.querySelector(".hidden-id").setAttribute("value", id);
	content.append(newPick);
	changesMade.val(1);
	expertPicksUpButtons = $(".expert-pick__up");
	expertPicksDownButtons = $(".expert-pick__down");
	expertPicksDeleteButtons = $(".expert-pick__delete");
	hiddenIDs = $(".hidden-id");
	expertPicksUpButtons.each((i, obj) => obj.onclick = onUpButtonClick(obj));
	expertPicksDownButtons.each((i, obj) => obj.onclick = onDownButtonClick(obj));
	expertPicksDeleteButtons.each((i, obj) => obj.onclick = onDeleteButtonClick(obj));
}


savePicksButton?.click( ()=>{
	if (changesMade.val()==0){
		showAlert("There are no changes");
		return;
	}
	var str = "";
	hiddenIDs = $(".hidden-id");
	for (var i = 0; i < hiddenIDs.length;i++) { 
		str+=hiddenIDs[i].getAttribute("value")+",";
	}
	if (picksCode.val()==str) {
		showAlert("There are no changes");
		return;
	}
	hiddenIDs = $(".hidden-id");
	if(hiddenIDs.length==0) showAlert("There are no movies to save");
	else{
		str = "";
		for (var i = 0; i < hiddenIDs.length-1;i++) { 
			str+=hiddenIDs[i].getAttribute("value")+",";
		}
		str+=hiddenIDs[hiddenIDs.length-1].getAttribute("value");
        $.ajax({
            type: "POST",
            url: "/api/expert_picks/save_picks",
            headers: {"X-CSRFToken": Cookies.get("csrftoken")},
            data: {
                message: str,
            },
            success: (data) => {
				showAlert(data.message);
				changesMade.val(data.changes);
				var str = "";
				hiddenIDs = $(".hidden-id");

				for (var i = 0; i < hiddenIDs.length;i++) { 
					str+=hiddenIDs[i].getAttribute("value")+",";
				}
				picksCode.val(str);
			}
        });
	}
});

function showAlert(str){
	alert(str);
}
function showAlertWithTimer(str,time){
	setTimeout(function() { alert(str); }, time);
}

var ajax_process = 0;
var global_arr = null;
function autocomplete(inp, arr) {
	var currentFocus;
	inp.addEventListener("input", function(e) {
		var a, b, i, val = this.value;
		closeAllLists();
		if (!val) { return false;}
		currentFocus = -1;
        a = document.createElement("DIV");
        a.setAttribute("id", this.id + "autocomplete-list");
        a.setAttribute("class", "autocomplete-items");
        this.parentNode.appendChild(a);
		if (val.length>=4 && ajax_process==0){	
			ajax_process = 1;
			$.ajax({
				type: "POST",
				url: "/api/expert-picks/autosuggest",
				headers: {"X-CSRFToken": Cookies.get("csrftoken")},
				data: {
					title: val.toLowerCase(),
				},
				success: (data) => {
					arr = data.message;
					global_arr = [...arr];
					for (i = 0; i < arr.length; i++) {
						if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
							b = document.createElement("DIV");
							b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
							b.innerHTML += arr[i].substr(val.length);
							b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
							b.addEventListener("click", function(e) {
								inp.value = this.getElementsByTagName("input")[0].value;
								closeAllLists();
							});
							a.appendChild(b);
						}
					}
					ajax_process = 0;
				}
			});
		}	
		else{
			arr = global_arr;
			for (i = 0; i < arr.length; i++) {
				if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
					b = document.createElement("DIV");
					b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
					b.innerHTML += arr[i].substr(val.length);
					b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
					b.addEventListener("click", function(e) {
						inp.value = this.getElementsByTagName("input")[0].value;
						closeAllLists();
					});
					a.appendChild(b);
				}
			}
		}
      
	});
	inp.addEventListener("keydown", function(e) {
		var x = document.getElementById(this.id + "autocomplete-list");
		if (x) x = x.getElementsByTagName("div");
		if (e.keyCode == 40) {
			currentFocus++;
			addActive(x);
		} else if (e.keyCode == 38) {
			currentFocus--;
			addActive(x);
		} else if (e.keyCode == 13) {
			e.preventDefault();
			if (currentFocus > -1) {
				if (x) x[currentFocus].click();
			}
		}
	});
function addActive(x) {
    if (!x) return false;
    removeActive(x);
    if (currentFocus >= x.length) currentFocus = 0;
    if (currentFocus < 0) currentFocus = (x.length - 1);
    x[currentFocus].classList.add("autocomplete-active");
}
function removeActive(x) {
    for (var i = 0; i < x.length; i++) {
      x[i].classList.remove("autocomplete-active");
    }
}
function closeAllLists(elmnt) {
    var x = document.getElementsByClassName("autocomplete-items");
    for (var i = 0; i < x.length; i++) {
		if (elmnt != x[i] && elmnt != inp) {
			x[i].parentNode.removeChild(x[i]);
		}
	}
}
document.addEventListener("click", function (e) {
    closeAllLists(e.target);
	});
}