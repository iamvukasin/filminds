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
    movieInfoTrailer.attr("href", data.trailer);
    movieInfoRating.text("");  // clear previous ratings
    movieInfoCast.text("");  // clear previous cast

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

// open movie info overlay
$(".movie-info-button").click((e) => {
    const movieId = $(e.target).parent().parent().attr("data-movie-id");

    // fetch the movie
    $.get("/api/movies/info/" + movieId, {}, showMovie);
});

// close movie info overlay
$(".movie-info__close-button").click(() => movieInfoOverlay.removeClass("visible"));
