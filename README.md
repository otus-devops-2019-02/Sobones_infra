# Sobones_infra
Sobones Infra repository

Проверяем из локальной консоли подключение к созданной
M: ssh -i ~/.ssh/appuser appuser@<внешний IP VM>

посшле настройки ssh форвардинга 
Пробуем подключаться вновь, добавив в параметры
подключения ключик -A, чтобы явно включить SSH Agent
Forwarding

Для сквозного подключения используем команду

````
ssh -t -i ~/.ssh/1 -A 1@35.207.76.231 ssh 10.156.0.3
````

Для доступа по алиасу необходимо создать файл .ssh/config и добавить туда следующую информацию
````
cat .ssh/config
 Host bastion
   HostName 35.207.76.231
   User 1
Host someinternalhost
   HostName 10.156.0.3
   ProxyJump bastion
   User 1
````

VPN
````
bastion_IP=35.207.76.231
someinternalhost_IP = 10.156.0.3
````

ДЗ занятие 6
данные подключения

````
testapp_IP = 35.198.152.145
testapp_port = 9292
````

Создание ВМ с автозаруском скрипта
````
gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure
--metadata-from-file startup-script=sobones_infra/startup_script.sh
````

Создание правила файервола посредством команды gcloud
````
gcloud compute firewall-rules create default-puma-server --allow=tcp:9292 --target-tags puma-server
````

ДЗ к занятию 7
Выполнено:

Был создан шаблон ubuntu16 для packer c переменными в файле variables.json с приложениями ruby и mongodb
Было создано семейство образов reddit-base в Google Cloud средствами packer
Был создан шаблон immutable для packer с нашим приложением reddit
Создан автозапуск приложения reddit
Было создано семейство образов reddit-full в Google Cloud средствами packer поверх reddit-base

ДЗ к занятию 8
Код терраформа добавление ssh ключей нескольких пользователей
````
resource "google_compute_project_metadata" "ssh_keys" {
  metadata {
    ssh-keys = "user1:${file(var.public_key_path)}\nuser2:${file(var.public_key_path)}"
  }
}
````
После добавления в веб интерфейсе ssh ключ пользователю appuser_web и выполните terraform apply данные ключа удалились


LOADBALANCER

output

````
output "lb_external_ip" {
  value = "${google_compute_forwarding_rule.puma_forwarding_rule.ip_address}"
}
````

ДЗ 9

1) При создании правила фаервола терраформом ошибка была, потому что есть таке имя
2) Задан IP для инстанса с приложением в виде внешнего ресурса
3) созданы два имиджа packer-ом для DB и  APP
4) созданы две машины
5) созданы модули
6) доступ по ssh к  машинам есть
7) созданы Stage & Prod

ДЗ 10 урока
после выполения ansible app -m command -a 'rm -rf reddit' 
и еще раз выполнение плейбука.  один таск со статусом changed:

````
TASK [Clone repo] ***************************************************************************************************
changed: [appserver]
````
ДЗ 11 урока
В процессе сделано:
Работа с одним плейбуком
Работа с несколькими плейбуками

При сборке packer-ом используется provisioner ansible
образ не собирался без использования таска в файлах packer_app.yml packer_db.yml



````
- name: DELETE list lock
    shell: rm /var/lib/apt/lists/lock
````

ДЗ 12 урока
Перенес созданные плейбуки в раздельные роли
Описал два окружения
Использовал коммьюнити роль nginx
Использовал Ansible Vault для наших окружений

