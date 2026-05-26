# AutoService / Автосервис «ТУРБО»

Информационная система автосервиса для работы с клиентами, автомобилями, диагностикой, заказ-нарядами, услугами и складом запчастей. Проект включает клиентское Flutter-приложение, REST API на FastAPI, публичную веб-страницу и настольное WPF-приложение для сотрудников.

## Содержание

- [Назначение проекта](#назначение-проекта)
- [Возможности системы](#возможности-системы)
- [Архитектура](#архитектура)
- [Технологии](#технологии)
- [Структура проекта](#структура-проекта)
- [Роли пользователей](#роли-пользователей)
- [Требования](#требования)
- [Подготовка базы данных](#подготовка-базы-данных)
- [Запуск backend API](#запуск-backend-api)
- [Запуск Flutter-приложения](#запуск-flutter-приложения)
- [Запуск WPF-приложения](#запуск-wpf-приложения)
- [Запуск веб-страницы](#запуск-веб-страницы)
- [API](#api)
- [Основные пользовательские сценарии](#основные-пользовательские-сценарии)
- [Конфигурация](#конфигурация)
- [Сборка и распространение](#сборка-и-распространение)

## Назначение проекта

`AutoService` автоматизирует взаимодействие клиента с автосервисом и внутреннюю работу сотрудников:

- клиент регистрируется, добавляет автомобили и записывается на диагностику;
- посетитель сайта просматривает услуги и оставляет заявку на обратный звонок;
- менеджер ведет клиентов, автомобили, услуги, заявки и заказ-наряды;
- администратор управляет пользователями и ключевыми справочниками;
- механик работает с заказами, диагностикой, услугами и необходимыми запчастями;
- кладовщик отслеживает остатки, движения запчастей, аналитику и уведомления.

Все прикладные компоненты используют общие данные автосервиса в базе `AutoServiceDB` на Microsoft SQL Server.

## Возможности системы

### Клиентское приложение

Flutter-приложение предоставляет клиенту:

- регистрацию и вход в личный кабинет;
- просмотр и редактирование профиля;
- смену пароля;
- добавление, редактирование и удаление автомобилей;
- выбор автомобиля и свободного времени для диагностики;
- просмотр истории записей и их статусов;
- отмену записи.

### Настольное приложение сотрудников

WPF-приложение включает рабочие места сотрудников:

- управление пользователями и ролями;
- учет клиентов и автомобилей;
- ведение услуг автосервиса;
- обработку записей на диагностику;
- работу с заказ-нарядами и их позициями;
- учет запчастей и движений по складу;
- просмотр уведомлений;
- аналитику расхода запчастей;
- обработку заявок на обратный звонок;
- формирование отчетных данных и выгрузок.

### Публичная веб-страница

В составе backend хранится сайт автосервиса «ТУРБО», на котором доступны:

- презентация автосервиса;
- динамический список услуг;
- форма заявки на обратный звонок.

### REST API

FastAPI-сервис обеспечивает:

- регистрацию и авторизацию по JWT;
- работу с профилем клиента;
- CRUD-операции для автомобилей;
- создание и получение записей на диагностику;
- расчет свободных временных слотов;
- выдачу каталога услуг;
- прием и обработку заявок на обратный звонок;
- интерактивную OpenAPI-документацию.

## Архитектура

```text
                 +---------------------------+
                 |  Публичная веб-страница   |
                 | HTML / CSS / JavaScript   |
                 +-------------+-------------+
                               |
                               | HTTP
                               v
+----------------------+  +---------------------------+
| Flutter-приложение   |  | FastAPI REST API          |
| Личный кабинет       +->| Авторизация и записи      |
+----------------------+  +-------------+-------------+
                                      |
                                      | SQLAlchemy / pyodbc
                                      v
                            +---------------------------+
                            | Microsoft SQL Server      |
                            | AutoServiceDB             |
                            +-------------+-------------+
                                      ^
                                      | Entity Framework 6
                                      |
                            +---------------------------+
                            | WPF-приложение сотрудников|
                            +---------------------------+
```

## Технологии

| Компонент | Стек |
| --- | --- |
| Backend | Python, FastAPI, Uvicorn, SQLAlchemy, pyodbc, JWT, bcrypt |
| Мобильный/кроссплатформенный клиент | Flutter, Dart, Provider, HTTP, Shared Preferences |
| Desktop-клиент | C#, WPF, .NET Framework 4.7.2, Entity Framework 6 |
| Отчеты и аналитика desktop | ClosedXML, OpenXML, LiveCharts |
| Веб-страница | HTML, CSS, JavaScript |
| Хранилище данных | Microsoft SQL Server / SQL Server Express |

## Структура проекта

```text
stas/
├── autoservice-backend/              # REST API и публичная веб-страница
│   ├── app/
│   │   ├── main.py                   # Точка входа FastAPI
│   │   ├── database.py               # Подключение SQLAlchemy к SQL Server
│   │   ├── models.py                 # ORM-модели
│   │   ├── schemas.py                # Pydantic-схемы
│   │   ├── crud.py                   # Операции с клиентами, авто и записями
│   │   ├── crud_callbacks.py         # Операции с обратными звонками
│   │   ├── routes/                   # HTTP-маршруты API
│   │   └── frontend/                 # Сайт автосервиса
│   └── requirements.txt
├── autoservice_app/                  # Flutter-приложение клиента
│   ├── lib/
│   │   ├── config/                   # URL API и календарные настройки
│   │   ├── models/                   # Модели клиента, авто и записей
│   │   ├── providers/                # Состояние авторизации
│   │   ├── screens/                  # Экраны приложения
│   │   ├── services/                 # Вызовы API
│   │   ├── utils/                    # Форматирование и валидация
│   │   └── main.dart                 # Точка входа Flutter
│   └── pubspec.yaml
└── AutoServiceApp/                   # WPF-приложение сотрудников
    ├── AutoServiceApp.sln
    ├── AutoServiceApp/
    │   ├── App.config                # Строка подключения Entity Framework
    │   ├── Models/                   # EDMX-модель базы данных
    │   ├── Views/                    # Окна и рабочие представления
    │   ├── Validators/               # Проверки вводимых данных
    │   └── Helpers/                  # Служебная логика склада
    └── AutoServiceInstaller/         # Проект и сборка установщика Windows
```

## Роли пользователей

В настольном приложении роль определяет доступное рабочее место:

| `RoleId` | Роль | Назначение |
| --- | --- | --- |
| `1` | Клиент | Использует клиентское Flutter-приложение |
| `2` | Менеджер | Клиенты, автомобили, диагностика, услуги, заказы, заявки |
| `3` | Администратор | Пользователи, заказы, клиенты, автомобили, диагностика и услуги |
| `4` | Механик | Заказы в работе, диагностика, запчасти, услуги и уведомления |
| `5` | Кладовщик | Склад, движения запчастей, аналитика и уведомления |

## Требования

### Общие

- Windows 10/11 для WPF-приложения и SQL Server Express;
- Microsoft SQL Server или SQL Server Express с экземпляром `SQLEXPRESS`;
- база данных `AutoServiceDB`;
- ODBC Driver 17 for SQL Server.

### Для backend

- Python 3.10 или новее;
- `pip` и виртуальное окружение Python.

### Для Flutter-клиента

- Flutter SDK с Dart SDK `^3.5.0`;
- Android Studio/Android SDK, браузер Chrome или desktop toolchain для выбранной платформы.

### Для WPF-приложения

- Visual Studio с workload `.NET desktop development`;
- .NET Framework 4.7.2 Developer Pack;
- восстановление NuGet-пакетов решения.

## Подготовка базы данных

Проект использует базу `AutoServiceDB`. Подключение по умолчанию настроено для локального SQL Server Express:

```text
localhost\SQLEXPRESS
```

Основные таблицы системы:

| Таблица | Назначение |
| --- | --- |
| `Roles` | Роли пользователей |
| `Users` | Учетные записи и bcrypt-хеши паролей |
| `UserProfiles` | ФИО, телефон и email пользователя |
| `ServiceClients` | Клиенты автосервиса |
| `ServiceClientCars` | Автомобили клиентов |
| `Services` | Каталог работ и услуг |
| `Statuses` | Статусы записей и заказов |
| `Appointments` | Записи клиентов на диагностику |
| `CallbackRequests` | Заявки с публичного сайта |
| `WorkOrders` | Заказ-наряды |
| `WorkOrderItems` | Работы и запчасти заказ-наряда |
| `SpareParts` | Складской каталог запчастей |
| `SparePartMovements` | История поступлений и расхода |
| `Notifications` | Уведомления сотрудников |

Для первоначальной настройки:

1. Создайте в SQL Server базу данных `AutoServiceDB`.
2. Создайте структуру таблиц согласно модели [AutoServiceModel.edmx](AutoServiceApp/AutoServiceApp/Models/AutoServiceModel.edmx).
3. Заполните справочник `Roles` ролями из раздела [Роли пользователей](#роли-пользователей).
4. Заполните `Statuses` статусами рабочих процессов. Для клиентских записей новый объект создается со статусом `StatusId = 1`, отмененная запись использует `StatusId = 4`.
5. Добавьте каталог услуг в `Services`, чтобы он отображался на сайте и в рабочих интерфейсах.

## Запуск backend API

### 1. Создание окружения

В PowerShell из корня проекта:

```powershell
cd autoservice-backend
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

### 2. Настройка подключения

Создайте или заполните файл `autoservice-backend/.env`:

```dotenv
DB_HOST=localhost
DB_INSTANCE=SQLEXPRESS
DB_NAME=AutoServiceDB
DB_USER=
DB_PASSWORD=
```

Подключение backend использует `ODBC Driver 17 for SQL Server` и доверенную Windows-аутентификацию.

### 3. Запуск сервера

```powershell
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

После запуска доступны:

| Адрес | Назначение |
| --- | --- |
| `http://localhost:8000/` | Информация о сервисе |
| `http://localhost:8000/health` | Проверка состояния API |
| `http://localhost:8000/docs` | Swagger UI |
| `http://localhost:8000/redoc` | ReDoc |

## Запуск Flutter-приложения

### 1. Установка зависимостей

```powershell
cd autoservice_app
flutter pub get
```

### 2. Настройка адреса API

Адрес backend находится в файле:

```text
autoservice_app/lib/config/api_config.dart
```

Для запуска в браузере, Windows-приложении или iOS Simulator используйте:

```dart
static const String baseUrl = 'http://localhost:8000';
```

Для Android Emulator используйте адрес хост-машины:

```dart
static const String baseUrl = 'http://10.0.2.2:8000';
```

Для физического мобильного устройства укажите IP-адрес компьютера в локальной сети, например:

```dart
static const String baseUrl = 'http://192.168.1.10:8000';
```

### 3. Запуск

Убедитесь, что backend уже работает, затем выполните:

```powershell
flutter run
```

Дополнительные варианты:

```powershell
flutter run -d chrome
flutter run -d windows
flutter run -d emulator-5554
```

## Запуск WPF-приложения

### Через Visual Studio

1. Откройте решение `AutoServiceApp/AutoServiceApp.sln`.
2. Восстановите NuGet-пакеты решения.
3. Проверьте строку подключения в `AutoServiceApp/AutoServiceApp/App.config`.
4. Выберите проект `AutoServiceApp` как запускаемый.
5. Запустите проект клавишей `F5` или командой `Start`.

Строка подключения по умолчанию использует:

```text
data source=localhost\SQLEXPRESS;initial catalog=AutoServiceDB;integrated security=True;encrypt=False
```

### Через готовую сборку

Готовый исполняемый файл находится в каталоге:

```text
AutoServiceApp/AutoServiceApp/bin/Release/AutoServiceApp.exe
```

### Через установщик

В проект включен Windows-установщик:

```text
AutoServiceApp/AutoServiceInstaller/Release/setup.exe
AutoServiceApp/AutoServiceInstaller/Release/AutoServiceInstaller.msi
```

## Запуск веб-страницы

Файлы публичного сайта находятся в:

```text
autoservice-backend/app/frontend/
```

Сначала запустите backend на порту `8000`, затем откройте страницу через локальный HTTP-сервер:

```powershell
cd autoservice-backend\app\frontend
python -m http.server 8080
```

Откройте в браузере:

```text
http://localhost:8080
```

Страница получает каталог услуг из `GET /services` и отправляет заявки через `POST /callbacks/`.

## API

Backend публикует Swagger-документацию по адресу `http://localhost:8000/docs`. Основные маршруты:

### Авторизация

| Метод | Endpoint | Назначение |
| --- | --- | --- |
| `POST` | `/auth/register` | Регистрация клиента и выдача JWT |
| `POST` | `/auth/login` | Вход и выдача JWT |

Пример регистрации:

```json
{
  "login": "ivanov",
  "password": "Password1",
  "full_name": "Иванов Иван Иванович",
  "email": "ivanov@example.com",
  "phone": "+79161234567"
}
```

### Профиль

| Метод | Endpoint | Назначение |
| --- | --- | --- |
| `GET` | `/users/me/profile` | Получить профиль текущего пользователя |
| `PUT` | `/users/me/profile` | Изменить профиль |
| `PUT` | `/users/me/password` | Изменить пароль |
| `GET` | `/users/{user_id}/cars` | Получить автомобили пользователя |

Защищенные запросы передают токен:

```http
Authorization: Bearer <access_token>
```

### Автомобили

| Метод | Endpoint | Назначение |
| --- | --- | --- |
| `POST` | `/cars/` | Добавить автомобиль |
| `GET` | `/cars/client/{client_id}` | Получить автомобили клиента |
| `GET` | `/cars/user/{user_id}` | Получить автомобили пользователя |
| `GET` | `/cars/{car_id}` | Получить автомобиль |
| `PUT` | `/cars/{car_id}` | Изменить автомобиль |
| `DELETE` | `/cars/{car_id}` | Удалить автомобиль |

Пример автомобиля:

```json
{
  "client_id": "00000000-0000-0000-0000-000000000000",
  "brand": "Toyota",
  "model": "Camry",
  "vin": "JTNB11HK303000001",
  "license_plate": "А123ВС78",
  "year": 2020
}
```

### Записи на диагностику

| Метод | Endpoint | Назначение |
| --- | --- | --- |
| `GET` | `/appointments/available-slots?date=YYYY-MM-DD` | Свободные интервалы записи |
| `POST` | `/appointments/` | Создать запись |
| `GET` | `/appointments/user/{user_id}` | Записи пользователя |
| `GET` | `/appointments/` | Все записи |
| `GET` | `/appointments/{appointment_id}` | Одна запись |
| `PUT` | `/appointments/{appointment_id}/cancel` | Отменить запись |
| `PUT` | `/appointments/{appointment_id}/status?status_id={id}` | Изменить статус |
| `DELETE` | `/appointments/{appointment_id}` | Удалить запись |

Запись ведется по рабочим дням с временными интервалами по 30 минут в диапазоне `10:00` - `18:30`.

Пример создания записи:

```json
{
  "user_id": "00000000-0000-0000-0000-000000000000",
  "car_id": "00000000-0000-0000-0000-000000000000",
  "appointment_date": "2026-05-27T10:30:00",
  "notes": "Проверить тормозную систему"
}
```

### Услуги

| Метод | Endpoint | Назначение |
| --- | --- | --- |
| `GET` | `/services` | Получить список доступных услуг |

### Обратный звонок

| Метод | Endpoint | Назначение |
| --- | --- | --- |
| `POST` | `/callbacks/` | Оставить заявку на звонок |
| `GET` | `/callbacks/` | Получить список заявок |
| `GET` | `/callbacks/{request_id}` | Получить заявку |
| `PUT` | `/callbacks/{request_id}/process` | Отметить заявку обработанной |

Пример заявки:

```json
{
  "client_name": "Иван Иванов",
  "phone": "+79161234567",
  "comment": "Нужна консультация по диагностике"
}
```

## Основные пользовательские сценарии

### Клиент

1. Запускает Flutter-приложение.
2. Регистрируется или входит в учетную запись.
3. Заполняет профиль и добавляет автомобиль.
4. Выбирает автомобиль, дату и доступное время диагностики.
5. Следит за статусом записи в разделе истории.
6. При необходимости отменяет запись.

### Посетитель сайта

1. Открывает публичную страницу автосервиса.
2. Просматривает услуги и цены.
3. Заполняет форму обратного звонка.
4. Заявка становится доступна сотрудникам для обработки.

### Сотрудник

1. Входит через WPF-приложение под своей учетной записью.
2. Получает интерфейс в соответствии с назначенной ролью.
3. Ведет клиентов, заявки, записи, заказ-наряды, услуги или складские операции.

## Конфигурация

### Backend

| Параметр `.env` | Описание | Значение по умолчанию |
| --- | --- | --- |
| `DB_HOST` | Сервер SQL Server | `localhost` |
| `DB_INSTANCE` | Экземпляр SQL Server | `SQLEXPRESS` |
| `DB_NAME` | Имя базы данных | `AutoServiceDB` |
| `DB_USER` | Пользователь SQL Server | пусто при Windows-аутентификации |
| `DB_PASSWORD` | Пароль SQL Server | пусто при Windows-аутентификации |

### Desktop

Параметры базы данных находятся в секции `connectionStrings` файла:

```text
AutoServiceApp/AutoServiceApp/App.config
```

### Flutter

Базовый URL API задается в:

```text
autoservice_app/lib/config/api_config.dart
```

## Сборка и распространение

### Backend

Backend запускается как Uvicorn-приложение:

```powershell
cd autoservice-backend
.\venv\Scripts\Activate.ps1
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

### Flutter

Примеры сборки клиента:

```powershell
cd autoservice_app
flutter build apk
flutter build web
flutter build windows
```

Результаты сборки размещаются в каталоге `autoservice_app/build/`.

### WPF

Для выпуска desktop-приложения выберите конфигурацию `Release` в Visual Studio и соберите решение. Сборка приложения размещается в:

```text
AutoServiceApp/AutoServiceApp/bin/Release/
```

Установочный пакет размещается в:

```text
AutoServiceApp/AutoServiceInstaller/Release/
```

## Быстрый старт

```powershell
# 1. Backend
cd autoservice-backend
.\venv\Scripts\Activate.ps1
uvicorn app.main:app --reload --port 8000

# 2. В другом терминале: Flutter-клиент
cd ..\autoservice_app
flutter pub get
flutter run
```

Для работы сотрудников откройте `AutoServiceApp/AutoServiceApp.sln` в Visual Studio либо запустите установленное WPF-приложение.
