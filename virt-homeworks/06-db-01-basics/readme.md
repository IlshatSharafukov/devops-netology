# Домашнее задание к занятию 1. «Типы и структура СУБД»

## Выполнил Шарафуков Ильшат

### Задание 1:

```
Архитектор ПО решил проконсультироваться у вас, какой тип БД лучше выбрать для хранения определённых данных.

Он вам предоставил следующие типы сущностей, которые нужно будет хранить в БД:

электронные чеки в json-виде,
склады и автомобильные дороги для логистической компании,
генеалогические деревья,
кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации,
отношения клиент-покупка для интернет-магазина.
Выберите подходящие типы СУБД для каждой сущности и объясните свой выбор.
```

### Ответы:

1. Электронные чеки в json-виде - для такого типа данных подойдут документроориентированные NoSQL решения, например MongoDB
2. Склады и автомобильные дороги для логистической компании - поскольку в логистике важны связи, тут нужно использовать какие-либо реляционные БД (pgsql например)
3. Генеалогические деревья - нереляционные графовые ДБ, например Neo4j 
4. Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации - нереляционные БД, используемые для кешированния данных (например Redis)
5. Отношения клиент-покупка для интернет-магазина - нереляционные БД с типом хранения данных "Ключ-значение", например тот же Redis

### Задание 2:

```
Вы создали распределённое высоконагруженное приложение и хотите классифицировать его согласно CAP-теореме. Какой классификации по CAP-теореме соответствует ваша система, если (каждый пункт — это отдельная реализация вашей системы и для каждого пункта нужно привести классификацию):

данные записываются на все узлы с задержкой до часа (асинхронная запись);
при сетевых сбоях система может разделиться на 2 раздельных кластера;
система может не прислать корректный ответ или сбросить соединение.
Согласно PACELC-теореме как бы вы классифицировали эти реализации?
```

### Ответы:

1. Данные записываются на все узлы с задержкой до часа (асинхронная запись) - AP (availability + partition tolerance – consistency) - обеспечивается доступность и устойчивость к разделению, но есть проблемы с согласованностью из-за задержки обновлений. Согласно PACELC теореме данная реализация квалифицируется как PA.

2. При сетевых сбоях система может разделиться на 2 раздельных кластера - CA (availability + consistency – partition tolerance) - обеспечивается консистентность данных и доступность сервиса, но нет устойчивости к разделению вследствие внешних факторов (например сбой сети). Согласно PACELC теореме данная реализация квалифицируется как EC или EL.

3. Система может не прислать корректный ответ или сбросить соединение. - CP (consistency + partition tolerance – availability) - всегда обеспечивается целостность данных и устойчивость к разделению, но доступность будет на втором плане. Согласно PACELC теореме данная реализация квалифицируется как PC. 


### Задание 3:

```
Могут ли в одной системе сочетаться принципы BASE и ACID? Почему?
```

### Ответы:

Не могут, так как принципы BASE и ASID противоречат друг другу. Например, Например, ACID гарантирует консистентность данных после транзакции, BASE же допускает возврат неверных данных.
Данные принципы используются при построении систем, решающих разные бизнес задачи. ACID позволяет строить высоконадежные системы, BASE - позволяет строить высокопроизводительные системы в ущерб надежности.


### Задание 4:

```
Вам дали задачу написать системное решение, основой которого бы послужили:

фиксация некоторых значений с временем жизни,
реакция на истечение таймаута.
Вы слышали о key-value-хранилище, которое имеет механизм Pub/Sub. Что это за система? Какие минусы выбора этой системы?
```

### Ответы:

Redis. Данная БД имеет поддержку механизма pub\sub. Она не хранит у себя сообщения, она отправляет их SUB'ам, и после этого удаляет, поэтому надежность и стабильность такой системы вызывает вопросы. Доставка сообщений до SUB'ов в данном случае негарантированна.


