Feature: Сайт.SaveLink. Примеры

# С использованием Вижу и НЕ Вижу текст
  Scenario: Проверка перехода на страницу "О нас" из соответствующего блока
    Given Я открываю сайт "https://save-link.ru/"
    When Я нажимаю "О нас в шапке"/".about [href="./about.html"]"
    Then Вижу текст "Цели команды"
    Then НЕ Вижу текст "Аутсорсинг"


# С использованием Вижу и НЕ вижу элемент
  Scenario: Малая форма. Проверка невозможности заполнения номера телефона буквами
    Given Я открываю сайт "https://save-link.ru/"
    When Я ввожу "Номер телефона" в "Телефон"/".card [name="phone"]"
    When Я нажимаю "Оставить заявку"/"[data-form="request-header-form"]"
    Then Вижу "Предупреждение"/".card .error"
    Then НЕ Вижу "Заявка успешно отправлена"/".request-complete._open"


# С использованием ожидания
  Scenario: Проверка интерфейса шапки главной страницы
    Given Я открываю сайт "https://save-link.ru/"
    Then Жду "Завершения анимации слогана"/".copyright._visible". Жду="10000" мс
    Then Сравнить со скрином "/main_header.png"


# C проверкой наличия кнопки
  Scenario: Проверка наличия кнопки "Оставить заявку"
    Given Я открываю сайт "https://save-link.ru/"
    Then Вижу кнопку "Оставить заявку"/"[data-form="request-header-form"]"


# Показательные отличия Вижу в "{name}"/"{selector}" текст ~ "{text}"
  Scenario: Проверка неточного совпадения теста в описании Аутсорсинга
    Given Я открываю сайт "https://save-link.ru/"
    Then Вижу в "Описании Аутсорсинга"/".outsource p" текст ~ "составим и подготовим команду"


# Падающий тест!!! Показательные отличия Вижу в "{name}"/"{selector}" текст = "{text}"
  Scenario: Проверка точного не совпадения теста  в описании Аутсорсинга
    Given Я открываю сайт "https://save-link.ru/"
    Then Вижу в "Описании Аутсорсинга"/".outsource p" текст = "составим и подготовим команду"


# Показательные отличия Вижу в "{name}"/"{selector}" текст = "{text}"
  Scenario: Проверка точного совпадения теста в описании Аутсорсинга
    Given Я открываю сайт "https://save-link.ru/"
    Then Вижу в "Описании Аутсорсинга"/".outsource p" текст = "Индивидуально составим и подготовим команду для спасения вашего проекта:"


# С проверкой класса в элементе
  Scenario: Большая форма. Проверка активации поля ввода Имени
    Given Я открываю сайт "https://save-link.ru/"
    When Я нажимаю "Поле ввода имени"/"#partner-name"
    Then Вижу в "Блоке ввода имени"/".name" класс "_focus"


# C использованием Скрытый
  Scenario: Проверка неотображения тултипа без наведения на элемент
    Given Я открываю сайт "https://save-link.ru/about.html"
    Then Скрытый "тултип"/".tooltip"


# С проверкой точного текущего url
  Scenario: Проверка перехода на страницу "Контакты" из шапки
    Given Я открываю сайт "https://save-link.ru/"
    When Я нажимаю "Услуги"/".header [href="./contacts.html"]"
    Then Текущий URL = "https://save-link.ru/contacts.html"


# С проверкой относительного текущего url
  Scenario: Проверка перехода на страницу "О нас" из  шапки
    Given Я открываю сайт "https://save-link.ru/"
    When Я нажимаю "О нас в шапке"/".header [href="./about.html"]"
    Then Текущий URL ~ "about.html"


# С указанием дефекта
  Scenario: Большая форма. Проверка обязательности полей. Email
    Given Дефект "Неверный текст предупреждения"/"https://example.com/"
    Given Я открываю сайт "https://save-link.ru/"
    When Я ввожу "Тест" в "Имя"/"#partner-name"
    When Я ввожу "9001001010" в "Телефон"/"#partner-phone"

    When Я нажимаю "Оставить заявку"/"[data-form="partnership-form"]"
    Then Вижу в "Предупреждении для Email"/".email._error" текст ~ "Не может быть пустым"
    Then НЕ Вижу "Заявка успешно отправлена"/".request-complete._open"


# С использованием перезагрузки страницы
  Scenario: Малая форма. Проверка очистки поля при обновлении страницы
    Given Я открываю сайт "https://save-link.ru/"
    When Я ввожу "9001001010" в "Телефон"/".card [name="phone"]"

    When Я перезагружаю страницу
    Then Жду "Завершения анимации слогана"/".copyright._visible". Жду="10000" мс
    Then Сравнить со скрином "/main_header.png"


