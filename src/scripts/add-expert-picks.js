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
		//changesMade.setAttribute("value",1);
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

addPickButton?.click(() => dialog?.open());


const addMovieButton = $("#addMovieButton");
const addMovieTitle = $("#addMovieTitle");
const addMovieYear = $("#addMovieYear");



addMovieButton?.click( ()=>{
	
	if( addMovieTitle.val()==""){
		addMovieYear.val("");
		showAlertWithTimer("Please enter movie title",time);
	}
	else if(addMovieYear.val() =="" ){
		addMovieTitle.val("");
		showAlertWithTimer("Please enter release date",time);
	}
	else {
        $.ajax({
            type: "POST",
            url: "/api/expert_picks/expert_pick",
            headers: {"X-CSRFToken": Cookies.get("csrftoken")},
            data: {
                title: addMovieTitle.val(),
				year : addMovieYear.val(),
            },
            success: (data) => {
				if (data.success==1){
					addExpertPick(data.message,data.picture,data.id,addMovieTitle.val(),addMovieYear.val());
					addMovieTitle.val("");
					addMovieYear.val("");
				}
				else showAlertWithTimer(data.message,time);

			}
        });
	}
});


const addExpertPickTemplate = $("#template-expert-pick");

function addExpertPick(message,picture, id,title,year){
	
	hiddenIDs = $(".hidden-id");
	for (var i = 0 ; i < hiddenIDs.length;i++){
		if (hiddenIDs[i].getAttribute("value")==id) {
			showAlertWithTimer("The movie is already on the list",time);
			return;
		}
	}
	
	const content = $(".expert-picks__content");
	var link = "https://image.tmdb.org/t/p/w1280";
	const newPick = addExpertPickTemplate.contents("div")[0].cloneNode(true);
	newPick.querySelector(".expert-pick-img").setAttribute("src", link+picture);
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