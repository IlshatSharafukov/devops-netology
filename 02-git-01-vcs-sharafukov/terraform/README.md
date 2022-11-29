# Файлы, проигнорированные с помощью .gitignore в директории terraform

1. *.tfstate
*.tfstate.*

Игнорим файлы с расширением tfstate и файлы в названиях которых фигурирует данное слово.

2. crash.log
crash.*.log

Игнорим конкретный файл crash.log и файлы, которые содержат в своем названии crash и имеют расширение .log

3. *.tfvars
*.tfvars.json

Аналогично, игнорим файлы которые оканчиваются на .tfvars и .tfvars.json

4. override.tf
override.tf.json
*_override.tf
*_override.tf.json

Игнорим конкретные файлы: override.tf, override.tf.json, 
Игнорим файлы со следующим окончанием: *_override.tf *_override.tf.json

5. .terraformrc
terraform.rc

Игнорируем конкретные файлы

6.
**/.terraform/*

Игнорируем директорию terraform и все что в неё включено, где бы она не находилась 