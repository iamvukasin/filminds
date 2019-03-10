import { MDCDialog } from "@material/dialog";

const addMovieDialog = new MDCDialog(document.querySelector('#add-movie-dialog'));

function replaceMovieTitle(element, index, promote) {
    var movieTitle = $(element).find(".movie-title h3");
    var newIndex = (promote ? index : index + 2);
    movieTitle.text(movieTitle.text().replace(/^\d+\./, newIndex + "."));
}

function onUpButtonClick(element) {
    return function () {
        var index = $(".expert-pick__up").index(element);
        var expertPicks = $(".expert-pick");

        if (index > 0) {
            replaceMovieTitle(expertPicks[index], index, true);
            replaceMovieTitle(expertPicks[index - 1], index - 1, false);
            $(expertPicks[index]).insertBefore($(expertPicks[index - 1]));
        }
    }
}

function onDownButtonClick(element) {
    return function () {
        var index = $(".expert-pick__down").index(element);
        var expertPicks = $(".expert-pick");

        if (index < expertPicks.length - 1) {
            replaceMovieTitle(expertPicks[index], index, false);
            replaceMovieTitle(expertPicks[index + 1], index + 1, true);
            $(expertPicks[index]).insertAfter($(expertPicks[index + 1]));
        }
    }
}

function onDeleteButtonClick(element) {
    return function () {
        var index = $(".expert-pick__delete").index(element);
        var expertPicks = $(".expert-pick");

        for (var i = index + 1; i < expertPicks.length; i++) {
            replaceMovieTitle(expertPicks[i], i, true);
        }
        $(expertPicks[index]).remove();
    }
}

function onAddButtonClick() {
    addMovieDialog.open();
}

$(".expert-pick__up").each(function (i, obj) {
    obj.onclick = onUpButtonClick(obj);
})

$(".expert-pick__down").each(function (i, obj) {
    obj.onclick = onDownButtonClick(obj);
})

$(".expert-pick__delete").each(function (i, obj) {
    obj.onclick = onDeleteButtonClick(obj);
})

$("#add-pick-button").click(onAddButtonClick);
