FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Mises à jour + paquets
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends \
      sudo python3-pip pipx git python3-venv ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Utilisateur admin avec sudo NOPASSWD (pas besoin de mot de passe pour sudo)
RUN useradd -m -s /bin/bash admin && \
    echo "admin ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-admin && \
    chmod 0440 /etc/sudoers.d/90-admin

# /home/admin et PATH local bin
RUN echo 'export PATH=$PATH:/home/admin/.local/bin' >> /home/admin/.profile && \
    chown -R admin:admin /home/admin

# Conteneur qui reste up
CMD ["sleep", "infinity"]
