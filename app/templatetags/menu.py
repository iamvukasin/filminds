from django import template

from app.views.menu import SIDE_MENU

register = template.Library()


@register.inclusion_tag('components/menu.html', takes_context=True)
def side_menu(context):
    request = context.request
    menu = []

    for item in SIDE_MENU:
        item.visible = item.visible_if(request.user)
        item.selected = request.resolver_match.url_name == item.url
        menu.append(item)

    return {'menu': menu}
