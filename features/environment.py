import sys
import os
import allure
import uuid
from allure_commons.types import AttachmentType
from playwright.sync_api import sync_playwright
from steps.preconditional import step_visit

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)) + '/../../')


# def before_all(context):
#     pass


def before_scenario(context, scenario):
    with allure.step('------------------Старт Сценария------------------'):
        if 'HOST' in context.config.userdata.keys():
            context.host = context.config.userdata['HOST']
        else:
            context.host = ""

        # behave -D BROWSER=chrome
        if 'BROWSER' in context.config.userdata.keys():
            BROWSER = context.config.userdata['BROWSER']
        else:
            BROWSER = 'chrome'

        p = sync_playwright().start()
        context.playwright = p

        # behave -D HEADLESS
        HEADLESS = True if 'HEADLESS' in context.config.userdata.keys() else False

        if BROWSER == 'chrome':
            context.browser = p.chromium.launch(headless=HEADLESS)
        elif BROWSER == 'firefox':
            context.browser = p.firefox.launch(headless=HEADLESS)

        context.playwright_context = context.browser.new_context()
        context.playwright_context.tracing.start(screenshots=True, snapshots=True, sources=True)

        # Если передали хост, то сразу начинаем с визита на него
        if context.host != "":
            step_visit(context, context.host)


def after_scenario(context, scenario):
    with allure.step('------------------Финиш Сценария------------------'):
        try:
            name = str(uuid.uuid4())
            allure.attach(context.page.screenshot(path=f"{name}.png"), name=f"{name}.png",
                          attachment_type=AttachmentType.PNG)
            allure.attach(context.playwright_context.tracing.stop(path=f'{name}.zip'), name=f'{name}.zip')
            context.browser.close()
            context.playwright.stop()
        except:
            context.browser.close()
            context.playwright.stop()

# def after_all(context):
#     Example for clean data after autotest:
#     """
#     from helpers.api import Api
#     from helpers.prepare import get_prefics
#
#     api = Api(context.host)
#     for i in range(0, 300):
#         response = api.get(context.host + 'api/v1/entity'),
#                                 params={"name": get_prefics()})
#         if responce.status_code > 299:
#             continue
#         rows = response.json()['rows']
#         if len(rows) < 1:
#             return
#         for row in rows:
#             api.delete(context.host + 'api/v1/entity/' + str(row['id']), params={"hard": True}
#
#     """
