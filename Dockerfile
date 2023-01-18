FROM registry.gitlab.com/shardeum/server:dev

ARG RUNDASHBOARD=y
ENV RUNDASHBOARD=${RUNDASHBOARD}

# Install sudo
RUN apt update && apt install -y sudo

# Create node user
RUN usermod -aG sudo node && \
  echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
  mkdir -p /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share && \
  chown -R node /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
USER node

# Copy cli src files as regular user
WORKDIR /home/node/app
COPY --chown=node:node . .

RUN ln -s /usr/src/app /home/node/app/validator || sudo ln -s /usr/src/app /home/node/app/validator

# Start entrypoint script as regular user
CMD ["./entrypoint.sh"]
