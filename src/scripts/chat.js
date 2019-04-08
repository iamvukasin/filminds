const sendMessageButton = $("#send-message-button");
const sendMessageTextField = $("#send-message-text-field");
var textToSend;

$(document).ready(() => {
    sendMessageButton.prop("disabled", true);
    scrollContent();
});


sendMessageButton?.click(() => {
    presentMessage();
});

function presentMessage() {
    const chatContentDiv = $("#chat__content");
    const lastElement = chatContentDiv.children().last();
    const messageElement =
            `<div class="message__item message__item--user">
                <span class="message message--user">${textToSend}</span>
            </div>`;

    if (!lastElement || !lastElement.children().first().hasClass("message__item--user")) {
        // last message was from bot
        chatContentDiv.append(`<div class="message__list">${messageElement}</div>`);
    } else {
        // last message was from user
        lastElement.append(messageElement);
    }

    // scroll down to present new message
    scrollContent();

    // reset input text
    sendMessageTextField.val("");
    textToSend = "";
    sendMessageButton.prop("disabled", true);
}

function scrollContent() {
    const contentHeight = $("#chat__content").height();
    $("#chat__content").animate({ scrollTop: contentHeight }, 50);
}

sendMessageTextField.on("keyup", (event) => {
    if (event.key == "Enter") {
        if (textToSend != "")
            presentMessage();
    } else {
        // remove leading and trailing white spaces from message
        textToSend = sendMessageTextField.val().trim();

        // enable sending only when text is valid
        if (textToSend != "")
            sendMessageButton.prop("disabled", false);
        else 
            sendMessageButton.prop("disabled", true);
    }
});
