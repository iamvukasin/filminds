import * as Cookies from "js-cookie";

const sendMessageButton = $("#send-message-button");
const sendMessageTextField = $("#send-message-text-field");
const chatContent = $("#chat__content");

const delayBetweenMessages = 800;

$(document).ready(() => {
    sendMessageButton.prop("disabled", true);
    scrollContent();
});

$("#chat-form").on("submit", (e) => {
    e.preventDefault();
    let message = sendMessageTextField.val().trim();
    presentUserMessage(message);
});

sendMessageTextField.on("keyup", () => {
    // remove leading and trailing white spaces from message
    const textToSend = sendMessageTextField.val().trim();

    // enable sending only when text is valid
    if (textToSend !== "") {
        sendMessageButton.prop("disabled", false);
    } else {
        sendMessageButton.prop("disabled", true);
    }
});

/**
 * Presents bot message on chat screen. Message can be of text or data type.
 *
 * @param message JSON representation of bot message
 */
function presentBotMessage(message) {
    const lastElement = chatContent.children().last();
    let messageElement;

    if (message.type === 'text') {
        messageElement = $("#template-bot-message").contents("div")[0].cloneNode(true);
        messageElement.querySelector(".message").innerText = message.content;
        messageElement = messageElement.outerHTML;
    } else {
        let content = "";

        for (const movie of message.content) {
            const movieElement = $("#template-movie-card").contents("div")[0].cloneNode(true);

            // make favorite or watched buttons active if movie collected
            if (movie.watched) {
                movieElement.querySelector(".movie-watched-button").classList.add("active");
            } else if (movie.favorite) {
                movieElement.querySelector(".movie-favorite-button").classList.add("active");
            }

            movieElement.setAttribute("data-movie-id", movie.id);
            movieElement.querySelector(".movie-card__backdrop").setAttribute("src", movie.backdrop);
            movieElement.querySelector(".movie-card__title").innerText = movie.title;
            movieElement.querySelector(".movie-card__description").innerText = movie.overview;

            content += movieElement.outerHTML;
        }

        messageElement = `<div class="message__movie-list">${content}</div>`;
    }

    if (!lastElement || !lastElement.children().first().hasClass("message__item--bot")) {
        // last message was from user
        const messageList = $("#template-bot-message-list").contents("div")[0].cloneNode(true);
        messageList.innerHTML += messageElement;
        chatContent.append(messageList);
    } else {
        // last message was from bot
        lastElement.append(messageElement);
    }

    // scroll content to present new message
    setTimeout( () => {
        scrollContent();
    }, 200);
}

/**
 * Presents user message on chat screen and requests for response.
 *
 * @param message a text representation of user message
 */
function presentUserMessage(message) {
    appendUserMessage(message);

    $.ajax({
        type: "POST",
        url: "/api/chat/reply",
        headers: {"X-CSRFToken": Cookies.get("csrftoken")},
        data: {
            message: message
        },
        success: function (result) {
            for (let i = 0; i < result.messages.length; i++) {
                setTimeout(() => presentBotMessage(result.messages[i]), i * delayBetweenMessages);
            }
        }
    });

    // reset input text
    sendMessageTextField.val("");
    sendMessageButton.prop("disabled", true);
}

/**
 * Presents user message on chat screen.
 *
 * @param message a text representation of user message
 */
function appendUserMessage(message) {
    const lastElement = chatContent.children().last();

    const messageElement = $("#template-user-message").contents("div")[0].cloneNode(true);
    messageElement.querySelector(".message").innerText = message;

    if (!lastElement || !lastElement.children().first().hasClass("message__item--user")) {
        // last message was from bot
        chatContent.append(`<div class="message__list">${messageElement.outerHTML}</div>`);
    } else {
        // last message was from user
        lastElement.append(messageElement.outerHTML);
    }

    // scroll content to present new message
    scrollContent();
}

/**
 * Scrolls down to the bottom of the chat content.
 */
function scrollContent() {
    const contentHeight = chatContent.prop("scrollHeight");
    chatContent.animate({scrollTop: contentHeight}, 50);
}

function loadMessages() {
    $.ajax({
        type: "POST",
        url: "/api/chat/load",
        headers: {"X-CSRFToken": Cookies.get("csrftoken")},
        success: function (result) {
            for (const message of result) {
                if (message.sender_type === "U") {
                    for (const singleMessage of message.content.messages) {
                        appendUserMessage(singleMessage.content);
                    }
                } else {
                    for (const singleMessage of message.content.messages) {
                        presentBotMessage(singleMessage);
                    }
                }
            }
        }
    });
}

$(() => {
    if ($(".chat").length) {
        loadMessages();
    }
});
