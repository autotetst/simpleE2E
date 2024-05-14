import uuid
import time
import allure
import SimpleITK as sitk
import os
from allure_commons.types import AttachmentType
from helpers.action import ClassAction
from helpers.prepare import allure_attach_png

from behave import *

use_step_matcher("cfparse")


@when('Я чищу куки')
def step_clean_cookie(context):
    context.playwright_context.clear_cookies()
    step_screen(context)


@Given('Дефект "{short_name}"/"{url}"')
def step_allure(context, url, short_name):
    allure.dynamic.issue(url=url, name=short_name)


@when('Я перезагружаю страницу')
def step_reload_page(context):
    context.page.reload()
    step_screen(context)


@when('Пауза "{sec}"')
def step_pause(context, sec):
    time.sleep(int(sec))
    step_screen(context)


@when('Я скролю до "{name}"/"{selector}"')
def step_scroll_to_element(context, selector, name):
    page = ClassAction(context)
    page.scroll_to_element(context.page.locator(selector=selector), name)
    step_screen(context)


@when('Я скролю "{count}" раз по "{point}"')
def step_scroll_point(context, count, point):
    page = ClassAction(context)
    page.scroll_point(count, point)
    step_screen(context)


@when('Скрин')
def step_screen(context):
    name = str(uuid.uuid4())
    allure.attach(context.page.screenshot(path=f"{name}.png"), name=f"{name}.png", attachment_type=AttachmentType.PNG)


@then('Сравнить со скрином "{path_screen}"')
def step_assert_screen(context, path_screen):
    directory_expect = os.path.dirname(os.path.dirname(__file__)) + "/screens/"

    name_new_screen = str(uuid.uuid4())
    name_expect_screen = path_screen.split("/")[-1]
    context.page.screenshot(path=f"{name_new_screen}.png")

    with allure.step(f'Скрин текущего состояния'):
        allure_attach_png(f"{name_new_screen}.png", name_new_screen)
    with allure.step(f'Скрин эталонный ' + path_screen):
        allure_attach_png(directory_expect + path_screen, name_expect_screen)

    img1 = sitk.ReadImage(directory_expect + path_screen, sitk.sitkUInt8)
    img2 = sitk.ReadImage(f"{name_new_screen}.png", sitk.sitkUInt8)

    name_diff = str(uuid.uuid4())

    # Вычисление разницы между изображениями
    diff = sitk.Abs(img1 - img2)
    sitk.WriteImage(diff, f'{name_diff}.png')
    with allure.step(f'Разница изображений'):
        allure_attach_png(f'{name_diff}.png', name_diff)

    # Вычисление среднего значения разницы
    minMaxFilter = sitk.StatisticsImageFilter()
    minMaxFilter.Execute(diff)

    # Проверка условия сравнения
    if minMaxFilter.GetMean() > 0.1:
        assert 1 == 2, 'Ошибка сравнения скриншотов'
