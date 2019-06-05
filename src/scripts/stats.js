import * as Chartist from 'chartist';
import * as Cookies from "js-cookie";

/**
 * Creates a horizontal bar chart inside the element selected with the
 * selector with provided data.
 * @param {string} selector A CSS selector of chart container.
 * @param {Object} data Data to show on a chart.
 */
function createHorizontalBarChart(selector, data) {
    if (!$(selector).length)
        return;

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
    if (!$(selector).length)
        return;

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
    if (!$(selector).length)
        return;

    var options = {
        low: 0,
        showArea: true
    };

    new Chartist.Line(selector, data, options);
}

function createSampleData() {
    $.ajax({
        type: "POST",
        url: "/api/stats/most_searched",
        headers: {"X-CSRFToken": Cookies.get("csrftoken")},
        success: (data) => {
            mostSearched(data);
            mostFavoured(data);
            mostWatched(data);
            mostPopularGenres(data);
            perDayUsers(data);
        }
    });
}

function mostPopularGenres(data){
    var titles = data.top_genres_names;
    var counts = data.top_genres_counter;
    var split_titles = titles.split(",");
    var split_counts = counts.split(",");
    split_titles.pop();
    var ints = [];
    for (var i = 0 ; i < data.top_genres_number;i++){
        var str = "statistics__item--"+i;
        var num = Number(split_counts[i]);
        var item = {
            className:str, 
            value: num
        };
        ints.push(item);
    }    
    var statisticsGenresData = {
        labels: split_titles,
        series: ints
    };            
    createDonutChart(".statistics__genres", statisticsGenresData);
}

function mostSearched(data){
    var titles = data.most_searched_titles;
    var counts = data.most_searched_counts;
    var split_titles = titles.split(",");
    var split_counts = counts.split(",");
    split_titles.pop();
    var ints = [];
    for (var i = 0 ; i < data.most_searched_number;i++){
        ints.push(Number(split_counts[i]));
    }
    var statisticsSearchedData = {
        labels: split_titles,
        series: [ints]
    };            
    createHorizontalBarChart(".statistics__search", statisticsSearchedData);
}

function mostFavoured(data){
    var titles = data.most_favoured_titles;
    var counts = data.most_favoured_counts;
    var split_titles = titles.split(",");
    var split_counts = counts.split(",");
    split_titles.pop();
    var ints = [];
    for (var i = 0 ; i < data.most_favoured_number;i++){
        ints.push(Number(split_counts[i]));
    }
    var statisticsWishListData = {
        labels: split_titles,
        series: [ints]
    };            
    createHorizontalBarChart(".statistics__wishlist", statisticsWishListData);
}

function mostWatched(data){
    var titles = data.most_watched_titles;
    var counts = data.most_watched_counts;
    var split_titles = titles.split(",");
    var split_counts = counts.split(",");
    split_titles.pop();
    var ints = [];
    for (var i = 0 ; i < data.most_watched_number;i++){
        ints.push(Number(split_counts[i]));
    }
    var statisticsWatchListData = {
        labels: split_titles,
        series: [ints]
    };    
    createHorizontalBarChart(".statistics__watched", statisticsWatchListData);
}

function perDayUsers(data){
    var dates = data.per_day_dates;
    var counts = data.per_day_counts;
    var split_dates = dates.split(",");
    var split_counts = counts.split(",");
    split_dates.pop();
    split_counts.pop();
    var ints = [];
    for (var i = 0 ; i < split_counts.length;i++){
        ints.push(Number(split_counts[i]));
    }
    var statisticsPerDayData = {
        labels: split_dates,
        series: [ints]
    };
    createLineChart(".statistics__users", statisticsPerDayData);
}
$(() => {
    if ($(".statistics").length) {
        createSampleData();
    }
});