Feature: Сайт.SaveLink. Проверка Формы

  Scenario: Проверка мини формы обратной связи
    Given Я открываю сайт "https://save-link.ru/"
    When Я ввожу "9001001010" в "Телефон"/".card [name="phone"]"
    When Я нажимаю "Оставить заявку"/"[data-form="request-header-form"]"
    Then Вижу "Заявка успешно отправлена"/".request-complete"


# С использованием нескольких параметров
  Scenario Outline: Большая форма. Проверка отправки заявки с валидными данными

    Examples: values
      | name              | company                     | email                           | message                     |
      | Я                 | Я                           | t_es-t@ptnl.moscow              | Я                           |
      | Тест123           | Компания!#$%&'*+-/=?^_`{}~  | TEST@ptnl.moscow                | Описание!#$%&'*+-/=?^_`{}~  |
      | longName(100)     | longName(100)               | testlongName(84)@ptnl.moscow    | longName(1000)              |
      | ТестlongName(46)  | КомпанияlongName(42)        | te.st@ptnl.mos.cow              | Описание(492)               |


    Given Я открываю сайт "https://save-link.ru/"
    When Я ввожу "<name>" в "Имя"/"#partner-name"
    When Я ввожу "9001001010" в "Телефон"/"#partner-phone"
    When Я ввожу "<company>" в "Компания"/"#partner-company"
    When Я ввожу "<email>" в "email"/"#partner-email"
    When Я ввожу "<message>" в "Текст сообщения"/"#partner-message"
    When Я нажимаю "Оставить заявку"/"[data-form="partnership-form"]"
    Then Вижу "Заявка успешно отправлена"/".request-complete._open"

  # C использование одного параметра
  Scenario Outline: Малая форма. Проверка невозможности отправки заявки с номером от 1 до 10 цифр

    Examples: Count of digits
      | value     |
      | 1         |
      | 12        |
      | 123       |
      | 1234      |
      | 12345     |
      | 123456    |
      | 1234567   |
      | 12345678  |
      | 123456789 |

    Given Я открываю сайт "https://save-link.ru/"
    When Я ввожу "<value>" в "Телефон"/".card [name="phone"]"
    When Я нажимаю "Оставить заявку"/"[data-form="request-header-form"]"
    Then Вижу в "Предупреждении"/".card .error" текст = "Неправильно введен номер телефона"
    Then НЕ Вижу "Заявка успешно отправлена"/".request-complete._open"

    # С использованием ввода большого текста
  Scenario: Проверка возможности переноса текста в поле Текст сообщения
    Given Я открываю сайт "https://save-link.ru/"
    When Я ввожу "Тест" в "Имя"/"#partner-name"
    When Я ввожу "9001001010" в "Телефон"/"#partner-phone"
    When Я ввожу "Тестовая" в "Компания"/"#partner-company"
    When Я ввожу "test@ptnl.moscow" в "email"/"#partner-email"
    When Я ввожу большой текст в "Текст сообщения"/"#partner-message":
    """
    Тестовое сообщение
    Добрый день!
    Проверка возможности переноса в поле "Текст сообщения"
    """
    When Я нажимаю "Оставить заявку"/"[data-form="partnership-form"]"
    Then Вижу "Заявка успешно отправлена"/".request-complete._open"

  # С использованием Longname
  Scenario: Большая форма. Проверка невозможности отправки заявки
    Given Дефект "Неверный текст предупреждения"/"https://example.com/"
    Given Я открываю сайт "https://save-link.ru/"
    When Я ввожу "Тест" в "Имя"/"#partner-name"
    When Я ввожу "longName(101)" в "Имя"/"#partner-name"
    When Я ввожу "test@ptnl.moscow" в "email"/"#partner-email"
    When Я ввожу "9001001010" в "Телефон"/"#partner-phone"
    When Я нажимаю "Оставить заявку"/"[data-form="partnership-form"]"
    Then Вижу в "Предупреждении для Email"/".name._error" текст ~ "Количество символов больше 100"
    Then НЕ Вижу "Заявка успешно отправлена"/".request-complete._open"
