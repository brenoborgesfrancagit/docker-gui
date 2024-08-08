# Use a imagem base do Ubuntu mais recente
FROM ubuntu:latest

# Atualize o sistema e instale pacotes necessários
RUN apt-get update && apt-get install -y \
    x11vnc \
    xvfb \
    openbox \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Copie o arquivo de senha para o contêiner
COPY x11vnc.pass /etc/x11vnc/x11vnc.pass

# Configure o VNC para usar a senha do arquivo
RUN mkdir -p /var/run/dbus \
    && echo "exec openbox-session" > ~/.xinitrc

# Copie o arquivo de configuração do supervisor para o contêiner
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Exponha a porta do VNC
EXPOSE 5900

# Comando para iniciar o supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
