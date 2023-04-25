# Playbook для установки  ClickHouse и Vector операционной системы centOS7.

## Краткое описание
Playbook устанавливает на указанные в inventory файле хосты [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) (после установки так же происходит инициализация БД) и [Vector](https://www.youtube.com/watch?v=CgEhyffisLY)

RPM файлы для установки скачиваются с https://packages.clickhouse.com/rpm/stable и https://packages.timber.io/vector/


## Запуск playbook

- Для запуска необходимо вписать в inventory/prod.yml IP адреса хостов, на которых необходимо установить ClickHouse и Vector.
- После чего запускаем playbook командой:
```
ansible-playbook -i {путь до файла}/inventory/prod.yml {путь до файла}/site.yml
```
- Для установки одной из утилит воспользуйтесь тегами "clickhouse" или "vector"
- Для выбора версии утилиты, измените соответствующее значение в group_vars/clickhouse/vars.yml для clickhouse и vector