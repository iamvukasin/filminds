import json
from abc import ABC, abstractmethod


class Message(ABC):
    @abstractmethod
    def get(self):
        raise NotImplementedError


class TextMessage(Message):
    """
    Textual representation of response message.
    """

    def __init__(self, text):
        self.text = text

    def get(self):
        """
        Retrieves dictionary object for textual message.
        """

        return {'type': 'text', 'content': self.text}


class ResponseBuilder:
    """
    Builder for JSON formatted response.
    """

    def __init__(self):
        self.messages = []

    def add(self, message: Message):
        """
        Adds new message to the response.

        :param message: a message to add to response
        """

        self.messages.append(message.get())

    def get_response(self):
        """
        Retrieves a JSON object of previously added messages.
        """

        data = {'messages': self.messages}
        return json.dumps(data)
