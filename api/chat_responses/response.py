from abc import ABC, abstractmethod

from api.chat_responses.builder import ResponseBuilder


class Response(ABC):
    """
    Represents a response for user request.
    """

    def __init__(self):
        self.response_builder = ResponseBuilder()

    @abstractmethod
    def get(self, request):
        raise NotImplementedError
