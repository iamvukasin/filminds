import { MDCDialog } from "@material/dialog";

function replaceMovieTitle(element, index, promote) {
    var movieTitle = $(element).find(".movie-title h3");
    var newIndex = (promote ? index : index + 2);
    movieTitle?.text(movieTitle.text().replace(/^\d+\./, newIndex + "."));
}

function onUpButtonClick(element) {
    return function () {
        var index = $(".expert-pick__up")?.index(element);
        var expertPicks = $(".expert-pick");

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

        if (expertPicks && index < expertPicks.length - 1) {
            replaceMovieTitle(expertPicks[index], index, false);
            replaceMovieTitle(expertPicks[index + 1], index + 1, true);
            $(expertPicks[index]).insertAfter($(expertPicks[index + 1]));
        }
    }
}

function onDeleteButtonClick(element) {
    return function () {
        var index = $(".expert-pick__delete")?.index(element);
        var expertPicks = $(".expert-pick");

        if (!expertPicks)
            return;

        for (var i = index + 1; i < expertPicks.length; i++) {
            replaceMovieTitle(expertPicks[i], i, true);
        }
        $(expertPicks[index]).remove();
    }
}

function onAddButtonClick() {
    addMovieDialog.open();
}

const allDialogs = document.querySelector(".mdc-dialog");
var dialog = null;
const expertPicksUpButtons = $(".expert-pick__up");
const expertPicksDownButtons = $(".expert-pick__down");
const expertPicksDeleteButtons = $(".expert-pick__delete");
const addPickButton = $("#add-pick-button");
const addExpertButton = $("#add-expert-button");

expertPicksUpButtons.each((i, obj) => obj.onclick = onUpButtonClick(obj));
expertPicksDownButtons.each((i, obj) => obj.onclick = onDownButtonClick(obj));
expertPicksDeleteButtons.each((i, obj) => obj.onclick = onDeleteButtonClick(obj));

if (allDialogs) {
    dialog = new MDCDialog(allDialogs);
}

addPickButton?.click(() => dialog?.open());
