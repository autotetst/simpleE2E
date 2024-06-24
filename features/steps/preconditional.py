from behave import *
from helpers.action import ClassAction
from helpers.api import Api
from helpers.prepare import prepare_text

use_step_matcher("cfparse")


@Given('Я открываю сайт "{url}"')
def step_visit(context, url):
    context.page = context.playwright_context.new_page()
    page = ClassAction(context)
    context.host = url
    page.visit(url)


@Given('Я создаю сущность тест с именем "{entity_name}"')
def step_create_entity(context, entity_name):
    api = Api(context.host)
    api.post(path="avi/v1/entities", json={"name": entity_name})


@Given('Я создаю сущность тест')
def step_create_entity_without_name(context):
    entity_name = prepare_text("random")
    api = Api(context.host)
    api.post(path="avi/v1/entities", json={"name": entity_name})


@Given('Я открываю сайт "{url}", "{login}"/"{password}"')
def step_visit_with_auth(context, url, login, password):
    context.page = context.playwright_context.new_page()
    page = ClassAction(context)
    context.host = url
    a = Api(context.host)
    response = a.post(path="/api/v1/login",
                      json={
                            "login": login,
                            "password": password,
                            "is_remember": True
                            }
        )
    token = response.json()["access_token"]
    refresh_token = response.json()["refresh_token"]
    context.playwright_context.add_cookies([
        {"name": "access_token", "value": token,
         'domain': context.host.replace('https://', '').replace('http://', '').replace('/', ''),
         'path': '/'},
        {"name": "refresh_token", "value": refresh_token,
         'domain': context.host.replace('https://', '').replace('http://', '').replace('/', ''),
         'path': '/'}
    ])
    page.visit(url)
