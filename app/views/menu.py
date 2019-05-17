class MenuItem:
    def __init__(self, item_type, **kwargs):
        self.type = item_type
        self.url = kwargs.get('url', None)
        self.title = kwargs.get('title', None)
        self.icon = kwargs.get('icon', None)


def create_navigation_menu(_):
    """
    Context processor for creating navigation menu.

    Usage in templates:

    .. code:: python
      {% for item in menu %}
          {{ item.title }}
      {% endif %}

    :param _: ignored, but required request
    :return: a dictionary with list of
    """

    return {
        'menu': [
            MenuItem(item_type='item', url='chat', title='Chat', icon='chat_bubble'),
            MenuItem(item_type='item', url='favorites', title='Favorites', icon='favorite'),
            MenuItem(item_type='item', url='watched', title='Watched', icon='movie'),
            MenuItem(item_type='item', url='expert_picks', title='Expert picks', icon='stars'),
            MenuItem(item_type='divider'),
            MenuItem(item_type='item', url='add_expert_picks', title='Add expert picks', icon='library_add'),
            MenuItem(item_type='item', url='statistics', title='Statistics', icon='bar_chart'),
            MenuItem(item_type='item', url='admin_dashboard', title='Admin dashboard', icon='supervised_user_circle')
        ]
    }
