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
