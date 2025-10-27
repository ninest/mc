FROM registry.gitlab.com/crafty-controller/crafty-4:latest

# Set timezone
ENV TZ=Etc/UTC

# Make sure system tools and pip are ready
USER root
RUN apt-get update && apt-get install -y python3-pip && pip install --upgrade pip

# Install Crafty dependencies manually to ensure all Python packages are available
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt || \
    pip install peewee flask flask_socketio requests cryptography gevent

# Expose the web port (Railway will map it dynamically)
ENV CRAFTY_WEB_USE_SSL=false
ENV CRAFTY_WEB_PORT=${PORT}
EXPOSE 8000

# Create persistent data directories
RUN mkdir -p /crafty_data/{backups,logs,servers,config,import} \
    && chown -R 1000:1000 /crafty_data /crafty

# Set Crafty’s internal data paths
ENV CRAFTY_BACKUPS_DIR=/crafty_data/backups
ENV CRAFTY_LOGS_DIR=/crafty_data/logs
ENV CRAFTY_SERVERS_DIR=/crafty_data/servers
ENV CRAFTY_CONFIG_DIR=/crafty_data/config
ENV CRAFTY_IMPORT_DIR=/crafty_data/import

# Use Crafty’s internal non-root user
USER 1000

# Default command
CMD ["python3", "/crafty/main.py"]
