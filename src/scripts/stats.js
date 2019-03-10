import * as Chartist from 'chartist';

/**
 * Creates a horizontal bar chart inside the element selected with the
 * selector with provided data.
 * @param {string} selector A CSS selector of chart container.
 * @param {Object} data Data to show on a chart.
 */
function createHorizontalBarChart(selector, data) {
    var options = {
        reverseData: true,
        horizontalBars: true,
        axisY: {
            offset: 70
        }
    };

    new Chartist.Bar(selector, data, options);
}

/**
 * Creates a donut chart inside the element selected with the selector
 * with provided data.
 * @param {string} selector A CSS selector of chart container.
 * @param {Object} data Data to show on a chart.
 */
function createDonutChart(selector, data) {
    var options = {
        donut: true,
        donutWidth: 60,
        donutSolid: true,
        startAngle: 270
    };

    new Chartist.Pie(selector, data, options);
}

/*
 * Creates a line chart inside the element selected with the selector
 * with provided data.
 * @param {string} selector A CSS selector of chart container.
 * @param {Object} data Data to show on a chart.
 */
function createLineChart(selector, data) {
    var options = {
        low: 0,
        showArea: true
    };

    new Chartist.Line(selector, data, options);
}

/*
  Searched statistics
*/
var statisticsSearchedData = {
    labels: ["The Shawshank Redemption", "The Godfather", "12 Angry Men", "Schindler\"s List", "The Good, the Bad and the Ugly",
        "Forrest Gump", "Inception"
    ],
    series: [
        [175, 123, 112, 97, 86, 74, 63]
    ]
};
createHorizontalBarChart(".statistics__search", statisticsSearchedData);

/*
  Watched statistics
*/
var statisticsWatchedData = {
    labels: ["Goodfellas", "City of God", "The Silence of the Lambs", "The Shawshank Redemption", "The Godfather",
        "Life Is Beautiful", "Interstellar"
    ],
    series: [
        [155, 134, 121, 107, 90, 65, 32]
    ]
};
createHorizontalBarChart(".statistics__watched", statisticsWatchedData);

/*
  Wishlist statistics
*/
var statisticsWishlistData = {
    labels: ["Léon: The Professional", "The Matrix", "Fight Club", "The Godfather: Part II", "The Shawshank Redemption",
        "Life Is Beautiful", "Casablanca"
    ],
    series: [
        [179, 154, 132, 99, 88, 64, 51]
    ]
};
createHorizontalBarChart(".statistics__wishlist", statisticsWishlistData);

/*
  Genres statistics
*/
var statisticsGenresData = {
    labels: ["Drama", "Action", "Comedy", "Romance", "Thriller", "Horror", "Sci-Fi"],
    series: [{
            className: "statistics__item--0",
            value: 20
        }, {
            className: "statistics__item--1",
            value: 4
        },
        {
            className: "statistics__item--2",
            value: 12
        }, {
            className: "statistics__item--3",
            value: 24
        },
        {
            className: "statistics__item--4",
            value: 18
        }, {
            className: "statistics__item--5",
            value: 16
        },
        {
            className: "statistics__item--6",
            value: 6
        }
    ]
};
createDonutChart(".statistics__genres", statisticsGenresData);

/*
  User statistics
*/
var statisticsUserData = {
    labels: ["2019-02-01", "2019-02-02", "2019-02-03", "2019-02-04", "2019-02-05", "2019-02-06", "2019-02-07", "2019-02-08", "2019-02-09"],
    series: [
        [267, 192, 45, 56, 111, 23, 75, 89, 162]
    ]
};
createLineChart(".statistics__users", statisticsUserData);
