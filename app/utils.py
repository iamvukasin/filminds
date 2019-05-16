def trim_text_by_sentence(text: str, max_length: int) -> str:
    """
    Trims the given text to the maximum length with respect to
    sentences in the text. If not applicable, trims the text with
    respect to words and keeps the longest length possible.

    :param text: a text to trim
    :param max_length: maximum length of the result string
    :return: trimmed text
    """

    text = text[:max_length]
    stop_index = max(text.rfind('.'), text.rfind('!'), text.rfind('?'))

    # sentence stop is not found within first max_length
    # of the text - try to cut until the last space
    if stop_index == -1:
        stop_index = text.rfind(' ')
        text = text[:stop_index] + '…'
    else:
        text = text[:stop_index + 1]

    return text
