import requests
import allure
from helpers.prepare import func_allure_req


class Api:
    host = ""

    def __init__(self, host):
        self.host = host

    def _headers(self):
        return {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json"
        }

    def post(self, path, headers=None, **kwargs):
        """
        :param path: путь к api запроса + resource + метод
        :param headers: заголовки запроса, по умолчанию будут указаны дефолтные
        :param kwargs: опции метода post
        :return: объект response
        """
        if headers is None:
            headers = self._headers()
        with allure.step(f"POST {path}"):
            response = requests.post(url=self.host + path, headers=headers, **kwargs)
            func_allure_req(response)
            return response

    def get(self, path, headers=None, **kwargs):
        """
        :param path: путь к api запроса + resource + метод
        :param headers: заголовки запроса, по умолчанию будут указаны дефолтные
        :param kwargs: опции метода get
        :return: объект response
        """
        if headers is None:
            headers = self._headers()
        with allure.step(f"GET {path}"):
            response = requests.get(url=self.host + path, headers=headers, **kwargs)
            func_allure_req(response)
            return response

    def put(self, path, headers=None, **kwargs):
        """
        :param path: путь к api запроса + resource + метод
        :param headers: заголовки запроса, по умолчанию будут указаны дефолтные
        :param kwargs: опции метода put
        :return: объект response
        """
        if headers is None:
            headers = self._headers()
        with allure.step(f"PUT {path}"):
            response = requests.put(url=self.host + path, headers=headers, **kwargs)
            func_allure_req(response)
            return response

    def delete(self, path, headers=None, **kwargs):
        """
        :param path: путь к api запроса + resource + метод
        :param headers: заголовки запроса, по умолчанию будут указаны дефолтные
        :param kwargs: опции метода delete
        :return: объект response
        """
        if headers is None:
            headers = self._headers()
        with allure.step(f"DELETE {path}"):
            response = requests.delete(url=self.host + path, headers=headers, **kwargs)
            func_allure_req(response)
            return response
