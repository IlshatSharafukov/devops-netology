# Домашнее задание к занятию "Командная оболочка Bash: Практические навыки"

### Цель задания

В результате выполнения этого задания вы:

1. Познакомитесь с командной оболочкой Bash.
2. Используете синтаксис bash-скриптов.
3. Узнаете, как написать скрипт в файл так, чтобы он мог выполниться с параметрами и без.


### Чеклист готовности к домашнему заданию

1. У вас настроена виртуальная машина/контейнер/установлена гостевая ОС семейств Linux, Unix, MacOS.
2. Установлен Bash.


### Инструкция к заданию

1. Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-01-bash/README.md).
2. Заполните недостающие части документа решением задач (заменяйте `???`, остальное в шаблоне не меняйте, чтобы не сломать форматирование текста, подсветку синтаксиса). Вместо логов можно вставить скриншоты по желанию.
3. Для проверки домашнего задания преподавателем в личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем Github.
4. Любые вопросы по выполнению заданий спрашивайте в чате учебной группы и/или в разделе “Вопросы по заданию” в личном кабинете.

### Дополнительные материалы

[Полезные ссылки для модуля "Скриптовые языки и языки разметки"](https://github.com/netology-code/sysadm-homeworks/tree/devsys10/04-script-03-yaml/additional-info)

------

## Задание 1

Есть скрипт:
```bash
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
```

Какие значения переменным c,d,e будут присвоены? Почему?

| Переменная  | Значение | Обоснование |
| ------------- | ------------- | ------------- |
| `c`  | "a+b"  | т.к. перед этими символами не стоит знак '$' и поэтому командной строкой это будет воспринято как сложение двух текстовых элементов. |
| `d`  | "1+2"  | т.к. переменные 'a' и 'b' не были явно определены как целые числа. Поэтому командной строкой это будет воспринято как сложение двух текстовых элементов. |
| `e`  | "3" | т.к. перед двойными скобками стоит знак '$', который означает что все переменные внутри скобок необходимо преобразовать в целые числа.  |

----

## Задание 2

На нашем локальном сервере упал сервис и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным (после чего скрипт должен завершиться). В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на Жёстком Диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:
```bash
while ((1==1)
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
	fi
done
```

### Ваш скрипт:
```bash
var = 1
while ((var==1))
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
    else
        var = $(($var + 1))
	fi
done
```

---

## Задание 3

Необходимо написать скрипт, который проверяет доступность трёх IP: `192.168.0.1`, `173.194.222.113`, `87.250.250.242` по `80` порту и записывает результат в файл `log`. Проверять доступность необходимо пять раз для каждого узла.

### Ваш скрипт:
```bash
array_of_hosts=(192.168.0.1 173.194.222.113 87.250.250.242)

echo  > log.txt

for host in ${array_of_hosts[@]}
do
        for index in {1..5}
        do
                curl -s --connect-timeout 2 http://$host:80 >> log.txt
                echo "\n" >> log.txt
        done
done
```

---
## Задание 4

Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен - IP этого узла пишется в файл error, скрипт прерывается.

### Ваш скрипт:
```bash
#!usr/bin/env bash
array_of_hosts=(192.168.0.1 173.194.222.113 87.250.250.242)
result=0
echo  >log
while ((1==1))
do
        for host in ${array_of_hosts[@]}
        do
                result=($(curl -Is $ip:80 | head -1))
                if ((${result[1]} == 200)) || ((${result[1]} == 301))
                then
                        echo Available
                else
                        echo $host >> Error
                        break
                fi
        done
        break
done
```

---

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Мы хотим, чтобы у нас были красивые сообщения для коммитов в репозиторий. Для этого нужно написать локальный хук для git, который будет проверять, что сообщение в коммите содержит код текущего задания в квадратных скобках и количество символов в сообщении не превышает 30. Пример сообщения: \[04-script-01-bash\] сломал хук.

### Ваш скрипт:
```bash
#!/bin/sh

PATTERN="\[\S*-\S*-\S*-\S*\]\s*\S*"
MSG=$(cat "$1")
if  ! [[ $MSG =~ $PATTERN ]]
then
  echo "Bad commit message, see example: [04-script-01-bash] commit-msg"
  exit 1
else
  echo "Goog commit message"
fi
```