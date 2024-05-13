import allure
import time
from allure_commons.types import AttachmentType
import random
import re


def get_prefics():
    return "Autotest"


def get_long_name(count=255):
    Name = "eiaqtzuejxpyyhzvsttqjvcxangombokndqwlfcghvkxydkmzkhixfrnbyluvvhenxhnwrjntimpulkcanjqdtzxbavlfeioetqcjumvaktyaumudrgalweswrdinmqvknxbhkhjftkcgeausaljlvatyvionsxrcyzyzrvuhiswoosfnpsfrwypkjfplullyikvrntdnrldvausgsicovdwawrpnessxjhatymswoqrngfczekqkbgmzhsrhuczkekkanodzglgkkpbmlnorpbdipcceuacivqhfwsijlhpmupgpdjcpgsaklahaouvuawehjbaypgqksqzmbnt"
    return Name[0:count - 1]


def prepare_text(text):
    """
    Метод преобразования текста
    :param text: текст для преобразования
    :return text: текст после преобразования
    Преобразует ключевые слова в текст
    Возможные ключевые слова: random, longName\((\d+)\)
    """
    if "random" in text:
        tmp = get_prefics() + str(time.time_ns()) + str(random.randint(10000, 99000))
        text = text.replace('random', tmp)
    if "longName" in text:
        pattern = r"longName\((\d+)\)"
        match = re.search(pattern, text)
        if match:
            count_symbol = int(match.group(1))
            text = text.replace(f'longName({count_symbol})', get_long_name(count_symbol))
    return text


def allure_attach_png(path, name):
    with open(path, "rb") as image:
        f = image.read()
        b = bytearray(f)
        allure.attach(b, name=name, attachment_type=AttachmentType.PNG)
