import * as Chartist from "chartist";
import * as Cookies from "js-cookie";

function onlyIntegerLabelInterpolation(value) {
    // returns a space to keep grid lines for non-integer values on the axis
    return (isNaN(value) || value % 1 === 0) ? value : ' ';
}

/**
 * Creates a horizontal bar chart inside the element selected with the
 * selector with provided data.
 * @param {string} selector A CSS selector of chart container.
 * @param {Object} data Data to show on a chart.
 */
function createHorizontalBarChart(selector, data) {
    if (!$(selector).length) {
        return;
    }

    const options = {
        reverseData: true,
        horizontalBars: true,
        axisX: {
            labelInterpolationFnc: onlyIntegerLabelInterpolation
        },
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
    if (!$(selector).length) {
        return;
    }

    const options = {
        donut: true,
        donutWidth: 60,
        donutSolid: true,
        startAngle: 270
    };

    new Chartist.Pie(selector, data, options);
}

/**
 * Creates a line chart inside the element selected with the selector
 * with provided data.
 * @param {string} selector A CSS selector of chart container.
 * @param {Object} data Data to show on a chart.
 */
function createLineChart(selector, data) {
    if (!$(selector).length) {
        return;
    }

    const options = {
        low: 0,
        step: 1,
        showArea: true,
        axisY: {
            labelInterpolationFnc: onlyIntegerLabelInterpolation
        }
    };

    new Chartist.Line(selector, data, options);
}

$(() => {
    if ($(".statistics").length) {
        $.ajax({
            type: "GET",
            url: "/api/statistics",
            headers: {
                "X-CSRFToken": Cookies.get("csrftoken")
            },
            success: (data) => {
                createHorizontalBarChart(".statistics__search", data["searched"]);
                createHorizontalBarChart(".statistics__watched", data["watched"]);
                createHorizontalBarChart(".statistics__wishlist", data["favorite"]);
                createDonutChart(".statistics__genres", data["genres"]);

                // admin can only see statistics for number of
                // registered users per day
                if (data["users"]) {
                    createLineChart(".statistics__users", data["users"]);
                }
            }
        });
    }
});
