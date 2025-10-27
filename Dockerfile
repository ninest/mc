FROM registry.gitlab.com/crafty-controller/crafty-4:latest

# Timezone
ENV TZ=Etc/UTC
EXPOSE 8000

# Create unified volume path with correct ownership
RUN mkdir -p /crafty_data/{backups,logs,servers,config,import} \
    && chown -R 1000:1000 /crafty_data /crafty

# Set Crafty data paths to /crafty_data subfolders
ENV CRAFTY_BACKUPS_DIR=/crafty_data/backups
ENV CRAFTY_LOGS_DIR=/crafty_data/logs
ENV CRAFTY_SERVERS_DIR=/crafty_data/servers
ENV CRAFTY_CONFIG_DIR=/crafty_data/config
ENV CRAFTY_IMPORT_DIR=/crafty_data/import

# Use Crafty's internal non-root user
USER 1000
