import sys
import os
import allure
import uuid
from allure_commons.types import AttachmentType
from playwright.sync_api import sync_playwright

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)) + '/../../')


def before_all(context):
    pass
    # behave -D HOST="DEV"
    # with allure.step('------------------Старт Контекста------------------'):
    #     context.host = "https://127.0.0.1/"


def before_scenario(context, scenario):
    with allure.step('------------------Старт Сценария------------------'):
        # behave -D BROWSER=chrome
        if 'BROWSER' in context.config.userdata.keys():
            if context.config.userdata['BROWSER'] is None:
                BROWSER = 'chrome'
            else:
                BROWSER = context.config.userdata['BROWSER']
        else:
            BROWSER = 'chrome'

        p = sync_playwright().start()
        context.playwright = p

        # behave -D HEADLESS
        if 'HEADLESS' in context.config.userdata.keys():
            HEADLESS = True
        else:
            HEADLESS = False

        if BROWSER == 'chrome':
            context.browser = p.chromium.launch(headless=HEADLESS)
        elif BROWSER == 'firefox':
            context.browser = p.firefox.launch(headless=HEADLESS)
        elif BROWSER == 'safari':
            context.browser = p.webkit.launch(headless=HEADLESS)
        context.playwright_context = context.browser.new_context()
        context.playwright_context.tracing.start(screenshots=True, snapshots=True, sources=True)


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
#     context.playwright.stop()
