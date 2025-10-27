# Use official Crafty 4 image
FROM registry.gitlab.com/crafty-controller/crafty-4:latest

# Set timezone
ENV TZ=Etc/UTC
ENV PORT=8000

# Create the persistent unified data directory
RUN mkdir -p /crafty_data/{backups,logs,servers,config,import}

# Make sure Crafty knows where to find its config
# and that all symlinks exist before startup
RUN mkdir -p /crafty/app/config && \
    ln -sf /crafty_data/backups /crafty/backups && \
    ln -sf /crafty_data/logs /crafty/logs && \
    ln -sf /crafty_data/servers /crafty/servers && \
    ln -sf /crafty_data/config /crafty/app/config && \
    ln -sf /crafty_data/import /crafty/import

# Expose Crafty's default web port (Railway auto-maps this)
EXPOSE 8000

# Run the default Crafty startup script (don’t override CMD)
# The image already defines ENTRYPOINT ["python3", "crafty.py"]
# So we only need to ensure it runs with the correct port
CMD ["--port", "${PORT:-8000}"]
