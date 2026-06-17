# Xray Docker Container with xHTTP

Однослойный Docker контейнер с Xray и поддержкой xHTTP протокола.

## Требования

- Docker
- Docker Compose (опционально)
- TLS сертификат и приватный ключ

## Подготовка

### 1. Сертификаты

Поместите ваши TLS сертификаты в корень проекта:
```bash
cert.pem   # ваш сертификат
key.pem    # ваш приватный ключ
```

### 2. Конфигурация

Отредактируйте `config.json` и замените:
- `"id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"` — на ваш UUID
- Пути к сертификатам (если нужно)

## Использование

### С Docker Compose

```bash
docker-compose up -d
```

### С Docker напрямую

```bash
docker build -t xray-server .
docker run -d \
  --name xray \
  -p 443:443 \
  -p 80:80 \
  -v $(pwd)/config.json:/etc/xray/config.json:ro \
  -v $(pwd)/cert.pem:/etc/xray/cert.pem:ro \
  -v $(pwd)/key.pem:/etc/xray/key.pem:ro \
  xray-server
```

## Логи

```bash
docker logs -f xray
```

## Остановка

```bash
docker-compose down
# или
docker stop xray
```

## Конфигурация

- **Порт 443** — VLESS с XTLS (основной)
- **Порт 80** — HTTP fallback
- **Протокол** — VLESS + XTLS + Vision
- **TLS** — обязателен для работы

## Примечания

- Убедитесь, что используются актуальные версии TLS сертификатов
- Для производства используйте сертификаты от доверенного CA
- Отредактируйте UUID в конфиге на свой

## Ссылки

- [Xray GitHub](https://github.com/XTLS/Xray-core)
- [Документация Xray](https://xtls.github.io/)