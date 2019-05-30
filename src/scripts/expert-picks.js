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

            for (let pick of result.picks) {
                const messageElement = $("#template-movie-info-row").contents("div")[0].cloneNode(true);

                messageElement.setAttribute("data-movie-id", pick.id);
                messageElement.querySelector(".movie-poster > img").setAttribute("src",
                    `https://image.tmdb.org/t/p/w1280${pick.poster}`);
                messageElement.querySelector(".movie-title > h3").innerHTML = pick.title;
                
                if (pick.favorite) {
                    messageElement.querySelector('.movie-favorite-button').classList.add('active');
                } else if (pick.watched) {
                    messageElement.querySelector('.movie-watched-button').classList.add('active');
                }

                html += messageElement.outerHTML;
            }

            $(".expert-picks__content").html(html);
        }
    });
});