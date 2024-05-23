# simpleE2E

****
## Введение

Пример простой и быстрой реализации E2E автотестов web приложения, силами команды ручного тестирования 
(программирования почти нет)

Используется python + playwright + gherkin + behave

Документация инструментов:
1. https://playwright.dev/python/docs/intro
2. https://behave.readthedocs.io/en/latest/

Основная идея в том, что можно подготовить конечный список универсальных шагов, 
из которых можно собирать тесты

Селекторы указываются непосредственно в шагах теста 
(удобно если элементы вашего приложения имеют атрибуты data-test-id)

Подробнее см в статье: https://habr.com/ru/articles/816597/
****

## Пример теста

```
Feature: Сайт.SaveLink

  Scenario: Большая форма. Проверка обязательности полей. Email
    Given Дефект "Неверный текст предупреждения"/"https://jira.example.com/"
    Given Я открываю сайт "https://save-link.ru/"
    When Я ввожу "Тест" в "Имя"/"#partner-name"
    When Я ввожу "9001001010" в "Телефон"/"#partner-phone"
    When Я нажимаю "Оставить заявку"/"[data-form="partnership-form"]"
    Then Вижу в "Предупреждении для Email"/".email._error" текст ~ "Не может быть пустым"
    Then НЕ Вижу "Заявка успешно отправлена"/".request-complete._open"
```

Другие примеры тестов см в /features/test

****

## Доступные для использования шаги

Шаги делятся на 3 типа:

**Given** - Предусловия. Например
```
Given Я открываю сайт "{url}"
Given Я создаю сущность тест с именем "{entity_name}"
...
```

**When** - Действия
```
When Я нажимаю "{name}"/"{selector}"
When Я нажимаю "{button}" на клавиатуре
When Я нажимаю ПКМ на текст "{text}"
...
```

**Then** - Проверки или ожидания
```
Then Вижу текст "{text}"
Then НЕ Вижу "{name}"/"{selector}"
Then Жду исчезновения прелоадера "{selector}"
Then Сравнить со скрином "{path_screen}"
...
```

Чтобы получить полный список доступных шагов. Выполнить:
```
python steps_bdd.py --output=available_steps
```
В результате работы скрипта будет создан файл index.html с перечнем всех доступных шагов

****

## Дополнительно

1. Ключевые слова

    В шагах для ввода текста (Я ввожу текст, я ввожу большой текст и т.д.) можно использовать ключевые слова:

    **random** - слово будет заменено на сгенерированное: Autotest<метка времени><случайное число>

    **longName(N)** - слово будет заменено на последовательность символов длинной N (последовательность статична)
2. Существует шаг сравнения скриншотов, с определенной точностью. 
В результате шага прикладывается скрин текущего состояния, скрин эталона и разница изображений.
Важно, скрин для сравнения необходимо делать на той же машине, где и будут запускаться тесты (лучше всего скачать эталон из allure после первого запуска)
Реализация нивелирует небольшую разницу в изображениях, но большую не сможет
3. В коде приведены примеры вызовов api, но они представлены только для примера и неработоспособны.
Желательно использовать предусловия для создания сущностей через api + удаление сущностей
4. После выполнения каждого действия теста выполняется скриншот состояния и прикладывается к отчету
5. Подключено аппаратное ускорение. Работает быстрее при наличии дискретной графики

****

## Install
```
install python >=3.10 
pip install -r requirements.txt
playwright install
playwright install-deps
playwright install-deps chromium
```
****

## Run

```
behave
```
Будут запущены все имеющиеся тесты

```
behave /features/test/check_form_sl.feature
```
Будет запущен только файл check_form_sl.feature

```
behave -D HOST="https://save-link.ru/"
```

Будут запущены все тесты, в контекст будет передан адрес https://save-link.ru/

```
behave -f allure_behave.formatter:AllureFormatter -o ./allure_dir/
```

Будут запущены все тесты, со сбором allure отчета

****

## Report

Все результаты теста и прочие артефакты собираются в allure отчет 
(если указывать параметры запуска со сбором allure)

Для просмотра отчетов:
1. Установить Allure (https://allurereport.org/docs/install/)
2. Выполнить команду
```
allure serve ./allure_dir/
```
****

## Delete data

Чтобы почистить лишние артефакты после запуска (скрины, zip архивы) можно выполнить

```
python delete_data.py
```

В будущем удобно реализовать в этом файле дополнительную очистку данных после тестов
****