#C использованием паузы
  Scenario: Проверка перехода на страницу "Услуги" из шапки
    Given Я открываю сайт "https://save-link.ru/"
    When Я нажимаю "Услуги в шапке"/".header [href="./services.html"]"
    When Пауза "10"
    Then Сравнить со скрином "/services_header.png"


# С использованием скроллинга
  Scenario: Проверка интерфейса подвала главной страницы
    Given Я открываю сайт "https://save-link.ru/"
    When Я скролю "7" раз по "500"
    Then Сравнить со скрином "/main_footer.png"


# Принудительное использование скриншота
  Scenario: Проверка мини формы обратной связи
    Given Я открываю сайт "https://save-link.ru/"
    When Я ввожу "9001001010" в "Телефон"/".card [name="phone"]"

    When Я нажимаю "Оставить заявку"/"[data-form="request-header-form"]"
    Then Вижу "Заявка успешно отправлена"/".request-complete._open"
    When Скрин


# С использованием сравнения скриншота
  Scenario: Проверка интерфейса главной страницы
    Given Я открываю сайт "https://save-link.ru/"
    Then Жду "Завершения анимации слогана"/".copyright._visible". Жду="10000" мс
    Then Сравнить со скрином "/main_header.png"


# C использованием перехожу по точной ссылке
  Scenario: Проверка заголовка страницы "Контакты"
    Given Я открываю сайт "https://save-link.ru/"

    When Я перехожу по ссылке = "https://save-link.ru/contacts.html"
    Then Вижу в "Заголовке"/"header h2" текст = "Контакты"


# C использованием перехожу по относительной ссылке
  Scenario: Проверка заголовка на странице "Контакты"
    Given Я открываю сайт "https://save-link.ru/"

    When Я перехожу по ссылке ~ "contacts.html"
    Then Вижу в "Заголовке"/"header h2" текст = "Контакты"


# С использованием нажатия на элемент
  Scenario: Проверка перехода на страницу "О нас" из блока на главной странице
    Given Я открываю сайт "https://save-link.ru/"
    When Я нажимаю "Узнать подробнее"/".about .button"
    Then Текущий URL ~ "about.html"


# C использованием наведения
  Scenario: Проверка появления тултипа при наведении на email
    Given Я открываю сайт "https://save-link.ru/about.html"
    Then Скрытый "тултип"/".tooltip"

    When Я навожу на "Вакансии"/".vacancy a"
    Then Вижу "Тултип"/".tooltip"
    Then Вижу в "Тултипе"/".tooltip" текст = "Присоединяйся!"


# С использованием ввода с клавиатуры
  Scenario: Малая форма. Проверка отправки клавишей Enter
    Given Я открываю сайт "https://save-link.ru/"
    When Я ввожу "9001001010" в "Телефон"/".card [name="phone"]"

    When Я нажимаю "Enter" на клавиатуре
    Then Вижу "Заявка успешно отправлена"/".request-complete._open"


# С использованием нажатия на текст
  Scenario: Проверка перехода на страницу "О нас" из соответствующего блока по клику на текст в кнопке
    Given Я открываю сайт "https://save-link.ru/"
    When Я нажимаю на текст "Узнать подробнее"
    Then Текущий URL ~ "about.html"


# С использованием ввода текста
  Scenario: Проверка отображения введенного номера телефона
    Given Я открываю сайт "https://save-link.ru/"
    When Я ввожу "9001001010" в "Телефон"/".card [name="phone"]"
    Then Жду "Завершения анимации слогана"/".copyright._visible". Жду="10000" мс
    Then Сравнить со скрином "/miniform_number.png"


# С использованием клика по координатам
  Scenario: Проверка перехода на страницу "Контакты" кликом из шапки
    Given Я открываю сайт "https://save-link.ru/"
    When Клик по координатам "920", "180"
    Then Текущий URL ~ "contacts.html"


# C использованием кликнуть и тянуть
  Scenario: Проверка возможности выделения текста реквизитов прямоугольным выделением
    Given Я открываю сайт "https://save-link.ru/"
    When Я перехожу по ссылке ~ "contacts.html"
    When Кликнуть и тянуть "40", "580" - "400", "700"
    Then Сравнить со скрином "/requisites.png"

# С указанием random
  Scenario: Большая форма. Проверка обязательности полей. Номер телефона
    Given Я открываю сайт "https://save-link.ru/"

    When Я ввожу "random" в "Имя"/"#partner-name"
    When Я ввожу "test@ptnl.moscow" в "email"/"#partner-email"
    When Я нажимаю "Оставить заявку"/"[data-form="partnership-form"]"
    Then Вижу в "Предупреждении для Телефона"/".phone._error" текст ~ "Не может быть пустым"
    Then НЕ Вижу "Заявка успешно отправлена"/".request-complete._open"







