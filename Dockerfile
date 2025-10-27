FROM registry.gitlab.com/crafty-controller/crafty-4:latest

ENV TZ=Etc/UTC
EXPOSE 8000

# Prepare unified data folder and symlinks
RUN mkdir -p /crafty_data/{backups,logs,servers,config,import} && \
    mkdir -p /crafty/app/config && \
    ln -sf /crafty_data/backups /crafty/backups && \
    ln -sf /crafty_data/logs /crafty/logs && \
    ln -sf /crafty_data/servers /crafty/servers && \
    ln -sf /crafty_data/config /crafty/app/config && \
    ln -sf /crafty_data/import /crafty/import && \
    chown -R 1000:1000 /crafty /crafty_data

# Run as Crafty's internal user
USER 1000
