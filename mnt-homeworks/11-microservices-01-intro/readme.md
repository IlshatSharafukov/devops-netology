# Домашнее задание к занятию «Введение в микросервисы»

### Выполнил Шарафуков Ильшат

## Основная часть

## Задача 1: Интернет Магазин

Руководство крупного интернет-магазина, у которого постоянно растёт пользовательская база и количество заказов, рассматривает возможность переделки своей внутренней   ИТ-системы на основе микросервисов. 

Вас пригласили в качестве консультанта для оценки целесообразности перехода на микросервисную архитектуру. 

Опишите, какие выгоды может получить компания от перехода на микросервисную архитектуру и какие проблемы нужно решить в первую очередь.

---

### Ответ:

Выгоды:

- Разделение на микросервисы, уменьшит риски при релизах, так как они будут затрагивать только отдельные микросервисы
- Можно более гранулярно распределять ресурсы по микросервисам
- Можно использовать разные стеки для микросервисов
- Более простая масштабируемость и развертывание
- Разделение команды по сервисам, в теории может увеличить скорость релизов, по конкретным сервисам

Проблемы, которые надо решить в первую очередь:

- Что хотим получить от перехода на микросервисы в итоге (метрики по которым, будем оценивать успешность проекта)
- На какие микросервисы будем разбивать монолит и какие стеки будут использоваться внутри
- Как распределить сервисы между командой (определить модель ответсвенности за сервис)
- Как будет осуществляться связь "из вне" с продуктом
- Как будет осуществляться связь между микросервисами продукта
- Где будут храниться артефакты
- Как будет доставлять,собираться и тестировать новый релиз
- Как мониторить и где собирать логи