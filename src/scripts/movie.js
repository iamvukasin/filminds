import * as Cookies from "js-cookie";

const movieInfoOverlay = $("#movie-info");
const movieInfoPoster = movieInfoOverlay.find(".movie-info__poster");
const movieInfoTitle = movieInfoOverlay.find(".movie-info__title");
const movieInfoYear = movieInfoOverlay.find(".movie-info__year");
const movieInfoOverview = movieInfoOverlay.find(".movie-info__overview");
const movieInfoTrailer = movieInfoOverlay.find(".movie-info__trailer");
const movieInfoRating = movieInfoOverlay.find(".movie-info__rating");
const movieInfoCast = movieInfoOverlay.find(".movie-info__all-cast");

const castCardTemplate = $("#template-cast-card");

/**
 * Rounds the given number to the nearest 0.5 number.
 *
 * @param number a number
 * @returns {number} the rounded number with precision of 0.5
 */
function roundToHalf(number) {
    return Math.round(2 * number) / 2;
}

/**
 * Appends one star to the movie info rating.
 *
 * @param starType a star type ('star' - filled star, 'star_half' -
 * half star, 'star_bordered' - empty star)
 */
function appendRatingStar(starType) {
    movieInfoRating.append(`<i class="material-icons movie-info__star">${starType}</i>`);
}

/**
 * Shows overflow with movie info.
 *
 * @param data movie data received from the API
 */
function showMovie(data) {
    movieInfoPoster.attr("src", data.poster);
    movieInfoTitle.text(data.title);
    movieInfoYear.text(`(${data.release_date.substring(0, 4)})`);
    movieInfoOverview.text(data.description);
    movieInfoRating.text("");  // clear previous ratings
    movieInfoCast.text("");  // clear previous cast

    if (data.trailer) {
        movieInfoTrailer.show();
        movieInfoTrailer.attr("href", data.trailer);
    } else {
        movieInfoTrailer.hide();
    }

    // add rating
    const movieRating = parseFloat(data.rating);
    const starRating = roundToHalf(movieRating / 2);  // 0-10 rating -> 0-5 stars
    let numAddedStars = Math.floor(starRating);

    for (let i = 0; i < Math.floor(starRating); i++) {
        appendRatingStar("star");
    }

    if (starRating - numAddedStars !== 0) {
        appendRatingStar("star_half");
        numAddedStars++;
    }

    for (let i = numAddedStars; i < 5; i++) {
        appendRatingStar("star_border");
    }

    movieInfoRating.append(`<span class="movie-info__number-rating">${movieRating} / 10</span>`);

    // add cast
    for (const cast of data.cast) {
        const castCard = castCardTemplate.contents("div")[0].cloneNode(true);

        castCard.querySelector(".cast-card__profile").setAttribute("src", cast.profile_path);
        castCard.querySelector(".cast-card__name").innerText = cast.name;
        castCard.querySelector(".cast-card__character").innerText = cast.character;

        movieInfoCast.append(castCard);
    }

    // show overlay
    movieInfoOverlay.addClass("visible");
}

/**
 * Saves movie to favorites or watched list for current user.
 *
 * @param type "favorites" or "watched"
 * @param event the button click event
 */
function onCollectedMovieButtonClick(type, event) {
    const target = $(event.target);
    const parentCard = target.parent().parent();
    const movieId = parentCard.attr("data-movie-id");
    const action = target.hasClass("active") ? "remove" : "add";

    $.ajax({
        type: "GET",
        url: `/api/movies/${type}/${action}/${movieId}`,
        headers: {
            "X-CSRFToken": Cookies.get("csrftoken")
        },
        success: () => {
            // only one button can be active at the same time
            parentCard.find(".movie-watched-button").removeClass("active");
            parentCard.find(".movie-favorite-button").removeClass("active");

            // target button should be changed to active only in the chat
            // and in the expert picks lists - otherwise it must be removed
            // from the page due to not belonging to the current list
            // (eg. a movie shown in the favorites list is removed when
            // the watched button is clicked)
            if ($(".chat").length > 0 || $(".expert-picks").length > 0) {
                if (action === "add") {
                    target.addClass("active");
                }
            } else {
                parentCard.hide();
            }
        }
    });
}

// add or remove favorites movie
$("body").on("click", ".movie-favorite-button", e => onCollectedMovieButtonClick("favorites", e));

// add or remove watched movie
$("body").on("click", ".movie-watched-button", e => onCollectedMovieButtonClick("watched", e));

// open movie info overlay
$("body").on("click", ".movie-info-button", (e) => {
    const movieId = $(e.target).parent().parent().attr("data-movie-id");

    // fetch the movie
    $.ajax({
        type: "GET",
        url: "/api/movies/info/" + movieId,
        headers: {"X-CSRFToken": Cookies.get("csrftoken")},
        success: showMovie
    });
});

// close movie info overlay
$(".movie-info__close-button").click(() => movieInfoOverlay.removeClass("visible"));
