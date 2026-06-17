FROM ubuntu:22.04

# Установка зависимостей
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Скачивание последней стабильной версии Xray
RUN wget -qO /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v24.9.1/Xray-linux-64.zip && \
    unzip -q /tmp/xray.zip -d /usr/local/bin/ && \
    rm /tmp/xray.zip && \
    chmod +x /usr/local/bin/xray

# Создание директории конфигурации
RUN mkdir -p /etc/xray

# Копирование конфигурации
COPY config.json /etc/xray/config.json

# Expose порт
EXPOSE 443

# Запуск Xray
CMD ["/usr/local/bin/xray", "-c", "/etc/xray/config.json"]