const sendMessageButton = $("#send-message-button");
const sendMessageTextField = $("#send-message-text-field");
const chatContent = $("#chat__content");

$(document).ready(() => {
    sendMessageButton.prop("disabled", true);
    scrollContent();
});

$("#chat-form").on('submit', e => {
    e.preventDefault();
    let message = sendMessageTextField.val().trim();
    presentUserMessage(message);
});

sendMessageTextField.on("keyup", () => {
    // remove leading and trailing white spaces from message
    const textToSend = sendMessageTextField.val().trim();

    // enable sending only when text is valid
    if (textToSend !== "")
        sendMessageButton.prop("disabled", false);
    else
        sendMessageButton.prop("disabled", true);
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
        let content = ``;

        for (const movie of message.content) {
            const movieElement = $("#template-movie-card").contents("div")[0].cloneNode(true);

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
    scrollContent();
}

/**
 * Presents user message on chat screen.
 *
 * @param message a text representation of user message
 */
function presentUserMessage(message) {
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

    $.ajax({
        type: "POST",
        url: "/api/chat/reply",
        data: {
            message: message
        },
        success: function (result) {
            const messages = JSON.parse(result);
            for (let i = 0; i < messages.messages.length; i++) {
                // appendMessage(messages.messages[i], true);
                presentBotMessage(messages.messages[i]);
            }
        }
    });

    // reset input text
    sendMessageTextField.val("");
    sendMessageButton.prop("disabled", true);
}

/**
 * Scrolls down to the bottom of the chat content.
 */
function scrollContent() {
    const contentHeight = chatContent.prop("scrollHeight");
    chatContent.animate({scrollTop: contentHeight}, 50);
}
