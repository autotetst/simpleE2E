Feature: Сайт.SaveLink

  Scenario: Проверка мини формы обратной связи
    Given Я открываю сайт "https://save-link.ru/"
    When Я ввожу "9001001010" в "Телефон"/".card [name="phone"]"
    When Я нажимаю "Оставить заявку"/"[data-form="request-header-form"]"
    Then Вижу "Заявка успешно отправлена"/".request-complete"


  Scenario: Проверка большой формы обратной связи
    Given Я открываю сайт "https://save-link.ru/"
    When Я ввожу "Тест" в "Имя"/"#partner-name"
    When Я ввожу "9001001010" в "Телефон"/"#partner-phone"
    When Я ввожу "Тестовая" в "Компания"/"#partner-company"
    When Я ввожу "test@ptnl.moscow" в "email"/"#partner-email"
    When Я ввожу "Тестовое сообщение" в "Текст сообщения"/"#partner-message"
    When Я нажимаю "Оставить заявку"/"[data-form="partnership-form"]"
    Then Вижу "Заявка успешно отправлена"/".request-complete"
