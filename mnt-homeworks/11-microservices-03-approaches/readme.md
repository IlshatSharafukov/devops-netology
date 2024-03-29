# Домашнее задание к занятию «Микросервисы: подходы»

### Выполнил Шарафуков Ильшат

## Основная часть

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.


## Задача 1: Обеспечить разработку

Предложите решение для обеспечения процесса разработки: хранение исходного кода, непрерывная интеграция и непрерывная поставка. 
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- облачная система;
- система контроля версий Git;
- репозиторий на каждый сервис;
- запуск сборки по событию из системы контроля версий;
- запуск сборки по кнопке с указанием параметров;
- возможность привязать настройки к каждой сборке;
- возможность создания шаблонов для различных конфигураций сборок;
- возможность безопасного хранения секретных данных (пароли, ключи доступа);
- несколько конфигураций для сборки из одного репозитория;
- кастомные шаги при сборке;
- собственные докер-образы для сборки проектов;
- возможность развернуть агентов сборки на собственных серверах;
- возможность параллельного запуска нескольких сборок;
- возможность параллельного запуска тестов.

Обоснуйте свой выбор.

## Задача 2: Логи

Предложите решение для обеспечения сбора и анализа логов сервисов в микросервисной архитектуре.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- сбор логов в центральное хранилище со всех хостов, обслуживающих систему;
- минимальные требования к приложениям, сбор логов из stdout;
- гарантированная доставка логов до центрального хранилища;
- обеспечение поиска и фильтрации по записям логов;
- обеспечение пользовательского интерфейса с возможностью предоставления доступа разработчикам для поиска по записям логов;
- возможность дать ссылку на сохранённый поиск по записям логов.

Обоснуйте свой выбор.

## Задача 3: Мониторинг

Предложите решение для обеспечения сбора и анализа состояния хостов и сервисов в микросервисной архитектуре.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- сбор метрик со всех хостов, обслуживающих систему;
- сбор метрик состояния ресурсов хостов: CPU, RAM, HDD, Network;
- сбор метрик потребляемых ресурсов для каждого сервиса: CPU, RAM, HDD, Network;
- сбор метрик, специфичных для каждого сервиса;
- пользовательский интерфейс с возможностью делать запросы и агрегировать информацию;
- пользовательский интерфейс с возможностью настраивать различные панели для отслеживания состояния системы.

Обоснуйте свой выбор.

### Ответ:

## Задача 1

Если рассматривать opensource решение, то это jenkins с github (локальным, или тем же gitea) для хранения и версионирования кода и maven для хранения артефактов, из коробоки у дженкинса есть инструмент хранения секретов, есть возможность настраивать всевозможные хуки для запуска пайплайнов, так же можно можно разворачивать агентов на отдельных ВМ.

Платное решение - gitlab cicd, у которого есть свой репозиторий для хранения кода, свое хранилище артефактов и секретов. Так же есть возможность настраивать автоматический запуск. Устанавливать агентов на сторонние вм.

## Задача 2

Можно использовать ELK стек, где в качестве транспорта будет использоваться logstash , централизованным местом хранения и обработки логов выступит elasticsearch, а пользовательским интерфейсом выступит kibana. Kibana позволяет гибко осуществлять поиск по полям, разделять логи по группам и много другого функционала. 

## Задача 3

Самым простым и хорошим решением я вижу использование  Prometheus  для сбора метрик и хранения метрик (есть своя база, но так же можно собирать и в сторонние) с виртуальных машин, а для визуализации и построении дашбордов прекрасно подойдет grafana , которая из коробки умеет отрисовывать метрики из многих источников (в том числе из Prometheus)