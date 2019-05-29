import * as Cookies from "js-cookie";

const categorySelect = $('select.select-category');

categorySelect.change(function () {
    let categoryId =  categorySelect.val();
    $("#category-header").html($("select.select-category option:selected").text());

    $.ajax({
        type: "POST",
        url: "/api/expert-picks/response",
        headers: {"X-CSRFToken": Cookies.get("csrftoken")},
        data: {
            category: categoryId
        },
        success: function (result) {
            let html = "";

            for (let i = 0; i < result.picks.length; i++) {
                const messageElement = $("#template-movie-info-row").contents("div")[0].cloneNode(true);
                messageElement.querySelector(".movie-poster > img").setAttribute("src",
                    `https://image.tmdb.org/t/p/w1280${result.picks[i].poster}`);
                messageElement.querySelector(".movie-title > h3").innerHTML = result.picks[i].title;
                html += messageElement.outerHTML;
            }

            $(".expert-picks__content").html(html);
        }
    });
});