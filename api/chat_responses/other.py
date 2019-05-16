from api.chat_responses.builder import TextMessage
from api.chat_responses.response import Response


class ResponseNoIntent(Response):
    """
    Represents a response for non understandable user request.
    """

    def get(self, request):
        message = TextMessage('Sorry, I cannot understand you')
        self.response_builder.add(message)
        return self.response_builder.get_response()


class ResponseGreeting(Response):
    """
    Represents a greeting response.
    """

    def get(self, request):
        message = TextMessage('Hello, how can I help you?')
        self.response_builder.add(message)
        return self.response_builder.get_response()


class ResponseHelp(Response):
    """
    Represents a help response.
    """

    def get(self, request):
        message = TextMessage('Type something...')
        self.response_builder.add(message)
        return self.response_builder.get_response()
