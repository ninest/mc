# Use the official Crafty Controller image
FROM registry.gitlab.com/crafty-controller/crafty-4:latest

# Set timezone
ENV TZ=Etc/UTC

# Tell Crafty to use plain HTTP and listen on the port Railway provides
ENV CRAFTY_WEB_USE_SSL=false
ENV CRAFTY_WEB_PORT=${PORT}

# Expose a default local port (Railway overrides this dynamically)
EXPOSE 8000

# Create persistent data directories
RUN mkdir -p /crafty_data/{backups,logs,servers,config,import} \
    && chown -R 1000:1000 /crafty_data /crafty

# Point Crafty’s internal paths to the persistent data directory
ENV CRAFTY_BACKUPS_DIR=/crafty_data/backups
ENV CRAFTY_LOGS_DIR=/crafty_data/logs
ENV CRAFTY_SERVERS_DIR=/crafty_data/servers
ENV CRAFTY_CONFIG_DIR=/crafty_data/config
ENV CRAFTY_IMPORT_DIR=/crafty_data/import

# Use Crafty’s non-root user
USER 1000
