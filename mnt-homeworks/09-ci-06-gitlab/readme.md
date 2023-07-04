# Домашнее задание к занятию 13 «Gitlab»

## Выполнил Шарафуков Ильшат

Подготовил к выполнению домашнего задания Gitlab с использованием YC и наполнил его файлами:

![prepare_gitlab](img/0_1.png)

### Основная часть DevOps: 

Перед написанием pipeline необходимо установить и подготовить к работе gitlab-runner по инструкции, предлагаемой самим gitlab:

![prepare_gitlab-runner](img/0_2.png)

pipeline:

![gitlab_pipeline](img/1_1.png)

dockerfile:

![gitlab_dockerfile](img/1_2.png)

Результат выполнения pipeline:

![gitlab_pipeline-result](img/1_3.png)

Образ в container registry:

![gitlab_container-registry](img/1_4.png)

### Product Owner, Developer, Tester:

Создал новый issue с описанием требуемых изменений и label:

![gitlab_issue](img/1_5.png)

Исправил код, сделал коммит в feature branch и после этого сделал merge request:

![gitlab_feature_branch](img/1_6.png)

Сборка выполнилась успешно.

![gitlab_feature_pipeline](img/1_7.png)

После сборки в container registry появился образ моего контейнера, который я выгрузил к себе на отдельную ВМ и запустил чтобы проверить API:

![gitlab_artifact](img/1_8.png)

Данной командой я поднял докер контейнер и пробросил соответсвующий порт до веб сервера:

```
docker run -itd -p 5290:5290 476f454f9ed9
```

В браузере проверил корректность метода get_info нашего API:

![gitlab_api](img/1_8.png)

