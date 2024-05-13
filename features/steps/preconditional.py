from behave import *
from helpers.action import ClassAction

use_step_matcher("cfparse")


@Given('Я открываю сайт "{url}"')
def step_visit(context, url):
    context.page = context.playwright_context.new_page()
    page = ClassAction(context)
    context.host = url
    page.visit(url)
