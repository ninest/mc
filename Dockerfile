# Base Crafty Controller image
FROM registry.gitlab.com/crafty-controller/crafty-4:latest

# Set timezone
ENV TZ=Etc/UTC

# Create unified data folder and symlinks
RUN mkdir -p /crafty_data/{backups,logs,servers,config,import} && \
    ln -sf /crafty_data/backups /crafty/backups && \
    ln -sf /crafty_data/logs /crafty/logs && \
    ln -sf /crafty_data/servers /crafty/servers && \
    ln -sf /crafty_data/config /crafty/app/config && \
    ln -sf /crafty_data/import /crafty/import

# Expose Crafty web interface port
EXPOSE 8000

# Start Crafty
CMD ["python3", "crafty.py"]
