FROM registry.gitlab.com/crafty-controller/crafty-4:latest

# Set timezone
ENV TZ=Etc/UTC

USER root

# Install pip and required Python packages (no pip upgrade)
RUN apt-get update && apt-get install -y python3-pip && \
    pip install --break-system-packages peewee flask flask_socketio requests cryptography gevent tzdata

# Expose Crafty web port
ENV CRAFTY_WEB_USE_SSL=false
ENV CRAFTY_WEB_PORT=${PORT}
EXPOSE 8000

# Create unified volume path
RUN mkdir -p /crafty_data/{backups,logs,servers,config,import} \
    && chown -R 1000:1000 /crafty_data /crafty

# Set Crafty data paths
ENV CRAFTY_BACKUPS_DIR=/crafty_data/backups
ENV CRAFTY_LOGS_DIR=/crafty_data/logs
ENV CRAFTY_SERVERS_DIR=/crafty_data/servers
ENV CRAFTY_CONFIG_DIR=/crafty_data/config
ENV CRAFTY_IMPORT_DIR=/crafty_data/import

USER 1000

# Default command to launch Crafty
CMD ["python3", "/crafty/main.py"]
