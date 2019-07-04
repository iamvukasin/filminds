from app.models import User


class MenuItem:
    def __init__(self, item_type, **kwargs):
        self.type = item_type
        self.url = kwargs.get('url', None)
        self.title = kwargs.get('title', None)
        self.icon = kwargs.get('icon', None)
        self.selected = False
        self.visible = False
        self.visible_if = kwargs.get('visible_if', lambda u: True)


SIDE_MENU = [
    MenuItem(item_type='item', url='chat', title='Chat', icon='chat_bubble'),
    MenuItem(item_type='item', url='favorites', title='Favorites', icon='favorite'),
    MenuItem(item_type='item', url='watched', title='Watched', icon='movie'),
    MenuItem(item_type='item', url='expert_picks', title='Expert picks', icon='stars'),
    MenuItem(item_type='divider', visible_if=lambda u: User.is_auth_user_expert(u) or User.is_auth_user_admin(u)),
    MenuItem(item_type='item', url='add_expert_picks', title='Add expert picks', icon='library_add',
             visible_if=User.is_auth_user_expert),
    MenuItem(item_type='item', url='statistics', title='Statistics', icon='bar_chart',
             visible_if=lambda u: User.is_auth_user_expert(u) or User.is_auth_user_admin(u)),
    MenuItem(item_type='item', url='admin_dashboard', title='Admin dashboard', icon='supervised_user_circle',
             visible_if=User.is_auth_user_admin)
]
