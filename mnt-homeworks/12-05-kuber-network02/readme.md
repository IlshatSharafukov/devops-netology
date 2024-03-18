# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 2»

### Выполнил Шарафуков Ильшат

## Основная часть

### Задание 1. Создать Deployment приложений backend и frontend

1. Создать Deployment приложения _frontend_ из образа nginx с количеством реплик 3 шт.
2. Создать Deployment приложения _backend_ из образа multitool. 
3. Добавить Service, которые обеспечат доступ к обоим приложениям внутри кластера. 
4. Продемонстрировать, что приложения видят друг друга с помощью Service.
5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.

------

### Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера

1. Включить Ingress-controller в MicroK8S.
2. Создать Ingress, обеспечивающий доступ снаружи по IP-адресу кластера MicroK8S так, чтобы при запросе только по адресу открывался _frontend_ а при добавлении /api - _backend_.
3. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
4. Предоставить манифесты и скриншоты или вывод команды п.2.

------

### Ответ:

Задание 1:

Создал [Deployment frontend](src/deployment_frontend.yml), [Service frontend](src/service_frontend.yml), [Deployment backend](src/deployment_backend.yml), [Service backend](src/service_backend.yml).

Скриншот доступности frontend из backend:

![1](img/01.png)

Задание 2:

Подключил ingress с помощью следующей команды:

```commandline
microk8s enable ingress
```
![4](img/04.png)

Создал манифест для [Ingress](src/ingress.yml). Проверил доступность сервиса по пути "/" и "/api":

![2](img/02.png)

![3](img/03.png)
