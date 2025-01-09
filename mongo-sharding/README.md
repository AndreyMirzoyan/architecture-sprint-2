# pymongo-api

## Как запустить

Запускаем mongodb и приложение

```shell
docker compose up -d
```

Инициализируем шардирование mongodb (бд - megadb, коллекция - helloDoc)

```shell
./scripts/mongo-init.sh
```

## Как проверить в терминале

Заполняем mongodb тестовыми данными коллекцию helloDoc

```shell
./scripts/mongo-fill.sh
```

Проверяем количество записей в коллекции helloDoc на роутере и на шардах

```shell
./scripts/mongo-check.sh
```

(Опционально) Очищаем коллекцию helloDoc

```shell
./scripts/mongo-clear.sh
```


## Как проверить в браузере

### Если вы запускаете проект на локальной машине

Откройте в браузере http://localhost:8080

### Если вы запускаете проект на предоставленной виртуальной машине

Узнать белый ip виртуальной машины

```shell
curl --silent http://ifconfig.me
```

Откройте в браузере http://<ip виртуальной машины>:8080

### Доступные эндпоинты

Список доступных эндпоинтов, swagger http://<ip виртуальной машины>:8080/docs